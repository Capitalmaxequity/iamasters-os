# iAmasters OS

> El sistema operativo agéntico para operadores de IA.
> Castellano. Multi-cliente. Con memoria que evoluciona.

[![Version](https://img.shields.io/badge/version-v0.4.0-orange.svg)](https://github.com/angelapaia/iamasters-os/releases)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Powered by Sinapsis](https://img.shields.io/badge/engine-Sinapsis%20v4.5-purple.svg)](vendor/sinapsis/)
[![Maintained by Angel Aparicio](https://img.shields.io/badge/maintained%20by-Angel%20Aparicio-ff8c42.svg)](https://angelaparicio.com)
[![iAmasters Academy](https://img.shields.io/badge/by-iAmasters%20Academy-b794f4.svg)](https://www.skool.com/ia-masters-automations)

---

## Qué es

**iAmasters OS** es un repositorio Claude Code listo para clonar e instalar que convierte una sesión vanilla de Claude Code en un sistema operativo profesional para operadores de IA. Tres capas:

1. **Sinapsis v4.5 (engine)** — memoria persistente, instintos auto-aprendidos, skills on-demand, dashboard, dream cycle. Trasplantado íntegro del [repo de Luis Pitik](https://github.com/Luispitik/sinapsis) sin modificar.
2. **Capa OS** — brand context (voice, positioning, ICP), agent context (soul, user, daily memory, learnings), proyectos estructurados, multi-cliente con templates por vertical.
3. **Skills curadas** — 18-22 skills validadas para marketing, operations, strategy, tools y visualization. Todas siguen patrón skill.md + references/ + scripts/.

## Para quién

- Operador IA freelancer que sirve a varios clientes
- Empresario que automatiza su negocio con Claude Code
- Agencia pequeña que quiere estandarizar su stack agéntico
- Formador que enseña Claude Code y necesita un repo de referencia

No requiere conocimientos de programación, sí requiere paciencia para configurarlo la primera vez (~30 min de onboarding).

## Qué te da el primer día

- Memoria que persiste entre sesiones (no más "explícame tu stack otra vez")
- 18+ skills curadas, instaladas, ya con tu marca dentro
- Brand context (voz, posicionamiento, ICP) auto-generado en 30 minutos
- Multi-cliente listo para escalar (4 templates de vertical incluidos)
- Sistema de aprendizaje continuo: lo que repites se gradúa a regla
- Dashboard visual con métricas reales de tu uso

## Instalación rápida

```bash
git clone https://github.com/iamasters/iamasters-os.git
cd iamasters-os
bash scripts/install.sh
```

El instalador:
1. Instala Sinapsis en `~/.claude/` si no está
2. Configura los hooks de Sinapsis en tu `~/.claude/settings.json`
3. Inicializa la capa OS dentro del repo (brand-context, context, projects)
4. Lanza el onboarding wizard la primera vez que abras Claude Code aquí

Detalle completo: [`docs/installation.md`](docs/installation.md)

## Primeros pasos (después de instalar)

```bash
cd iamasters-os
claude
```

Claude Code arrancará y, si es la primera vez:
1. Lanzará el onboarding wizard (`/start-here`)
2. Te preguntará tu avatar (single business / freelance / agencia)
3. Hará la entrevista de brand voice
4. Si das tu URL pública, scrape con Firecrawl para sacar voice samples y assets
5. Te recapitulará qué tienes instalado y propondrá una primera tarea

## Estructura del repo

```
iamasters-os/
├── .claude/
│   ├── settings.json           # Hooks Sinapsis + permisos seguros por defecto
│   ├── commands/               # Commands del OS (start-here, wrap-up, add-client...)
│   └── skills/                 # Skills curadas por categoría
│       ├── _meta/              # Sistema (skill-creator, onboarding, output-verifier)
│       ├── marketing/          # Brand voice, copywriting, ICP, repurposing...
│       ├── operations/         # Meeting notes, task priority...
│       ├── strategy/           # Trending research, competitor monitor
│       ├── tools/              # Humanizer, firecrawl scraper, output verifier
│       └── visualization/      # Diagramas Excalidraw
│
├── brand-context/              # Tu marca: voice, positioning, ICP, assets
├── context/                    # soul.md, user.md, learnings.md
├── projects/                   # Outputs por skill o por brief
├── clients/                    # Multi-cliente
│   └── _templates/             # 4 verticales: freelance-ia, agencia-marketing,
│                               #               formador-online, consultoria-b2b
│
├── docs/                       # Guías de instalación, multi-cliente, MCPs curados
├── scripts/                    # install, update, add-client, validate-skill
├── tests/                      # Tests del OS (los de Sinapsis viven en vendor/)
└── vendor/
    └── sinapsis/               # Sinapsis v4.5 vendored (engine de memoria)
```

## Diferencial vs vanilla Claude Code

| Sin OS | Con iAmasters OS |
|---|---|
| Cada sesión empieza explicando tu stack | Sinapsis recuerda y carga skills relevantes |
| Skills sueltas sin curar (1000+ disponibles) | 18-22 skills validadas para tu avatar |
| Brand voice cada vez que escribes | Voice profile permanente con 3 registros A/B/C |
| Outputs sin gate de calidad | `tool-output-verifier` antes de entregar |
| 1 cliente o se mezcla todo | Multi-cliente con templates por vertical |
| Sin aprendizaje | Lo que repites 3+ sesiones → regla automática |

## Compatibilidad

- **Anthropic Plan**: Pro o Max (no requiere API)
- **OS**: macOS, Linux, Windows (Git Bash)
- **Requiere**: Claude Code CLI, Node.js 18+, Python 3.9+, Git
- **Opcional**: Firecrawl API key (para auto-extraer voice profile y brand assets)

## Roadmap

Ver [`CHANGELOG.md`](CHANGELOG.md) para historial detallado.

- **v0.1.0** (en construcción) — esqueleto + Sinapsis vendored + meta-skills + brand-context flow
- **v0.2.0** — skills marketing core + output-verifier + skill marketplace local
- **v0.3.0** — multi-cliente + 4 templates verticales + update.sh con conflict resolution
- **v0.4.0** — MCPs curated list + `/install-mcp` + `/install-skill`
- **v1.0.0** — release pública estable

## Contribuir

iAmasters OS es código abierto bajo MIT. Las contribuciones bienvenidas:
- Nuevas skills (siguiendo el patrón en `docs/skill-creation-guide.md`)
- Templates de cliente para nuevos verticales
- Mejoras a la documentación

## Créditos

- **Sinapsis**: [Luis Pitik](https://github.com/Luispitik/sinapsis) — el engine de memoria
- **Inspiración Agentic OS**: la arquitectura de Brand Context + Agent Context + Skills curadas viene del análisis del Agentic Academy de Juanpe Navarro
- **Brand Voice patterns A/B/C**: inspirado en el Brand Voice Manual de Fernando Montero

## Sobre el proyecto

**iAmasters OS** es propiedad de **Angel Aparicio** y forma parte del ecosistema de productos de **[iAmasters Academy](https://www.skool.com/ia-masters-automations)**, la comunidad de operadores de IA en castellano.

| | |
|---|---|
| **Autor y mantenedor** | Angel Aparicio |
| **Afiliación** | iAmasters Academy |
| **Web personal** | [angelaparicio.com](https://angelaparicio.com) |
| **GitHub** | [@angelapaia](https://github.com/angelapaia) |
| **Comunidad** | [skool.com/ia-masters-automations](https://www.skool.com/ia-masters-automations) |
| **Email** | angel.aparicio92@gmail.com |
| **Año** | 2026 |

### Cómo citar

Si usas iAmasters OS en tu trabajo, proyecto o publicación, agradecemos la citación. Ver [`CITATION.cff`](CITATION.cff) para el formato estructurado. Referencia rápida:

> Aparicio, A. (2026). *iAmasters OS* [Software]. iAmasters Academy.
> https://github.com/angelapaia/iamasters-os

### Code ownership

Este repositorio sigue el modelo CODEOWNERS de GitHub. Cualquier PR requiere review del propietario. Ver [`.github/CODEOWNERS`](.github/CODEOWNERS) para el detalle.

### Marca

"iAmasters Academy", "iAmasters OS" y los logos relacionados son propiedad de Angel Aparicio. El código fuente se publica bajo licencia MIT (libre uso/modificación), pero el uso de la marca y los logos requiere autorización explícita.

## Licencia

Código fuente bajo MIT — ver [LICENSE](LICENSE).
Componente vendored Sinapsis v4.5 conserva su licencia "Source Available" original de Luis Pitik en [`vendor/sinapsis/LICENSE`](vendor/sinapsis/LICENSE).
