---
description: Copia de seguridad de todos tus datos (context, brand-context, projects, clients, loops, memoria Sinapsis) a iCloud/Dropbox/HOME. Uso — /backup
---

# /backup

Guarda todo lo irreemplazable del operador fuera del repo. Lo que git no protege (tu contenido es privado y está gitignored), esto sí.

## Proceso

1. Ejecutar:
   ```bash
   bash scripts/backup.sh
   ```
2. El script decide el destino solo (en este orden): `IAMASTERS_BACKUP_DIR` del `.env` → iCloud Drive → Dropbox → `~/iAmasters-Backup/`. Conserva los últimos 7 backups y borra los más antiguos.
3. Al terminar, di al usuario DÓNDE quedó guardado y cuánto ocupa, en una línea. Sin tecnicismos.
4. Si el script falla, muestra el error tal cual y sugiere `/doctor`.

## Qué incluye

- **Del repo**: `context/`, `brand-context/`, `projects/`, `clients/`, `loops/`, `.env`, skills propias y `settings.json`
- **De Sinapsis global** (`~/.claude/skills/`): operator-state, instincts, daily summaries, catalog, passive rules, install state

## Restaurar

Si el usuario pide restaurar ("restaura mis datos", "recupera el backup del día X", "me he cambiado de Mac"):

1. Lista los backups con `bash scripts/backup.sh --list` y confirma cuál quiere (el más reciente por defecto).
2. **Pide confirmación explícita** antes de copiar nada (vas a sobrescribir su estado actual).
3. Copia el contenido de `<backup>/repo/` sobre el repo y `<backup>/sinapsis/` sobre `~/.claude/skills/`.
4. Sugiere `/doctor` para verificar que todo quedó sano.

## Disparadores en lenguaje natural

"haz un backup", "copia de seguridad", "guarda mis datos", "backup", "respalda todo", "me cambio de ordenador" (este último → restaurar).

## Proactividad

En `/wrap-up`, si el backup más reciente tiene más de 7 días (o no existe ninguno), sugiere en una línea: "Hace más de una semana del último backup — ¿lanzo `/backup`? (30 segundos)". No insistas si dice que no.
