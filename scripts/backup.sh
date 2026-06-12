#!/bin/bash
# ============================================================
#  iAmasters OS — backup.sh
#  Copia de seguridad de TODO lo irreemplazable del operador:
#  - Datos del repo que NUNCA van a git (context/, brand-context/,
#    projects/, clients/, loops/, .env, skills propias)
#  - Memoria Sinapsis global (~/.claude/skills/: operator-state,
#    instincts, daily summaries, catalog, passive rules)
#
#  Destino (primero que exista, o IAMASTERS_BACKUP_DIR del .env):
#    1. iCloud Drive  → iAmasters-Backup/
#    2. Dropbox       → iAmasters-Backup/
#    3. $HOME/iAmasters-Backup/
#
#  Uso:
#    bash scripts/backup.sh           # crea backup fechado
#    bash scripts/backup.sh --list    # lista backups existentes
#  Rotación: conserva los últimos 7 backups, borra los más antiguos.
# ============================================================

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m'
BOLD='\033[1m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_GLOBAL="$HOME/.claude/skills"
KEEP_LAST=7

# ── Resolver destino ──
# Prioridad: IAMASTERS_BACKUP_DIR (del .env) > iCloud > Dropbox > $HOME
if [ -f "$REPO_ROOT/.env" ]; then
    ENV_DEST=$(grep -E '^IAMASTERS_BACKUP_DIR=' "$REPO_ROOT/.env" 2>/dev/null | cut -d= -f2- | tr -d '"' || true)
fi
ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

if [ -n "${ENV_DEST:-}" ]; then
    DEST_ROOT="$ENV_DEST"
elif [ -d "$ICLOUD" ]; then
    DEST_ROOT="$ICLOUD/iAmasters-Backup"
elif [ -d "$HOME/Dropbox" ]; then
    DEST_ROOT="$HOME/Dropbox/iAmasters-Backup"
else
    DEST_ROOT="$HOME/iAmasters-Backup"
fi

if [ "${1:-}" = "--list" ]; then
    echo ""
    echo -e "${BOLD}Backups en: $DEST_ROOT${NC}"
    if [ -d "$DEST_ROOT" ]; then
        ls -1 "$DEST_ROOT" | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}_' | sort -r | sed 's/^/  /' || echo "  (ninguno)"
    else
        echo "  (ninguno todavía)"
    fi
    echo ""
    exit 0
fi

STAMP="$(date +%Y-%m-%d_%H%M%S)"
DEST="$DEST_ROOT/$STAMP"

echo ""
echo -e "${PURPLE}${BOLD}============================================================${NC}"
echo -e "${PURPLE}${BOLD}  iAmasters OS — Backup${NC}"
echo -e "${PURPLE}${BOLD}============================================================${NC}"
echo ""
echo -e "  Destino: ${CYAN}$DEST${NC}"
echo ""

mkdir -p "$DEST/repo" "$DEST/sinapsis"

# ── 1. Datos del operador en el repo (lo que git NO guarda) ──
echo -e "${BLUE}[1/3]${NC} Datos del operador (repo)..."
COPIED=0
for d in "context" "brand-context" "projects" "clients" "loops" ".env" ".claude/skills" ".claude/settings.json"; do
    if [ -e "$REPO_ROOT/$d" ]; then
        mkdir -p "$(dirname "$DEST/repo/$d")"
        cp -R "$REPO_ROOT/$d" "$DEST/repo/$d" 2>/dev/null || true
        COPIED=$((COPIED+1))
    fi
done
echo -e "${GREEN}  OK${NC} $COPIED rutas copiadas"

# ── 2. Memoria Sinapsis global (~/.claude/skills) ──
echo -e "${BLUE}[2/3]${NC} Memoria Sinapsis global..."
SINAPSIS_COPIED=0
for f in "_operator-state.json" "_catalog.json" "_passive-rules.json" "_projects.json" \
         "_instincts-index.json" "_instinct-proposals.json" "_install-state.json" \
         "_daily-summaries"; do
    if [ -e "$SKILLS_GLOBAL/$f" ]; then
        cp -R "$SKILLS_GLOBAL/$f" "$DEST/sinapsis/$f" 2>/dev/null || true
        SINAPSIS_COPIED=$((SINAPSIS_COPIED+1))
    fi
done
echo -e "${GREEN}  OK${NC} $SINAPSIS_COPIED elementos copiados"

# Metadatos para saber de dónde salió
{
    echo "CREATED_AT=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "REPO_ROOT=$REPO_ROOT"
    echo "REPO_COMMIT=$(git -C "$REPO_ROOT" rev-parse HEAD 2>/dev/null || echo unknown)"
    echo "HOSTNAME=$(hostname)"
} > "$DEST/META.txt"

# ── 3. Rotación: conservar últimos N ──
echo -e "${BLUE}[3/3]${NC} Rotación (conservo los últimos $KEEP_LAST)..."
PRUNED=0
while IFS= read -r old; do
    [ -z "$old" ] && continue
    rm -rf "${DEST_ROOT:?}/$old"
    PRUNED=$((PRUNED+1))
done <<< "$(ls -1 "$DEST_ROOT" | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}_' | sort -r | tail -n +$((KEEP_LAST+1)))"
if [ "$PRUNED" -gt 0 ]; then
    echo -e "${GREEN}  OK${NC} $PRUNED backups antiguos eliminados"
else
    echo -e "${GREEN}  OK${NC} Nada que rotar"
fi

SIZE=$(du -sh "$DEST" 2>/dev/null | cut -f1)

echo ""
echo -e "${GREEN}${BOLD}============================================================${NC}"
echo -e "${GREEN}${BOLD}  Backup completado ($SIZE)${NC}"
echo -e "${GREEN}${BOLD}============================================================${NC}"
echo ""
echo -e "  Guardado en: ${CYAN}$DEST${NC}"
echo -e "  Para restaurar en una máquina nueva: clona el repo, instala el OS"
echo -e "  y dile a Claude: ${CYAN}\"restaura mis datos desde el backup de $STAMP\"${NC}"
echo ""
