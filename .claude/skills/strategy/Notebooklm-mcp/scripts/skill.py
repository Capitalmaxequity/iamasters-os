import subprocess
import json
import sys

def run(**kwargs):
    """
    Skill runner for NotebookLM MCP.
    Args:
        action (str): The config action (profile, set, get, reset, query).
        key (str): The configuration key / question.
        value (str): The value to set.
        account (str): Optional specific account.
    """
    action = kwargs.get('action', 'get')
    
    if action == 'query':
        question = kwargs.get('question', kwargs.get('key'))
        # Prioritize capitalmaxequity and third as primary ones (same level)
        accounts = [kwargs.get('account')] if kwargs.get('account') else ['capitalmaxequity', 'third', 'default']
        
        print(f"🔍 Starting multi-account research (Primary sources first)...")
        for acc in accounts:
            print(f"\n📡 Querying account: {acc}")
            # Note: Using the parent NotebookLM run.py script for actual querying as it handles browser state
            cmd = ["python", r"c:\dev\mente-tactica-ai\.agent\skills\ai-research\Notebooklm\PleasePrompto\scripts\run.py", "ask_question.py", "--account", acc, "--question", question]
            subprocess.run(cmd)
    
    elif action == 'profile':
        profile = kwargs.get('value', 'standard')
        print(f"Setting NotebookLM profile to: {profile}")
        subprocess.run(["npx", "-y", "notebooklm-mcp@latest", "config", "set", "profile", profile])
    
    elif action == 'set':
        key = kwargs.get('key')
        value = kwargs.get('value')
        subprocess.run(["npx", "-y", "notebooklm-mcp@latest", "config", "set", key, value])
        
    elif action == 'get':
        subprocess.run(["npx", "-y", "notebooklm-mcp@latest", "config", "get"])
        
    elif action == 'reset':
        subprocess.run(["npx", "-y", "notebooklm-mcp@latest", "config", "reset"])

if __name__ == "__main__":
    # Example usage: python skill.py profile minimal
    if len(sys.argv) > 2:
        run(action=sys.argv[1], value=sys.argv[2])
    else:
        run()
