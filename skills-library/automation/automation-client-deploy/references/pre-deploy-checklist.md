# Pre-deploy checklist — el gate antes de empaquetar

> Esta es la **compuerta dura** de la Fase 1. Si algo de "Bloqueantes" falla,
> NO se empaqueta ni se transfiere nada hasta arreglarlo. No es burocracia:
> un secreto filtrado o una base de datos de salud viajando a destino son
> incidentes reales, no avisos.

Trabaja sobre una **copia** del proyecto o sobre el árbol limpio. Ejecuta los
escaneos desde la raíz del proyecto que vas a desplegar.

---

## 1. Bloqueantes (si alguno falla → STOP)

### 1.1 Secretos hardcodeados en el código

Busca claves y tokens incrustados (no en `.env`, sino en el propio código):

```bash
# Patrones de secreto frecuentes. Revisa CADA acierto a mano: puede ser un
# placeholder legítimo ("your-key-here") o un secreto real.
rg -n -i \
  -e 'api[_-]?key\s*[:=]\s*["'\''][A-Za-z0-9_\-]{16,}' \
  -e 'secret\s*[:=]\s*["'\''][A-Za-z0-9_\-]{12,}' \
  -e 'token\s*[:=]\s*["'\''][A-Za-z0-9_\-]{16,}' \
  -e 'password\s*[:=]\s*["'\''][^"'\'' ]{6,}' \
  -e 'sk-[A-Za-z0-9]{20,}' \
  -e 'gsk_[A-Za-z0-9]{20,}' \
  -e 'AKIA[0-9A-Z]{16}' \
  -e 'AIza[0-9A-Za-z_\-]{20,}' \
  -e 'xox[baprs]-[0-9A-Za-z\-]{10,}' \
  -e 'ghp_[A-Za-z0-9]{30,}' \
  -e '-----BEGIN [A-Z ]*PRIVATE KEY-----' \
  --glob '!.venv' --glob '!node_modules' --glob '!.git' . || echo "  (sin coincidencias)"
```

Regla: **toda credencial se lee de variable de entorno**, nunca literal en el
código. Si encuentras una, muévela a `.env` y sustitúyela por `os.getenv(...)`
(o equivalente) antes de seguir. (Instinct del operador: *never hardcode
secrets — use environment variables*.)

### 1.2 El `.env` real NO puede viajar

```bash
# ¿Está .env ignorado por git? (debe estarlo)
git check-ignore .env && echo "  OK: .env gitignored" || echo "  ⚠ .env NO está en .gitignore"

# ¿Hay algún .env trackeado por error?
git ls-files | rg '(^|/)\.env$' && echo "  ⚠ HAY un .env trackeado — quítalo" || echo "  OK: ningún .env trackeado"
```

El secreto se configura **en destino**, copiando `.env.example` → `.env` allí.
El bundle lleva el `.example`, jamás el real.

### 1.3 Datos personales / de salud no pueden viajar

Bases de datos, backups y exports con datos reales se quedan en origen:

```bash
# Lista lo que NO debería ir en el bundle
rg --files | rg -i '\.(db|sqlite|sqlite3|csv|xlsx|dump|sql)$|/backups?/|/uploads?/|\.log$' \
  | rg -v '\.venv|node_modules' || echo "  (nada que excluir — revisa igual a ojo)"
```

Si el sistema maneja **datos de categoría especial (Art. 9 RGPD)** — salud,
biometría, etc. — esto es bloqueante de verdad: el destino arranca con la base
**vacía**; los datos los introduce el cliente allí.

### 1.4 El proyecto arranca desde cero en una máquina limpia

Mentalmente (o de verdad en un dir temporal): clonar/copiar SIN `.venv`,
SIN `node_modules`, SIN `.env`. ¿Hay instrucciones para llegar a "arranca"?
Si no, falta documentación → ve a la sección 2.2.

---

## 2. Requeridos (arréglalos antes de entregar; no bloquean el empaquetado)

### 2.1 `.env.example` completo y en sync con el código

Cada variable que el código lee debe estar en `.env.example` (con valor vacío
o de ejemplo, nunca el real):

```bash
# Variables que el código consume (Python). Adapta el patrón a tu lenguaje.
rg -o -r '$1' "(?:os\.getenv|os\.environ\.get)\(['\"]([A-Z0-9_]+)" -N . | sort -u > /tmp/used_vars.txt
# Variables declaradas en el ejemplo
rg -o -r '$1' '^([A-Z0-9_]+)=' .env.example 2>/dev/null | sort -u > /tmp/example_vars.txt
echo "--- Usadas en código pero NO en .env.example (hay que añadirlas): ---"
comm -23 /tmp/used_vars.txt /tmp/example_vars.txt
```

### 2.2 Dependencias declaradas

- Python: `requirements.txt` (o `pyproject.toml`) presente y con versiones.
- Node: `package.json` + lockfile.
- **Binarios externos** (ffmpeg, ollama, piper, poppler…) que `pip`/`npm` NO
  instalan: deben estar **documentados** en el README con cómo instalarlos en
  el destino. Un import que depende de un binario ausente revienta en destino,
  no en tu PC donde ya lo tienes.

```bash
# Pistas de binarios externos que el código invoca por subprocess/shell
rg -n -i 'subprocess|Popen|os\.system|shutil\.which' --glob '!.venv' --glob '!node_modules' .
```

### 2.3 Higiene del árbol

- Sin `.venv/`, `node_modules/`, `__pycache__/`, `*.pyc`, `.DS_Store` en el bundle.
- Sin rutas absolutas de tu máquina hardcodeadas (`C:\Users\...`, `/home/olaf/...`).

```bash
rg -n -i 'C:\\\\Users\\\\|/home/[a-z]+/|/Users/[a-z]+/' --glob '!.venv' --glob '!node_modules' --glob '!*.md' .
```

---

## 3. Veredicto

Resume al operador en 5 líneas:

```
PRE-DEPLOY — {{proyecto}}
  Bloqueantes:  🟢 0  /  🔴 N   (secretos, .env, datos, arranque-limpio)
  Requeridos:   🟡 M pendientes (.env.example, deps, higiene)
  Veredicto:    LISTO PARA EMPAQUETAR  /  CORREGIR ANTES
```

Si hay 🔴 → no avances. Propón el fix concreto y vuelve a escanear.
