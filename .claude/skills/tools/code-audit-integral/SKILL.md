---
name: code-audit-integral
description: Auditoría técnica integral de una aplicación (13 fases modulares Sprint/Standard/Full) — código, backend, base de datos, seguridad/dependencias, testing, offline-first, rendimiento, AI/LLM y production readiness. Úsala cuando el operador diga o pida "audita mi app/código a fondo", "revisión técnica completa", "revisa la seguridad/el backend/el rendimiento antes de producción", "¿está lista para producción?", "auditoría integral", "qué hay que arreglar antes de lanzar" o cierre un desarrollo grande y quiera un informe priorizado P0/P1/P2. Se adapta al stack detectado (las fases mobile/Expo/LLM-local se saltan en proyectos Python/web). Encaja al final de la cadena de construir app, antes de tool-quality-gate y del deploy.
---

> **System Role:** Actúa como **Lead Staff Engineer y Arquitecto de Software**. Adapta tu enfoque al stack detectado del proyecto (React Native/Expo + Supabase + LLM local GGUF para apps como Mente Táctica; Python/CPU para FVI o Polymarket; web/Vercel para landings y dashboards). Ejecuta este framework de auditoría de forma metódica, exhaustiva y sin improvisación, apoyándote en las skills del iAmasters OS cuando apliquen.

# 🔧 GUÍA DE AUDITORÍA TÉCNICA INTEGRAL v2.1
## Verificación de Código, AI Stack, Security, Backend y Performance

> **Cuándo usar:** Auditoría técnica completa de la aplicación
> **Última actualización:** 2026-02-19
>
> ⚡ **Al activar, SIEMPRE preguntar al usuario:**
> - 🏃 **Sprint** (2-3 sesiones): Fases 0 → 4 → 7 → 12
> - 🚶 **Standard** (5-7 sesiones): Fases 0 → 3 → 4 → 5 → 6 → 8 → 10 → 12
> - 🧘 **Full** (10-14 sesiones): Todas las fases (0-12)
>
> **Regla de salto:** Si el usuario elige Sprint o Standard, salta las fases no listadas. Marca las fases saltadas como `[⏭️]` en la tabla de Estado y documenta el motivo: "Saltada por modo {Sprint|Standard}".
>
> **Rutas y stack:** los comandos de ejemplo asumen un monorepo RN/Expo (carpeta `mobile/`,
> `<package.id>`, `<app-dir>`). **Detecta el stack real y sustituye las rutas** antes de ejecutar.
> En proyectos Python (FVI, Polymarket) o web, salta las fases mobile/Expo/LLM-local (6, 8, 10, 11)
> que no apliquen y adapta las herramientas (pytest/ruff en vez de jest/eas, etc.).

---

## 📈 Estado del Audit

| Fase | Nombre | Estado | Última ejecución | Notas |
|------|--------|--------|-----------------|-------|
| 0 | Activación y Contexto | [✅] | 2026-02-19 | Stack mapped, Architecture map created, Dependency checks run |
| 1 | Inventario Interactivo | [✅] | 2026-02-19 | Dashboard, Squad, AI Chat analyzed. No dead ends. |
| 2 | Implementación Controlada | [⚠️] | 2026-02-19 | npm audit fix failed (ERESOLVE). Manual review needed. |
| 3 | Auditoría Backend & DB | [✅] | 2026-02-19 | Schema & RLS valid. Sync logic needs implementation. |
| 4 | Testing & Demo Data | [✅] | 2026-02-19 | DemoSeeder valid. Unit Tests (Sync/Conflict) implemented. |
| 5 | Flujos & Estabilidad | [✅] | 2026-02-19 | Robust Boot Orchestration & Error Boundary verified. |
| 6 | Offline-First Audit | [✅] | 2026-02-19 | SyncEngine (Push/Pull) & LWW Conflict Resolution verified. |
| 7 | Security & Dependencies | [✅] | 2026-02-19 | Root Detection & AI Prompt Sanitization verified. |
| 8 | AI & Local LLM Audit | [✅] | 2026-02-19 | State-of-the-art Mobile AI integration verified. |
| 9 | Production Readiness | [✅] | 2026-02-19 | i18n (ES/EN) & Game Analytics valid. A11y fixed. |
| 10 | Performance Profiling | [✅] | 2026-02-19 | RAM-based Tiering & Thermal Heuristics verified. |
| 11 | CI/CD, DevOps & OTA | [✅] | 2026-02-19 | EAS Profiles (Dev/Preview/Prod) & GitHub Actions CI setup. |
| 12 | Informe Final | [✅] | 2026-02-19 | Audit Complete. |

> **Leyenda:** `[ ]` Pendiente · `[▶]` En progreso · `[✅]` Completado · `[⏭️]` Saltado

---

## 📦 Skills y comandos del iAmasters OS que apoyan cada fase

Esta skill se apoya en recursos **de este OS** (no de sistemas externos). Las marcadas **core**
ya están cargadas; las **biblioteca** se instalan a demanda (`bash scripts/skills.sh add <nombre>`
o "instala <nombre>"); los **comandos** se invocan con `/`.

| Recurso del OS | Tipo | Fases | Sustituye a (sistema original) |
|---|---|---|---|
| `ask-questions-if-underspecified` | skill core | 0 | adversarial-spec |
| `backend-development` | skill core | 3, 6, 7 | backend-development, database-design |
| `react-best-practices` | skill core | 1, 2, 6, 9, 10 | react-best-practices |
| `ui-ux-pro-max` | skill core | 9, 10 | frontend-design, expo-app-design |
| `usability-retention-review` | skill core | 1, 5 | uix-expert-knowledge |
| `tool-output-verifier` | skill core | 5, 12 | verification-before-completion |
| `meta-skill-creator` | skill core | 0, 12 | autoskill (captura de patrones) |
| `tool-seguridad-ia` | skill biblioteca | 7, 8 | mobile-security |
| `tool-web-security-audit` | skill biblioteca | 7 | mobile-security (si hay capa web) |
| `tool-quality-gate` | skill biblioteca | 7, 12 | verification-before-completion (gate pre-deploy) |
| `automation-client-deploy` / `vercel-deploy` | skill biblioteca | 11 | mobile-devops (deploy al entorno objetivo) |
| `/code-review` | comando | 3, 5, 7 | code-review |
| `/simplify` | comando | 2, 9 | code-refactoring |
| `/security-review` | comando | 7 | mobile-security |
| Exploración nativa (agente `Explore` / grep) | built-in | 0, 1, 8 | codebase-explorer |
| Plan mode / TodoWrite | built-in | 0, 2, 4 | planificacion-pro, sisyphus-orchestrator |

> Fases sin skill dedicada (debugging sistemático, testing E2E, documentación) se ejecutan con
> el criterio del agente y los `preview_*` tools cuando aplica. No dependas de skills que no
> estén en `bash scripts/skills.sh list`.

---

## ⚡ HEALTH CHECK RÁPIDO (15 min)

```bash
# 1. TypeScript check
npx tsc --noEmit --project mobile/tsconfig.json

# 2. Dependency audit
npm audit --omit=dev
npx expo-doctor

# 3. Build test (Android)
npx expo run:android --variant release --no-install

# 4. Model assets check
ls -lh mobile/models/llm/ && ls -lh mobile/models/embeddings/

# 5. Disk usage
du -sh mobile/node_modules/ mobile/android/app/build/
```

**Checklist rápido:**
- [ ] App inicia sin crashes
- [ ] Login/Logout funciona
- [ ] Pantallas core cargan datos
- [ ] Offline mode no rompe
- [ ] AI Brain icon se pone verde
- [ ] No hay console.errors visibles
- [ ] `npm audit` sin vulnerabilidades críticas

---

## 📋 CHECKLIST PRE-EJECUCIÓN

- [ ] Acceso al codebase completo
- [ ] Supabase dashboard disponible
- [ ] App funcionando en modo desarrollo
- [ ] Lista de pantallas a auditar
- [ ] Variables de entorno configuradas
- [ ] Modo seleccionado (Sprint / Standard / Full)

---

# 📋 FASES DE EJECUCIÓN (13 FASES)

---

## FASE 0: ACTIVACIÓN Y CONTEXTO
**Duración:** 30 minutos
**Skills:** `Explore` (built-in), plan mode, `meta-skill-creator`

### Tareas:
```
1. Detectar stack tecnológico
2. Generar mapa de pantallas
3. Identificar servicios y stores
4. Clasificar intención (Audit / Bugfix / Feature)
5. Detectar dependencias obsoletas / vulnerables
```

### Dependency Check:
```bash
npm audit --omit=dev
npx expo-doctor
npx depcheck
```

### ✅ Definition of Done:
- [ ] Mapa de arquitectura generado
- [ ] Stack documentado
- [ ] Stores y servicios listados
- [ ] 0 vulnerabilidades críticas (CVE) en dependencias

---

## FASE 1: INVENTARIO DE ELEMENTOS INTERACTIVOS
**Duración:** 1-2 sesiones
**Skills:** `Explore` (built-in), `react-best-practices`

### Output por pantalla:
```
| # | Elemento | Tipo | Ubicación | ¿Tiene acción? | ¿Tiene destino? | Problema |
```

⚠️ NO OMITIR ningún elemento interactivo.

### ✅ Definition of Done:
- [ ] Todas las pantallas inventariadas
- [ ] 0 elementos sin clasificar

---

## FASE 2: IMPLEMENTACIÓN CONTROLADA
**Duración:** 2-3 sesiones
**Skills:** `TodoWrite`/plan mode, `react-best-practices`, `/simplify`

### Protocolo:
```
Precondiciones → Código → Probar → Documentar → Completar
```

### ✅ Definition of Done:
- [ ] Código implementado
- [ ] Sin errores TypeScript
- [ ] Funcionalidad probada

---

## FASE 3: AUDITORÍA BACKEND Y DATABASE
**Duración:** 1-2 sesiones
**Skills:** `backend-development` (incluye diseño de BBDD), `/code-review`

### Verificar Schema:
```
1. Tablas sin uso
2. Campos nunca rellenados
3. Relaciones rotas / huérfanas
4. Duplicaciones innecesarias
5. Funciones SQL sin uso
6. Triggers inactivos
7. Permisos RLS activos en TODAS las tablas
```

### Verificar Vector DB:
- [ ] Índices vectoriales (HNSW / IVFFlat) creados y optimizados
- [ ] Dimensiones de embeddings consistentes (768-dim)
- [ ] Query performance de vector search < 200ms

### Verificar Supabase Edge Functions:
- [ ] ¿Hay Edge Functions desplegadas?
- [ ] ¿Están versionadas y con logs?
- [ ] ¿Errores manejados con retry?

### Verificar Storage Policies:
- [ ] ¿Buckets protegidos con policies? (audios, imágenes)
- [ ] ¿Acceso público bloqueado por defecto?
- [ ] ¿Tamaño máximo de archivo configurado?

### ✅ Definition of Done:
- [ ] Schema limpio
- [ ] RLS verificado en cada tabla
- [ ] Índices vectoriales optimizados
- [ ] Storage policies activas
- [ ] No hay relaciones huérfanas

---

## FASE 4: TESTING Y DATOS DEMO
**Duración:** 2-3 sesiones
**Skills:** `backend-development` (TDD), `preview tools` (E2E), debugging sistemático

### Testing Tools:
```bash
# Unit tests
npx jest --coverage

# Services tests
npx jest --testPathPattern="services"

# Stores tests
npx jest --testPathPattern="stores"
```

### Crear registros DEMO:
- "Sesión DEMO", "Ejercicio DEMO", "Jugador DEMO", etc.

### Flujos E2E (Manual):
```
1. crear sesión → añadir ejercicios → mostrar en calendario
2. crear pizarra → guardar → volver a abrir
3. crear jugador → asignar a equipo → mostrar ficha
4. crear partido → análisis → informe generado
5. login → navegación → logout
```

### ✅ Definition of Done:
- [ ] Datos demo creados
- [ ] 5 flujos E2E validados
- [ ] Coverage report generado

---

## FASE 5: AUDITORÍA DE FLUJOS Y ESTABILIDAD
**Duración:** 1-2 sesiones
**Skills:** `tool-output-verifier`, `/code-review`, `usability-retention-review`

### Validar:
- Ningún elemento sin acción
- Ningún flujo bloquea usuario
- Empty states y errores controlados
- Zustand, Supabase, TypeScript correctos

### ✅ Definition of Done:
- [ ] 0 dead ends
- [ ] 0 elementos sin acción
- [ ] Errores manejados

---

## FASE 6: OFFLINE-FIRST AUDIT
**Duración:** 1 sesión
**Skills:** `react-best-practices`, `backend-development`

### Verificar:
```
1. ¿Qué funciona sin conexión?
2. ¿Qué muestra error sin conexión?
3. ¿Las colas offline se procesan al reconectar?
4. ¿Los datos se persisten localmente?
5. ¿Hay indicador de estado de conexión?
```

### Resolución de Conflictos:
- [ ] ¿Qué ocurre si se edita la misma entidad offline en dos dispositivos?
- [ ] ¿Estrategia definida? (Last-Write-Wins / Merge / User-Decides)
- [ ] ¿Timestamps de sincronización (`updated_at`) propagados?
- [ ] ¿Cola offline tiene retry con backoff exponencial?

### Flujos offline críticos:
```
1. Crear sesión offline → reconectar → sincronizar
2. Marcar asistencia offline → ver después
3. Nota rápida offline → sincronizar
4. Editar mismo dato en 2 dispositivos → reconectar ambos
```

### ✅ Definition of Done:
- [ ] Funciones offline documentadas
- [ ] Colas verificadas
- [ ] Estrategia de conflictos definida
- [ ] Indicadores de estado visibles

---

## FASE 7: SECURITY & DEPENDENCIES 🔐
**Duración:** 1 sesión
**Skills:** `tool-seguridad-ia`, `tool-web-security-audit` (capa web), `/security-review`, `/code-review`, `backend-development`

### 7A. Secrets & Code:
```bash
# Buscar secrets hardcodeados
grep -rn "sk_live\|pk_live\|password\|secret\|apikey" mobile/ --include="*.ts" --include="*.tsx" | grep -v node_modules

# Verificar .gitignore
cat .gitignore | grep -E "env|secret|key"
```
- [ ] 0 secrets en código fuente
- [ ] `.env` en `.gitignore`
- [ ] Tokens en `expo-secure-store` (no AsyncStorage)

### 7B. Dependency Audit:
```bash
npm audit --omit=dev
npx expo-doctor
```
- [ ] 0 vulnerabilidades críticas (CVE)
- [ ] SDK de Expo compatible con todas las dependencias
- [ ] No hay paquetes deprecados sin alternativa

### 7C. OWASP MASVS:
- [ ] **Storage:** No datos sensibles sin cifrar
- [ ] **Crypto:** Tokens en expo-secure-store
- [ ] **Network:** HTTPS obligatorio, certificate pinning
- [ ] **Auth:** Sesiones expiran, refresh tokens rotados
- [ ] **Platform:** Permisos mínimos en `app.json`
- [ ] **Code Quality:** ProGuard/R8 en release, no debug flags

### 7D. Supabase:
- [ ] RLS completo en todas las tablas
- [ ] Storage policies en todos los buckets
- [ ] Edge Functions con auth guard

### ✅ Definition of Done:
- [ ] 0 secrets en código
- [ ] 0 CVEs críticas
- [ ] RLS + Storage policies completos
- [ ] Security report generado

---

## FASE 8: AI & LOCAL LLM AUDIT 🧠
**Duración:** 1-2 sesiones
**Skills:** `Explore` (built-in), debugging sistemático

### AI Lifecycle:
- [ ] ¿Grace period antes de descargar modelo al pasar a background? (≥5s)
- [ ] ¿Guard que previene unload mientras el modelo se está cargando?
- [ ] ¿Eventos transitorios de OS ignorados (solo background real descarga)?
- [ ] ¿Semáforo de descarga previene descargas dobles/concurrentes?
- [ ] ¿Validación de integridad del archivo (tamaño mínimo) antes de inicializar?
- [ ] ¿Estado del store (brain icon) sincronizado con el handle real del modelo?

### AI Generation:
- [ ] ¿Mutex/Cola en la generación del LLM para evitar crashes C++ concurrentes?
- [ ] ¿Parámetros anti-repetición (repeat_penalty, frequency_penalty) configurados?
- [ ] ¿maxTokens y temperature se propagan end-to-end hasta la capa nativa?
- [ ] ¿Throttling en observers automáticos (cooldown, radio silence, navigation guard)?

### AI Voice Stack:
- [ ] ¿TTS inicializa sin crash (assets verificados)?
- [ ] ¿STT carga modelo correctamente?
- [ ] ¿Gestión de sesión de audio previene deadlocks?
- [ ] ¿Pipeline completa STT → LLM → TTS funciona sin timeout?
- [ ] ¿Indicador visual refleja estado real del stack de voz?

### AI RAG & Embeddings:
- [ ] ¿Embeddings locales con dimensiones consistentes? (768-dim)
- [ ] ¿Hybrid search (local + cloud) funciona?
- [ ] ¿Context window respeta el tier del dispositivo?

### Model Garbage Collection:
- [ ] ¿Se eliminan modelos `.gguf` antiguos al descargar nueva versión?
- [ ] ¿Hay mecanismo de verificación de versión de modelo?
- [ ] ¿Se libera espacio tras actualización exitosa?

### ✅ Definition of Done:
- [ ] Lifecycle estable (no aggressive unload)
- [ ] Generation sin crashes ni repetición
- [ ] Voice pipeline funcional end-to-end
- [ ] RAG retorna resultados relevantes
- [ ] Modelos antiguos no acumulan espacio

---

## FASE 9: PRODUCTION READINESS
**Duración:** 1 sesión
**Skills:** `ui-ux-pro-max`, `react-best-practices`, `/simplify`

### 9A. i18n Ready
- [ ] Strings hardcodeadas identificadas
- [ ] Fechas/números formateados con locale
- [ ] RTL considerado en layouts

### 9B. Deep Linking
- [ ] `app.json` tiene `scheme` configurado
- [ ] Rutas críticas accesibles desde URLs externas
- [ ] Notificaciones push abren pantalla correcta

### 9C. Analytics
- [ ] Eventos críticos trackeados (session_created, match_completed, ai_chat_sent)
- [ ] Error reporting (Sentry/similar) configurado

### 9D. Accessibility
- [ ] Labels en elementos interactivos
- [ ] Contraste mínimo WCAG AA
- [ ] Touch targets ≥44px

### ✅ Definition of Done:
- [ ] Informe de production readiness
- [ ] Deep links documentados

---

## FASE 10: PERFORMANCE PROFILING 📊
**Duración:** 1-2 sesiones
**Skills:** `ui-ux-pro-max`, `react-best-practices`

### 10A. Memory
- [ ] ¿RAM usage con LLM cargado < 2GB?
- [ ] ¿Memory leaks en navegación repetida?
- [ ] ¿Model unload libera memoria efectivamente?

### 10B. CPU/GPU & Rendering
- [ ] ¿LLM inference no bloquea UI thread?
- [ ] ¿Animations en UI thread (Reanimated), no JS thread?
- [ ] ¿60fps en pantallas core?
- [ ] ¿Sin jank en scroll?

### 10C. AI Timing (KPIs)
- [ ] **TTI (Time To Interactive):** ¿Tiempo desde app open hasta pantalla usable? Target: < 3s
- [ ] **TTR (Time To Ready):** ¿Tiempo hasta que el brain icon se pone verde? Target: < 15s (sin descarga)
- [ ] **TTFG (Time To First Generation):** ¿Tiempo desde enviar prompt hasta primer token? Target: < 2s

### 10D. Battery & Bundle
- [ ] ¿Background drain < 5%/hora?
- [ ] ¿Keep-awake solo durante inference activa?
- [ ] ¿APK size < 50MB (sin models)?
- [ ] ¿Models descargados post-install (no bundled)?

### Herramientas (Android; ajusta `<package.id>` y `<app-dir>` al proyecto):
```bash
# Memory profiling
adb shell dumpsys meminfo <package.id>

# CPU usage
adb shell top -n 1 | grep <package.id>

# APK size
ls -lh <app-dir>/android/app/build/outputs/apk/release/
```

### ✅ Definition of Done:
- [ ] 60fps en pantallas core
- [ ] RAM < 2GB con LLM loaded
- [ ] TTR < 15s documentado
- [ ] Sin memory leaks detectados

---

## FASE 11: CI/CD, DEVOPS & OTA
**Duración:** 1 sesión
**Skills:** `automation-client-deploy` / `vercel-deploy`

### EAS Build:
```yaml
# eas.json profiles
- development: Internal testing (dev client)
- preview: Stakeholder testing
- production: Play Console release
```

- [ ] `eas.json` configurado con perfiles (development, preview, production)
- [ ] PR checks en GitHub (tsc, eslint, jest)
- [ ] Build automático en merge a main
- [ ] `eas submit` configurado para Play Console
- [ ] Secrets en GitHub Secrets (no en código)

### EAS Update (OTA):
- [ ] `eas update` configurado
- [ ] Canales `preview` y `production` definidos
- [ ] Runtime policy definida (`appVersion` o `nativeVersion`)
- [ ] Rollback strategy documentada

### ✅ Definition of Done:
- [ ] Pipeline funcional
- [ ] OTA channels configurados
- [ ] Deploy path documentado

---

## FASE 12: INFORME FINAL
**Duración:** 30 minutos
**Skills:** documentación, `tool-output-verifier` / `tool-quality-gate`, `meta-skill-creator`

### Formato:
```
✅ Lo que funciona correctamente
⚠️ Lo que funciona pero es frágil
❌ Lo que no funciona o falta
🛠️ Qué hay que corregir (priorizado P0/P1/P2)
🧹 Qué se puede limpiar
📊 Métricas: coverage, bundle size, RAM, TTR, APK size
🔐 Estado de seguridad
🧠 Estado del AI stack
```

### ✅ Definition of Done:
- [ ] Informe completo entregado
- [ ] Prioridades claras (P0/P1/P2)
- [ ] Próximos pasos definidos

---

## 📊 ENTREGABLES

| # | Entregable | Formato | Fase |
|---|------------|---------|------|
| 1 | Mapa de Arquitectura | MD | 0 |
| 2 | Inventario Elementos | Tabla | 1 |
| 3 | Código Implementado | TSX | 2 |
| 4 | Auditoría DB + Vectores | MD | 3 |
| 5 | Datos DEMO + Coverage | Registros | 4 |
| 6 | Checklist Flujos | MD | 5 |
| 7 | Informe Offline + Conflictos | MD | 6 |
| 8 | Security + Dependency Report | MD | 7 |
| 9 | AI Stack Report | MD | 8 |
| 10 | Production Readiness | MD | 9 |
| 11 | Perf Report + TTR/TTI | MD | 10 |
| 12 | CI/CD + OTA Setup | MD | 11 |
| 13 | Informe Final | MD | 12 |

---

## 📝 INTEGRACIÓN CON LA CADENA DE DISEÑO DEL OS

**Orden correcto:**
1. Primero: `ui-ux-pro-max` + `usability-retention-review` → auditoría visual/UX y de retención.
2. Después: `code-audit-integral` (esta skill) → auditoría técnica (13 fases).

**Complemento:** la fase de UX produce el diagnóstico de diseño; esta auditoría valida que el
código implemente correctamente lo que UX definió y que sea seguro/estable para producción.

---

## 🔄 POST-AUDITORÍA

1. **Guardar** el informe en `projects/code-audit-integral/<YYYY-MM-DD>-<titulo>/` (convención de outputs del OS).
2. **Actualizar** la tabla "Estado del Audit" al inicio de este documento.
3. **Capturar patrones** repetibles con `meta-skill-creator` (si surge una skill nueva) o `/aprende`.
4. **Configurar** CI/CD + deploy si no existe (Fase 11) vía `automation-client-deploy` / `vercel-deploy`.
5. **Próxima** auditoría: 2-4 semanas.

---

## Keywords

code-audit, backend, database, security, dependencies, cve, ai-llm, gguf, offline-first, conflict-resolution, i18n, deep-linking, analytics, accessibility, performance, tti, ttr, ci-cd, eas-build, eas-update, ota, owasp, vector-index
