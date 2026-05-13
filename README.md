<p align="center">
  <img src="assets/logo.png" alt="IA Masters Academy" width="320">
</p>

<h1 align="center">iAmasters OS</h1>

<p align="center">
  <em>El sistema operativo agéntico para operadores de IA.<br>
  Castellano. Multi-cliente. Con memoria que evoluciona.</em>
</p>

<p align="center">
  <a href="https://github.com/iamasters-academy/iamasters-os/releases"><img src="https://img.shields.io/badge/version-v0.5.0-orange.svg" alt="Version"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License"></a>
  <a href="vendor/sinapsis/"><img src="https://img.shields.io/badge/engine-Sinapsis%20v4.5-purple.svg" alt="Powered by Sinapsis"></a>
  <a href="https://angelaparicio.com"><img src="https://img.shields.io/badge/maintained%20by-Angel%20Aparicio-ff8c42.svg" alt="Maintained by Angel Aparicio"></a>
  <a href="https://www.skool.com/ia-masters-automations"><img src="https://img.shields.io/badge/by-IA%20Masters%20Academy-b794f4.svg" alt="IA Masters Academy"></a>
</p>

---

## 🚀 Instalación en 30 segundos

**Si tienes [Claude Desktop](https://claude.com/download) (Pro o Max), abre la tab `Code` y pega este mensaje exacto en el chat:**

```
Instala iAmasters OS desde
https://github.com/iamasters-academy/iamasters-os
y guíame en el setup
```

Claude Code clonará el repo, ejecutará el instalador, te entrevistará por bloques (~10 min) y generará tu primer entregable real (~5 min). Total: ~15-20 min.

> 💡 **Para no técnicos**: en Claude Desktop, activa "omitir permisos" (skip permissions) la primera vez. El sistema no toca nada destructivo, solo te ahorrará confirmar 20 veces.

¿No tienes Claude Desktop todavía? [Descárgalo aquí](https://claude.com/download). ¿No sabes qué plan necesitas? Ver [💰 Coste real](#-coste-real) abajo.

---

## Qué es

**iAmasters OS** es un repositorio Claude Code que convierte una sesión vanilla en un sistema operativo profesional para operadores de IA. Tres capas:

1. **Sinapsis v4.5 (engine)** — memoria persistente, instintos auto-aprendidos, skills on-demand. Vendoreado intacto del [repo de Luis Pitik](https://github.com/Luispitik/sinapsis).
2. **Capa OS** — brand context (voice, positioning, ICP), agent context sectorizado (me, work, team, priorities, goals), proyectos estructurados, multi-cliente con templates por vertical.
3. **Skills curadas** — 22 skills validadas para marketing, estrategia, automatización, tools, visualización y meta-pensamiento. Todas siguen patrón skill.md + references/ + scripts/. Skills oficiales de Anthropic (docx, xlsx, pdf, pptx) se instalan vía marketplace en el día 4 de `/aprende`.

> 🌱 **Sistema vivo**: el catálogo crece con la comunidad. Cuando una skill nueva de IA Masters Academy demuestra valor en producción, entra al repo. Ver [`docs/skills-recommended.md`](docs/skills-recommended.md) para proponer una.

## Para quién

- Operador IA freelancer que sirve a varios clientes
- Empresario que automatiza su negocio con Claude Code
- Agencia pequeña que quiere estandarizar su stack agéntico
- Formador que enseña Claude Code y necesita un repo de referencia
- Cualquier miembro de [IA Masters Academy](https://www.skool.com/ia-masters-automations) (es la audiencia principal)

No requiere conocimientos de programación. Sí requiere paciencia para configurarlo la primera vez (~15-20 min de onboarding guiado).

## Qué te da el primer día

- ✅ Memoria que persiste entre sesiones (no más "explícame tu stack otra vez")
- ✅ Tu primer entregable real generado por el sistema en los primeros 20 min (welcome-quick-win)
- ✅ 22 skills curadas, instaladas, listas para activarse cuando hablas con Claude
- ✅ Brand context (voz, posicionamiento, ICP) generable en 30 minutos extra
- ✅ Multi-cliente listo para escalar (4 templates de vertical incluidos)
- ✅ Sistema de aprendizaje continuo: lo que repites se gradúa a regla
- ✅ Decisions log append-only que mantiene a Claude coherente entre sesiones
- ✅ `/doctor` para diagnosticar y arreglar cualquier desviación

## 💰 Coste real

**Importante leerlo antes de instalar.** iAmasters OS es gratis y open source, pero requiere Claude (de Anthropic), que NO es gratis.

| Concepto | Coste | Cuándo se paga |
|---|---|---|
| iAmasters OS (este repo) | **Gratis** (MIT) | Nunca |
| Membresía iAmasters Academy | (ver web) | Si quieres la comunidad y formación. **No** es necesaria para usar el OS |
| Claude Desktop app | Gratis (descarga) | Nunca |
| **Anthropic Pro** | **$20/mes** | Mínimo necesario para que el OS funcione bien |
| **Anthropic Max** | $100-200/mes | Si vas a usar mucho Cowork o sesiones largas de Code |
| Firecrawl API (opcional) | Gratis 500 créditos | Si quieres que el OS scrapee tu web/LinkedIn auto |

**Conclusión**: el coste mínimo realista para empezar bien es **$20/mes de Anthropic Pro**. Con plan Free los modelos buenos no llegan y el OS se siente roto.

> Si vienes de iAmasters Academy: tu membresía NO incluye Anthropic. Son cuentas separadas. Lo decimos claro porque otros productos lo esconden.

## Instalación alternativa (sin prompt conversacional)

Si prefieres clonar manualmente:

```bash
git clone https://github.com/iamasters-academy/iamasters-os.git ~/iamasters-os
cd ~/iamasters-os
bash scripts/install.sh
```

Luego abre Claude Code en esa carpeta y se lanzará el onboarding.

Detalle completo en [`docs/installation.md`](docs/installation.md).

## Después de instalar

Lo más útil para arrancar:

| Comando / acción | Qué hace |
|---|---|
| Onboarding wizard (auto) | Te entrevista por bloques, llena tu contexto sectorizado |
| `/welcome` | Genera tu primer entregable HTML compartible (5 min) |
| `/doctor` | Diagnostica el OS, propone fixes si hay algo roto |
| `/start-here` | Ritual diario de inicio: resumen ayer + propuesta hoy |
| `/wrap-up` | Ritual de cierre: registra deliverables, decisiones, lecciones |

## Skills incluidas (Capa 1 — preinstaladas)

```
_meta/                            Sistema y rituales del OS
├── meta-skill-creator            Crea skills nuevas siguiendo el patrón canónico
├── meta-onboarding-wizard        Entrevista por bloques, sectoriza context
├── meta-start-here               Ritual diario de inicio
├── meta-wrap-up                  Ritual diario de cierre
├── welcome-quick-win             Tu primer entregable garantizado en 5 min
├── six-hats                      Método 6 sombreros de De Bono
├── decisions-log                 Diario append-only inspirado en second-brain
├── health-check                  Diagnóstico (vía `/doctor`)
└── find-skills                   Descoverabilidad por intent en lenguaje natural

marketing/                        Voz, contenido y conversión
├── marketing-brand-voice         Voice profile + 3 registros A/B/C
├── marketing-positioning         Análisis de posicionamiento
├── marketing-icp                 Cliente ideal: dolores, lenguaje, triggers
├── marketing-copywriting         Copy con humanizer gate obligatorio
├── marketing-content-repurposing Distribución multiplataforma
└── marketing-email-sequence      🆕 Secuencias de email (welcome, nurture, win-back)

automation/                       🆕 Automatización y migración
├── automation-n8n-to-claude      Migra workflows n8n al ecosistema Claude
└── automation-n8n-builder        Crea workflows n8n desde Claude (vía MCP n8n-mcp)

strategy/                         🆕 Investigación y estrategia
└── strategy-web-research         Research profundo multi-fuente (LangChain)

tools/                            Utilidades transversales
├── tool-firecrawl-scraper        Wrapper Firecrawl con fallback manual
├── tool-humanizer                Quita patrones AI-tell del output
└── tool-output-verifier          Gate de calidad (humanizer + voice + length)

visualization/                    Outputs compartibles
└── tool-visual-explainer         Genera HTML autocontenido compartible

_meta/_optional/                  Activables con `/install-skill <nombre>`
└── cognito                       Sistema Operativo de Pensamiento (Luis Pitik)
```

> 📦 **Skills oficiales Anthropic (`docx`, `xlsx`, `pdf`, `pptx`)**: NO se vendorean en este repo porque su licencia es "source-available" (no permite redistribución). Se instalan vía marketplace oficial dentro de Claude Code (`/plugin install anthropic-skills`). El comando `/aprende` día 4 te guía paso a paso.

¿Quieres más? Ver [`docs/skills-recommended.md`](docs/skills-recommended.md) — catálogo de Capa 2 instalable on-demand con `/install-skill`.

## Estructura del repo

```
iamasters-os/
├── .claude/
│   ├── settings.json           # Hooks Sinapsis + permisos seguros por defecto
│   ├── commands/               # Slash commands del OS
│   └── skills/                 # 22 skills curadas por categoría
│
├── brand-context/              # Tu marca: voice, positioning, ICP, assets
├── context/                    # Contexto sectorizado: me, work, team, priorities, goals
│   ├── me.md                   # Identidad
│   ├── work.md                 # Negocio y revenue
│   ├── team.md                 # Equipo
│   ├── current-priorities.md   # Foco actual (cambia mensualmente)
│   ├── goals.md                # Objetivos 12 meses
│   ├── decisions-log.md        # Decisiones append-only
│   ├── learnings.md            # Feedback de skills
│   └── soul.md                 # Personalidad agente
│
├── projects/                   # Outputs por skill o por brief
│   └── welcome/                # Tu primer entregable vive aquí
│
├── clients/                    # Multi-cliente
│   └── _templates/             # 4 verticales: freelance-ia, agencia-marketing,
│                               #               formador-online, consultoria-b2b
│
├── docs/                       # Guías de instalación, multi-cliente, skills curadas
├── scripts/                    # install, update, add-client, validate-skill
└── vendor/
    └── sinapsis/               # Sinapsis v4.5 vendored (engine de memoria)
```

## Diferencial vs vanilla Claude Code

| Sin OS | Con iAmasters OS |
|---|---|
| Cada sesión empieza explicando tu stack | Sinapsis recuerda y carga skills relevantes |
| Skills sueltas sin curar | 18 skills validadas para tu avatar |
| Brand voice cada vez que escribes | Voice profile permanente con 3 registros A/B/C |
| Outputs sin gate de calidad | `tool-output-verifier` antes de entregar |
| 1 cliente o se mezcla todo | Multi-cliente con templates por vertical |
| Sin aprendizaje | Lo que repites 3+ sesiones → regla automática |
| Sin coherencia entre sesiones | `decisions-log.md` mantiene track record |
| Si algo se rompe, abandono | `/doctor` diagnostica y propone fixes |

## Compatibilidad

- **Anthropic Plan**: Pro o Max (Free no llega)
- **OS**: macOS, Linux, Windows (Git Bash o WSL)
- **Requiere**: Claude Code (incluido en Claude Desktop), Node.js 18+, Python 3.9+, Git
- **Opcional**: Firecrawl API key (para auto-extraer voice profile y brand assets)

## Roadmap

Ver [`CHANGELOG.md`](CHANGELOG.md) para historial detallado.

- **v0.1.0** ✅ esqueleto + Sinapsis vendored + meta-skills + brand-context flow
- **v0.2.0** ✅ skills marketing core + output-verifier + skill marketplace local
- **v0.3.0** ✅ multi-cliente + 4 templates verticales + update.sh con conflict resolution
- **v0.4.0** ✅ MCPs curated + atribución (6 capas)
- **v0.4.3** ✅ Plug-and-play (URL conversacional, /doctor, welcome quick-win, six-hats, decisions-log, sectorización context)
- **v0.5.0** ✅ Sistema vivo + skills automation/email/strategy + comando `/aprende` (tour de 5 días) + showcase pre-poblado + plugins Anthropic vía marketplace
- **v0.6.0** — Skills nativas en español (meeting-notes, proposal-writer, youtube-transcript, linkedin-posts) reescritas con voice profile del operador
- **v1.0.0** — release pública estable + vídeos Loom integrados + landing en iamastersacademy.com/os

## 🌱 Sistema vivo

iAmasters OS **no es un producto cerrado**. Es un repositorio que crece con la comunidad de IA Masters Academy.

Cada vez que un miembro construye una skill que demuestra valor en producción (validada ≥2 semanas, útil para ≥3 avatares, sin dependencias privadas), entra al catálogo en la siguiente release. Cada vez que una skill se queda obsoleta o tiene mejor reemplazo, sale.

**Cómo proponer una skill nueva**: ver criterios y proceso en [`docs/skills-recommended.md`](docs/skills-recommended.md) → sección "Cómo proponer una skill al catálogo". El maintainer (Angel) revisa, y las que pasan entran en próxima release con crédito al autor.

**Cadencia esperada**: release menor cada 4-6 semanas con skills validadas por la comunidad.

## Contribuir

iAmasters OS es código abierto bajo MIT. Las contribuciones bienvenidas:

- Nuevas skills (siguiendo el patrón en [`docs/skill-creation-guide.md`](docs/skill-creation-guide.md))
- Templates de cliente para nuevos verticales
- Mejoras a la documentación
- Reportes de bugs en `/doctor` o instalación

## Créditos

- **Sinapsis**: [Luis Pitik](https://github.com/Luispitik/sinapsis) — el engine de memoria persistente
- **Patrón decisions-log**: inspirado en [`Luispitik/claude-code-second-brain`](https://github.com/Luispitik/claude-code-second-brain)
- **cognito skill**: original de Luis Pitik, copiada con autorización
- **find-skills, visual-explainer**: de la suite Anthropic skills + comunidad
- **Inspiración Agentic OS**: arquitectura Brand Context + Agent Context + Skills curadas viene del análisis del Agentic Academy de Juanpe Navarro
- **Brand Voice patterns A/B/C**: inspirado en el Brand Voice Manual de Fernando Montero
- **6 sombreros**: método de Edward de Bono, dominio público

## Sobre el proyecto

**iAmasters OS** es propiedad de **Angel Aparicio** y forma parte del ecosistema de productos de **[IA Masters Academy](https://www.skool.com/ia-masters-automations)**, la comunidad de operadores de IA en castellano.

| | |
|---|---|
| **Autor y mantenedor** | Angel Aparicio |
| **Marca** | IA Masters Academy |
| **Empresa legal** | AASC Associates |
| **Web personal** | [angelaparicio.com](https://angelaparicio.com) |
| **LinkedIn** | [angel-aparicio92](https://www.linkedin.com/in/angel-aparicio92/) |
| **GitHub** | [@angelapaia](https://github.com/angelapaia) |
| **GitHub Org** | [@iamasters-academy](https://github.com/iamasters-academy) |
| **Comunidad** | [skool.com/ia-masters-automations](https://www.skool.com/ia-masters-automations) |
| **Email** | aaparicio@iamastersacademy.com |
| **Año** | 2025-2026 |

### Cómo citar

Si usas iAmasters OS en tu trabajo, proyecto o publicación, agradecemos la citación. Ver [`CITATION.cff`](CITATION.cff) para el formato estructurado. Referencia rápida:

> Aparicio, A. (2025-2026). *iAmasters OS* [Software]. IA Masters Academy.
> https://github.com/iamasters-academy/iamasters-os

### Code ownership

Este repositorio sigue el modelo CODEOWNERS de GitHub. Cualquier PR requiere review del propietario. Ver [`.github/CODEOWNERS`](.github/CODEOWNERS) para el detalle.

### Marca

"IA Masters Academy", "iAmasters OS" y el logo del camaleón son marcas registradas de **AASC Associates · Angel Aparicio**. El código fuente se publica bajo licencia MIT (libre uso/modificación), pero el uso de la marca y los logos requiere autorización explícita por escrito.

Para uso de marca, contactar: aaparicio@iamastersacademy.com

## Licencia

Código fuente bajo MIT — ver [LICENSE](LICENSE).
Componente vendored Sinapsis v4.5 conserva su licencia "Source Available" original de Luis Pitik en [`vendor/sinapsis/LICENSE`](vendor/sinapsis/LICENSE).
