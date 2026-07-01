---
name: automation-client-deploy
description: Lleva un proyecto construido en local al entorno del cliente (VPS Linux o PC del cliente) de forma segura y repetible. Úsala cuando el usuario diga "despliega esto en el cliente", "súbelo al VPS", "pásalo al servidor", "instálalo en el PC de [cliente]", "llévalo a producción", "ponlo a correr en producción", "empaquétalo para entregar", "cómo se lo entrego al cliente", "transferir el proyecto al destino", "handoff" o "puesta en producción". Cubre 6 fases: pre-deploy checklist (sin secretos, sin datos sensibles), empaquetado (Docker Compose / scripts de arranque), transfer (SCP/rsync para VPS, copia/asistencia remota para PC del cliente), setup remoto (SSH, systemd, Docker, autoarranque en Windows), verificación post-deploy y guía de entrega para el cliente. NO la uses para: arrancar/scaffoldear un proyecto nuevo (eso es `arnes`), montar CI/CD del propio producto del operador, ni crear workflows en n8n (eso es `automation-n8n-builder`).
author: IA Masters Academy
version: 1.0.0
tags: [deploy, entrega, vps, ssh, rsync, docker, systemd, cliente, produccion, handoff, rgpd]
---

# automation-client-deploy — Del local del operador al entorno del cliente

> Olaf construye en su PC; el cliente lo usa en otro sitio (un VPS o su propio
> ordenador). Esta skill cubre ese salto: verificar, empaquetar, transferir,
> instalar, arrancar, verificar de nuevo y entregar un documento que el cliente
> entienda. El objetivo es que el deploy sea **seguro** (sin secretos ni datos
> que viajen) y **repetible** (re-ejecutable cuando haya cambios), no un copiar-
> pegar a ciegas que funciona una vez y nadie sabe reproducir.

---

## Lo que necesito saber antes de empezar

Pregunta lo que falte (2-4 cosas, no un interrogatorio):

1. **¿Qué proyecto?** Ruta en el repo (p.ej. `clients/<cliente>/projects/.../`).
2. **¿A dónde va?** Un VPS Linux (IP/host + acceso SSH) o el PC de una persona
   (qué SO, ¿es técnica?). → esto define el *archetype*, abajo.
3. **¿Qué runtime usa?** Python, Node, etc., y si depende de binarios externos
   (ffmpeg, Ollama, Piper…) o servicios (base de datos, LLM local).
4. **¿Maneja datos personales/sensibles?** Sobre todo salud, biometría
   (Art. 9 RGPD): cambia cómo se trata la base de datos y la entrega.

Si no tienes acceso al destino todavía (claves SSH, equipo del cliente), puedes
hacer Fases 1-2 (verificar + empaquetar) y dejar 3-6 para cuando lo tengas.

---

## Decisión 0 — ¿Qué tipo de destino? (define todo lo demás)

No hay un único "deploy". Hay dos, y confundirlos es el error más caro:

| | **Archetype A — VPS / servidor Linux** | **Archetype B — PC del cliente** |
|---|---|---|
| Cuándo | Debe correr 24/7, headless: bots de servidor, APIs, webs | Vive en el equipo de una persona: herramienta de escritorio, bot que usa solo el cliente |
| Acceso | SSH | Asistencia remota (Quick Assist/AnyDesk) o en persona/USB |
| Arranque | Docker Compose o systemd (auto-restart, sobrevive reboot) | Doble clic / autoarranque al iniciar sesión |
| Empaquetado | `docker-compose.yml` + `Dockerfile`, o venv + `systemd` | La carpeta + un `run.bat`/script + instaladores nativos |
| Entrega | README técnico + acceso | Guía simple (voz si hace falta) + soporte directo |

**Regla anti-inercia:** en Archetype B, **no metas Docker por defecto**. Un PC de
8 GB con un usuario no técnico y un Ollama local funciona mejor con instalación
nativa + autoarranque que con contenedores. Docker es para servidores. Recomendar
la herramienta correcta para el destino es parte del trabajo (igual que en
`automation-n8n-builder`: *no empujar X por inercia*).

---

## El flujo — 6 fases

### Fase 1 · Pre-deploy checklist (COMPUERTA DURA)

Antes de empaquetar nada, pasa el gate de [`references/pre-deploy-checklist.md`](references/pre-deploy-checklist.md).
Resumen de lo bloqueante:

- **Sin secretos hardcodeados** en el código (todo por variable de entorno).
- **El `.env` real no viaja** — gitignored; el bundle lleva solo `.env.example`.
- **Datos personales/de salud no viajan** — el destino arranca con la base vacía.
- **Arranca desde cero** en una máquina limpia (sin tu `.venv`/`node_modules`).

Y lo requerido (no bloquea, pero se arregla antes de entregar): `.env.example`
en sync con el código, dependencias declaradas (incl. binarios externos
documentados), árbol sin `__pycache__`/rutas absolutas de tu máquina.

Si hay un 🔴 → **para**, propón el fix, vuelve a escanear. No se avanza con
secretos o datos sensibles en el paquete. (Si el proyecto ya pasó por
`tool-quality-gate`, aprovecha su resultado; esta fase añade el foco
secretos+datos+arranque-limpio que el deploy necesita.)

### Fase 2 · Empaquetado (el bundle deployable)

Genera los artefactos de arranque desde [`templates/`](templates/), adaptando los
`{{PLACEHOLDER}}`. Según el archetype:

- **A (Docker):** `Dockerfile.python.template` + `docker-compose.yml.template`.
  Añade un `.dockerignore` que excluya `.env`, `.venv`, `*.db`, `backups/`, `.git`.
- **A (sin Docker):** `systemd-unit.template` + `deploy-rsync.sh.template`.
- **B (PC cliente):** un script de arranque de un clic (`run.bat` en Windows: que
  cree el venv, instale deps y lance la app — ver el ejemplo de Jesús abajo).

**Qué entra en el bundle:** código, `requirements.txt`/`package.json`,
`.env.example`, artefactos de arranque, README.
**Qué NUNCA entra:** `.env`, bases de datos / backups / exports con datos reales,
`.venv`/`node_modules`/`__pycache__`, claves, rutas absolutas de tu máquina.

### Fase 3 · Transfer wizard (copiar al destino)

Guía paso a paso según archetype (comandos en [`references/remote-setup.md`](references/remote-setup.md)):

- **A — VPS:** `rsync -avz --delete` con `--exclude` de secretos y datos (el script
  `deploy-rsync.sh.template` ya los trae). `scp` para transferencias puntuales.
  El `.env` se crea **en el servidor** copiando el `.example` y rellenándolo allí.
- **B — PC cliente:** sesión de **asistencia remota** (Quick Assist en Windows ya
  viene incluido; AnyDesk/TeamViewer si no) para montarlo tú por el cliente —
  imprescindible si no puede navegar visualmente. O carpeta por USB / `.zip` por
  su canal habitual. Nunca metas el `.env` con secretos en el zip.

### Fase 4 · Setup remoto (instalar y arrancar)

- **A — VPS:** instalar runtime (Docker, o `python3 -m venv` + deps), crear el
  `.env` en destino (`chmod 600`), arrancar con `docker compose up -d` o
  `systemctl enable --now <svc>`. Firewall solo si expone HTTP.
- **B — PC cliente:** instalar runtime nativo (`winget install Python/FFmpeg/Ollama`
  en Windows; `brew` en Mac), descargar el modelo local si aplica
  (`ollama pull ...`, tamaño según RAM), copiar `.env.example`→`.env` y rellenar
  lo justo, dejar **autoarranque** (carpeta `shell:startup` o Tarea programada)
  para que el cliente no tenga que tocar nada.

### Fase 5 · Verificación post-deploy

No está hecho hasta que un caso real funciona de punta a punta. Usa la tabla de
verificación de [`references/remote-setup.md`](references/remote-setup.md):

- Proceso vivo (`docker compose ps` / `systemctl status` / la consola arrancó).
- Logs de arranque sin errores (lee los primeros 30 s).
- **Health funcional**: una operación real de usuario (llamar al endpoint, mandar
  la nota de voz y recibir respuesta). Esto es lo que cuenta.
- Persistencia (la base de datos se crea y sobrevive a un reinicio).
- Reinicia el equipo/servidor: ¿vuelve a arrancar solo?

Si algo falla, **lee los logs antes de tocar**: casi siempre es una variable de
`.env` o un binario externo que falta en destino, no el código.

### Fase 6 · Guía de entrega (para el cliente)

Genera un `ENTREGA.md` desde [`templates/ENTREGA.md.template`](templates/ENTREGA.md.template):
qué tiene, cómo se enciende, cómo se apaga, qué hacer si algo va mal, dónde están
sus datos y a quién llamar. **En el idioma del cliente** y, si el cliente opera
por voz o tiene problemas de visión, redactado para **leerse en voz alta** (frases
cortas, sin pasos visuales tipo "haz clic en el botón azul de arriba a la
derecha"). Guárdalo junto al proyecto entregado y, en Archetype B, también una
copia en el propio equipo del cliente.

---

## Ejemplo trabajado — Bot de voz de Jesús Roiget (Archetype B)

Caso real en el repo: `clients/jesus-roiget/projects/briefs/sistema-telegram/bot/`.
Bot de Telegram por voz (alta de pacientes dictando). Stack: Python +
`python-telegram-bot` + Groq Whisper (STT, nube, gratis) + Ollama local
(extracción, qwen) + edge-tts/Piper (voz) + SQLite. Destino: el **PC Windows de
Jesús**, fisio en Tortosa con 80% de pérdida de visión → todo operable por voz.

**Decisión 0:** Archetype **B**. Es el PC de una persona no técnica, no un
servidor. **Docker queda descartado**: 8 GB de RAM, Ollama local y un usuario que
no mira la pantalla → instalación nativa + autoarranque. (El proyecto ya trae
`run.bat`, que es exactamente el patrón correcto de B.)

**Fase 1 — pre-deploy:** el escaneo encuentra que NO pueden viajar:
- `.env` (tiene `TELEGRAM_BOT_TOKEN` y `GROQ_API_KEY` reales) → solo viaja `.env.example`.
- `pacientes.db` y `backups/pacientes_*.zip` → **datos de salud, Art. 9 RGPD**.
  El PC de Jesús arranca con la base **vacía**; las fichas las dicta él allí.
- `.venv/` y `__pycache__/` fuera.
`.env.example`, `requirements.txt` y el README (que documenta los binarios
Ollama/ffmpeg/Piper) están presentes → requeridos OK.

**Fase 2 — empaquetado:** la carpeta `bot/` menos `.env`, `pacientes.db`,
`backups/`, `.venv/`, `__pycache__/`. El artefacto de arranque ya existe:
`run.bat` (levanta Ollama, comprueba el modelo, crea el venv, instala deps,
lanza `main.py`). No hace falta Docker.

**Fase 3 — transfer:** sesión de **Quick Assist** (o AnyDesk) para que Olaf lo
monte por Jesús — no puede seguir pasos visuales. Copia la carpeta limpia al PC.

**Fase 4 — setup en el PC de Jesús:**
- `winget install Python.Python.3.12`, `Gyan.FFmpeg`, `Ollama.Ollama`.
- `ollama pull qwen2.5:3b` (modelo ligero, va en 8 GB; subir a `qwen3.5:4b` si
  va sobrado — el `.env` lo permite).
- `copy .env.example .env` y rellenar **solo**: `TELEGRAM_BOT_TOKEN`,
  `GROQ_API_KEY`, `ALLOWED_USER_IDS` (el ID de Jesús → solo él puede usarlo, RGPD),
  `EDGE_TTS_VOICE`.
- Doble clic en `run.bat` para el primer arranque (crea venv, instala deps).
- **Autoarranque**: acceso directo a `run.bat` en `shell:startup` para que el bot
  esté listo al encender el PC sin que Jesús toque nada.

**Fase 5 — verificación:** abrir Telegram, `/start`, mandar una nota de voz de
prueba ("nuevo paciente, prueba…") y confirmar que el bot **responde por voz**
("he entendido… ¿correcto?"). Comprobar que `pacientes.db` se crea tras guardar.
Reiniciar el PC y verificar que el autoarranque levanta el bot.

**Fase 6 — entrega:** `ENTREGA.md` para Jesús, redactado para leerse en voz alta:
*"Tienes un asistente que da de alta pacientes cuando le hablas. Para usarlo,
mándale una nota de voz por Telegram con los datos; te contesta hablando y le
dices 'sí' para guardar. Funciona solo al encender el ordenador. Si algo falla,
reinicia el PC; si sigue, llama a Olaf."* Más la nota RGPD: las fichas se quedan
en su ordenador (cifra el disco con BitLocker), no salen a internet salvo el
audio que Groq transcribe.

---

## Coordinación con otras skills

- **¿Aún no existe el proyecto / hay que arrancarlo?** → `arnes` (scaffold por
  niveles) primero; esta skill despliega lo que ya está construido.
- **¿Quieres una nota de calidad 0-100 antes de entregar?** → `tool-quality-gate`
  complementa la Fase 1 (esta se centra en secretos + datos + arranque limpio).
- **¿El "deploy" es en realidad un workflow de automatización?** → si lo que se
  entrega es una automatización tipo "cuando pase X haz Y", quizá va en
  `automation-n8n-builder`, no como app desplegada.
- **¿RGPD/legal del sistema entregado?** → si el cliente necesita auditoría de
  cumplimiento (no solo el deploy técnico), `tool-web-legal-audit` para la parte web.

---

## Cuándo NO usar esta skill

- **CI/CD del propio producto del operador** (la app de vídeo, Polymaster): eso es
  pipeline de desarrollo continuo, no una entrega puntual a un cliente. Mejor un
  flujo de git/Actions dedicado.
- **Arrancar un proyecto desde cero**: eso es `arnes`.
- **"Subir a la nube" sin cliente** (un side-project del operador en su propio
  VPS): se pueden usar las mismas fases, pero la Fase 6 (guía de entrega) sobra.

Decir honestamente *"esto no es un deploy a cliente, es X — te conviene Y"* es
parte del trabajo. No forzar el flujo de 6 fases donde no encaja.

---

## Output esperado

Al cerrar:

1. **Bundle deployable** verificado (sin secretos, sin datos sensibles) con sus
   artefactos de arranque (Docker/systemd/`run.bat` según archetype).
2. **Sistema corriendo en destino**, verificado con un caso real de uso.
3. **`ENTREGA.md`** para el cliente, en su idioma y accesible si hace falta.
4. **Cómo redesplegar**: una línea sobre cómo repetir el deploy tras cambios
   (re-ejecutar `deploy.sh` / repetir la sesión de asistencia), para que no sea
   un acto irrepetible.
5. Si tocaste algo no trivial, una entrada en `decisions-log` (p.ej. "Jesús:
   Archetype B, sin Docker, autoarranque por Startup, DB local por RGPD").
