---
name: notebooklm-mcp
description: Advanced MCP-based researcher for NotebookLM. Supports tool profiles (minimal/full), persistent auth, and library management. Use for multi-source grounded research.
---

# Skill: NotebookLM MCP Researcher

## Cuándo usar este skill
- Cuando necesites realizar investigación fundamentada (grounded) en documentos sin alucinaciones.
- Cuando quieras gestionar tu biblioteca de NotebookLM (añadir, listar, limpiar).
- Cuando necesites optimizar el uso de tokens mediante perfiles de herramientas.

## 🛠️ Tool Profiles (Token Optimization)
Usa estos perfiles para reducir el consumo de contexto. Configúralos antes de iniciar una sesión larga.

| Perfil | Herramientas | Uso | Comando de Configuración |
| :--- | :--- | :--- | :--- |
| **minimal** | 5 | Solo consultas básicas | `npx notebooklm-mcp config set profile minimal` |
| **standard** | 10 | + Gestión de biblioteca | `npx notebooklm-mcp config set profile standard` |
| **full** | 16 | Control total y limpieza | `npx notebooklm-mcp config set profile full` |

> [!TIP]
> Puedes deshabilitar herramientas específicas para ahorrar aún más:
> `npx notebooklm-mcp config set disabled-tools "cleanup_data,re_auth"`

## 🗣️ Common Commands (Intents)

| Intento | Frase Sugerida (Input) | Resultado |
| :--- | :--- | :--- |
| **Auth** | "Log me in to NotebookLM" | Abre Chrome para login manual |
| **Add** | "Add [link] to library" | Guarda el notebook con metadatos |
| **List** | "Show our notebooks" | Lista todos los notebooks guardados |
| **Research** | "Research this in NotebookLM before coding" | Inicia sesión de investigación iterativa |
| **Select** | "Use the [Name] notebook" | Establece el notebook activo |
| **Cleanup** | "Run NotebookLM cleanup" | Borra todos los datos (Fresh start) |
| **Stats** | "Show library stats" | Muestra uso de herramientas y biblioteca |

## 🧬 Multi-Account Intelligence
Este skill está configurado para realizar búsquedas exhaustivas priorizando las fuentes maestras. Si no se especifica una cuenta, el sistema consultará secuencialmente:
1.  **`capitalmaxequity`** & **`mrivascarrecas`** (mrivascarrecas@gmail.com): Fuentes principales de conocimiento especializado y estratégico (Mismo Nivel - Alta Prioridad).
2.  **`default`**: Biblioteca de apoyo y archivos generales.

El skill consolidará la información de todas las fuentes antes de entregar la respuesta final.

## Workflow de Ejecución

1. **Configuración de Perfil**: Si es una tarea simple, activa `minimal`.
2. **Autenticación**: Verifica con `npx notebooklm-mcp config get`. Si falla, usa "Log me in to NotebookLM".
3. **Selección de Fuente**: Asegúrate de tener el link del notebook o selecciónalo de la lista.
4. **Investigación**: Realiza la pregunta usando `ask_question`. El MCP responderá con citas directas de las fuentes.

## Manejo de Errores
- **Auth Timeout**: Si el login falla, usa "Repair NotebookLM authentication".
- **Token Overload**: Cambia al perfil `minimal` y limpia sesiones antiguas con `reset_session`.
- **Source Not Found**: Verifica que el notebook sea compartido como "Anyone with link".
