# Setup remoto — recetario de comandos

> Comandos para las Fases 3-5 (transferir, instalar, arrancar, verificar).
> Hay **dos destinos** muy distintos. Elige el bloque correcto; mezclarlos
> (p.ej. systemd en el PC de un cliente no técnico) es el error clásico.

---

## Archetype A — VPS / servidor Linux (headless, corre 24/7)

Para apps que deben estar siempre arriba: bots de servidor, APIs, webs.

### A.1 Conectar y preparar el servidor

```bash
ssh {{user}}@{{host}}                      # entra al servidor
# Usuario dedicado (no operes como root):
sudo adduser --disabled-password --gecos "" dev
sudo usermod -aG sudo dev
# Acceso por clave (desde TU máquina, no la del servidor):
ssh-copy-id dev@{{host}}                    # luego deshabilita password-auth en sshd_config
```

### A.2 Transferir el código

```bash
# rsync = transferencia idempotente, re-ejecutable. EXCLUYE secretos y datos.
rsync -avz --delete \
  --exclude='.git/' --exclude='.venv/' --exclude='__pycache__/' \
  --exclude='.env' --exclude='*.db' --exclude='backups/' --exclude='data/' \
  ./ dev@{{host}}:/opt/{{service}}/
# Alternativa puntual (un solo archivo / sin rsync): scp archivo dev@{{host}}:/opt/{{service}}/
```

El `.env` se crea **en el servidor**, no se copia:

```bash
ssh dev@{{host}}
cd /opt/{{service}}
cp .env.example .env
nano .env            # rellena los secretos AQUÍ. chmod 600 .env
```

### A.3a Arrancar con Docker (recomendado si el destino tiene Docker)

```bash
# Instalar Docker una vez:
curl -fsSL https://get.docker.com | sh && sudo usermod -aG docker dev   # re-login

cd /opt/{{service}}
docker compose up -d --build
docker compose ps                 # ¿"healthy"?
docker compose logs -f --tail=50  # arranque sin errores
```

### A.3b Arrancar con systemd (venv plano, sin Docker)

```bash
cd /opt/{{service}}
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt

sudo cp {{service}}.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now {{service}}
systemctl --no-pager status {{service}}     # active (running)?
journalctl -u {{service}} -f                 # logs en vivo
```

### A.4 Red (solo si expone HTTP)

```bash
sudo ufw allow OpenSSH && sudo ufw allow 80 && sudo ufw allow 443 && sudo ufw enable
# Pon un reverse proxy (Caddy/Nginx) delante para TLS. Un bot de poll NO abre puertos.
```

---

## Archetype B — PC del cliente (Windows/Mac, usuario no técnico)

Para sistemas que viven en el equipo del cliente: el bot de voz de Jesús, una
herramienta de escritorio. Aquí NO hay SSH ni systemd ni Docker. Hay una
persona delante (o que ni mira la pantalla) y un ordenador normal.

### B.1 Cómo llegas al equipo

- **Sesión de asistencia remota** (recomendado cuando el operador instala por el
  cliente): **Quick Assist** (Windows, ya incluido: tecla Windows → "Asistencia
  rápida"), **AnyDesk** o **TeamViewer**. Compartes pantalla y lo dejas montado tú.
  Imprescindible si el cliente no puede navegar visualmente (accesibilidad).
- **En persona / USB**: copia la carpeta del proyecto (sin `.venv`, sin datos) a
  un USB y de ahí al PC. Útil si vas a la clínica/oficina.
- **Descarga directa**: un `.zip` por el canal que ya use el cliente (no subas
  secretos; el `.env` se rellena en destino).

### B.2 Instalar el runtime (Windows, con winget)

```powershell
winget install Python.Python.3.12          # Python
winget install Gyan.FFmpeg                  # ffmpeg (audio), si aplica
winget install Ollama.Ollama                # LLM local, si aplica
# Modelo local (ajusta el tamaño a la RAM del equipo):
ollama pull qwen2.5:3b                       # ~2 GB, va en PCs de 8 GB
```

(En Mac: `brew install python ffmpeg ollama`.)

### B.3 Configurar y primer arranque

```powershell
cd C:\ruta\al\proyecto
copy .env.example .env
notepad .env          # rellena SOLO lo imprescindible (claves, IDs autorizados)
# Si el proyecto trae run.bat: doble clic. Si no, a mano:
python -m venv .venv
.venv\Scripts\python -m pip install -r requirements.txt
.venv\Scripts\python main.py
```

### B.4 Que arranque solo (sin que el cliente toque nada)

Para un usuario que no debe pelearse con ventanas, deja el sistema en autoarranque:

```powershell
# Opción 1 — carpeta de Inicio (arranca al iniciar sesión el usuario):
# pega un acceso directo a run.bat en:
#   shell:startup   (pégalo en la barra de direcciones del Explorador)

# Opción 2 — Tarea programada (arranca al encender, más robusto):
schtasks /create /tn "{{ServicioCliente}}" /tr "C:\ruta\al\proyecto\run.bat" /sc onlogon /rl highest
```

Aviso honesto al cliente: con esto queda una ventana de consola abierta mientras
funciona; **cerrarla = apagar el sistema**. Para un usuario que opera por voz y
no mira la pantalla, eso está bien (no interactúa con la ventana). Si molesta,
se puede ocultar la consola, pero añade complejidad de soporte — decídelo según
el cliente, no por defecto.

---

## Verificación post-deploy (ambos archetypes)

| Comprobación | VPS Linux | PC cliente |
|---|---|---|
| Proceso vivo | `docker compose ps` / `systemctl status` | la ventana dice "en marcha"; Ollama responde |
| Logs sin errores de arranque | `docker compose logs --tail=50` / `journalctl -u svc -e` | mira la consola los primeros 30 s |
| Health funcional | `curl -f http://localhost:PORT/health` | prueba real de usuario (manda la nota de voz, llega respuesta) |
| Persistencia | el volumen/DB se crea y sobrevive a un reinicio | el archivo de datos aparece tras la 1ª operación |
| Reinicio | `sudo reboot` → ¿vuelve solo? | reinicia el PC → ¿arranca solo? |

Si el health funcional pasa (un caso real de uso de punta a punta), el deploy
está vivo. Si no, lee los logs antes de tocar nada — casi siempre es una
variable de `.env` mal puesta o un binario externo que falta en destino.
