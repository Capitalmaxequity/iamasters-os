---
name: react-best-practices
description: React development guidelines with hooks, component patterns, state management, and performance optimization.
author: vercel
category: development
tags: [react, typescript, nextjs]
---

# React Best Practices

Modern guidelines for building performant, maintainable React and Next.js applications.

## Component Patterns
- **Functional Components**: Use arrow functions and Hooks for all components.
- **Composition**: Favor composition over inheritance; use children props for layout wrappers.
- **Typed Props**: Define interfaces for all component props using TypeScript.

## Hooks & State
- **Rule of Hooks**: Never call hooks inside loops, conditions, or nested functions.
- **Custom Hooks**: Extract complex logic into reusable custom hooks (e.g., `useAuth`, `useFetch`).
- **State Management**: Use local state (`useState`) for UI state, and context or specialized stores for global data.

## Performance
- **Memoization**: Use `useMemo` and `useCallback` sparingly to avoid expensive re-renders on every update.
- **Lazy Loading**: Use `React.lazy` and `Suspense` for large components or route-based code splitting.
- **Key Prop**: Always provide unique, stable `key` props for list items.

*Refer to [Vercel's official guidelines](https://github.com/vercel-labs/agent-skills) for specific enterprise patterns.*
