#!/bin/bash
# TDD: observe_v3.py is_error detection (false-positive fix)
# Verifies that content-returning tools (Read/Edit/Write/Grep) no longer trip
# is_error on file content, while real Bash failures and structured errors do.
PASS=0; FAIL=0; TESTS=0
pass(){ PASS=$((PASS+1)); TESTS=$((TESTS+1)); echo "  PASS: $1"; }
fail(){ FAIL=$((FAIL+1)); TESTS=$((TESTS+1)); echo "  FAIL: $1"; }

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OBSERVE_PY="$SCRIPT_DIR/skills/sinapsis-learning/hooks/observe_v3.py"
[ -f "$OBSERVE_PY" ] || OBSERVE_PY="$SCRIPT_DIR/core/observe_v3.py"
PY=python3; command -v python3 >/dev/null 2>&1 || PY=python

SANDBOX=""; cleanup(){ [ -n "$SANDBOX" ] && rm -rf "$SANDBOX"; }; trap cleanup EXIT
SANDBOX=$(mktemp -d); NONGIT="$SANDBOX/work"; mkdir -p "$NONGIT"

echo "=== observe_v3.py is_error Tests ==="
[ -f "$OBSERVE_PY" ] || { echo "  SKIP: observe_v3.py not found"; echo "Results: 0/0"; exit 0; }

run_case(){ # <name> <expected 0|1> <json>
  local name="$1" expect="$2" payload="$3"
  local home="$SANDBOX/h_$TESTS"
  # Pre-create the homunculus dir: observe_v3.py only makes it on the git-success
  # path; our sandbox cwd is non-git, so the fallback write needs the dir to exist
  # (in real installs it always does).
  mkdir -p "$home/.claude/homunculus"
  local obs="$home/.claude/homunculus/observations.jsonl"
  printf '%s' "$payload" | HOME="$home" USERPROFILE="$home" \
    ECC_SKIP_OBSERVE="" ECC_HOOK_PROFILE="" CLAUDE_CODE_ENTRYPOINT="cli" \
    "$PY" "$OBSERVE_PY" post >/dev/null 2>&1
  if [ ! -f "$obs" ]; then fail "$name (no observation written)"; return; fi
  local got
  got=$("$PY" - "$obs" <<'PYEOF'
import sys, json
last=None
for ln in open(sys.argv[1], encoding="utf-8"):
    ln=ln.strip()
    if ln:
        try: last=json.loads(ln)
        except Exception: pass
print("1" if (last or {}).get("is_error") is True else "0")
PYEOF
)
  if [ "$got" = "$expect" ]; then pass "$name (is_error=$got)"
  else fail "$name (expected $expect got $got)"; fi
}

CWD_JSON="$(printf '%s' "$NONGIT" | "$PY" -c 'import json,sys; print(json.dumps(sys.stdin.read()))')"

# (a) Read body containing error/traceback -> FALSE
run_case "Read body with error/traceback" 0 \
  '{"hook_event_name":"PostToolUse","cwd":'"$CWD_JSON"',"tool_name":"Read","tool_input":{"file_path":"/x/app.py"},"tool_response":{"type":"text","file":{"content":"try:\n  pass\nexcept Exception as e:\n  traceback.print_exc()  # error handling"}}}'
# (b) Edit diff containing "error":"..." -> FALSE
run_case "Edit diff containing error literal" 0 \
  '{"hook_event_name":"PostToolUse","cwd":'"$CWD_JSON"',"tool_name":"Edit","tool_input":{"file_path":"/x/h.ts","oldString":"{\"error\":\"boom\"}","newString":"{\"error\":\"failed\"}"},"tool_response":{"filePath":"/x/h.ts","oldString":"\"error\":\"boom\"","newString":"\"error\":\"failed\""}}'
# (c) Bash cat of file mentioning error (stdout, no markers) -> FALSE
run_case "Bash cat output mentions error" 0 \
  '{"hook_event_name":"PostToolUse","cwd":'"$CWD_JSON"',"tool_name":"Bash","tool_input":{"command":"cat notes.txt"},"tool_response":{"stdout":"discusses error handling and exception design","stderr":"","interrupted":false,"isImage":false,"noOutputExpected":false}}'
# (d) Bash pip: command not found in stdout -> TRUE
run_case "Bash command not found (stdout)" 1 \
  '{"hook_event_name":"PostToolUse","cwd":'"$CWD_JSON"',"tool_name":"Bash","tool_input":{"command":"pip install x"},"tool_response":{"stdout":"bash: pip: command not found","stderr":"","interrupted":false,"isImage":false,"noOutputExpected":false}}'
# (e) Bash interrupted==true -> TRUE
run_case "Bash interrupted" 1 \
  '{"hook_event_name":"PostToolUse","cwd":'"$CWD_JSON"',"tool_name":"Bash","tool_input":{"command":"sleep 999"},"tool_response":{"stdout":"","stderr":"","interrupted":true,"isImage":false,"noOutputExpected":false}}'
# (f) Read structured type=error -> TRUE
run_case "Read structured type=error" 1 \
  '{"hook_event_name":"PostToolUse","cwd":'"$CWD_JSON"',"tool_name":"Read","tool_input":{"file_path":"/nope"},"tool_response":{"type":"error","error":"File does not exist: /nope"}}'
# (g) Grep matches containing error -> FALSE
run_case "Grep matches contain error" 0 \
  '{"hook_event_name":"PostToolUse","cwd":'"$CWD_JSON"',"tool_name":"Grep","tool_input":{"pattern":"error"},"tool_response":{"mode":"content","content":"app.py:10: raise ValueError(\"error\")\nlog.py:3: logger.error(\"failed\")"}}'
# (bonus) Bash genuine stderr failure -> TRUE
run_case "Bash stderr failure" 1 \
  '{"hook_event_name":"PostToolUse","cwd":'"$CWD_JSON"',"tool_name":"Bash","tool_input":{"command":"node x.js"},"tool_response":{"stdout":"","stderr":"Error: Cannot find module x","interrupted":false,"isImage":false,"noOutputExpected":false}}'

echo ""; echo "Results: $PASS/$TESTS passed, $FAIL failed"
[ "$FAIL" -gt 0 ] && exit 1; exit 0
