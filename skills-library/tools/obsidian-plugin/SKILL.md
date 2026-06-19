---
name: obsidian-plugin
description: Experto en desarrollar plugins de Obsidian con TypeScript y la Obsidian API (workspace, extensiones del editor, sistema de archivos, vistas personalizadas). Úsala cuando el operador diga o pida "crea un plugin de Obsidian", "desarrolla algo para Obsidian", "extiende Obsidian", "plugin para mi bóveda de notas" o trabaje sobre la API de Obsidian.
context: fork
model: sonnet
---

# Obsidian Plugin Development Skill

This skill provides comprehensive guidance for building and maintaining plugins for the Obsidian knowledge base application.

## Core Capabilities
- **Workspace Management**: Interacting with the Obsidian workspace, managing leaves, and handling view states.
- **Editor Extensions**: Extending the Markdown editor with custom decorators, commands, and syntax highlighting.
- **File System Interactions**: Efficiently reading, writing, and organizing files within the user's vault.
- **Custom View Creation**: Building complex React or Svelte views within the Obsidian interface.
- **Plugin Lifecycle**: Handling plugin initialization, configuration settings, and cleanup on disabling.

## Development Standards
- **Naming Conventions**: Follow strict naming rules for plugins and commands to ensure consistency and avoid collisions.
- **Accessibility**: Implement ARIA labels, keyboard navigation, and focus indicators for all custom UI elements.
- **Security**: Prevent XSS by sanitizing all user-generated content before rendering.
- **Performance**: Use efficient API calls and avoid blocking the main thread during heavy operations.

## Common Workflows
1. **Setting up the Project**: Initialize the plugin template with TypeScript and the Obsidian API definitions.
2. **Implementing Commands**: Registering custom commands to the Obsidian command palette.
3. **Designing Settings UI**: Creating a user-friendly interface for plugin configuration.
4. **Testing and Debugging**: Using the built-in Obsidian developer tools for inspection and logging.

## Resources
- [Obsidian API Documentation](https://github.com/obsidianmd/obsidian-api)
- [Plugin Developer Guide](https://docs.obsidian.md/Plugins/Getting+started)
