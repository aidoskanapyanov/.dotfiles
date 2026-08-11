# CLAUDE.md

## Behavior

- **Do not modify files or run commands unless explicitly asked.** Read-only operations (reading files, listing directories, web searches) are always fine.
- Clear action language counts as explicit: "do this", "implement", "fix it", "create", "write", "run", "apply", "go ahead", etc.
- Evaluative replies ("good", "looks good", "seems interesting", "nice") are **not** action language — they are feedback, not instruction. When you get one, still ask before acting.
- If the user's message only asks a question ("is there…", "can I…", "how does…", "what is…"), **answer it — do not implement anything.**
- When in doubt whether the user wants action, **ask first.**
