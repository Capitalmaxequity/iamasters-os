---
name: vercel-deploy
description: Despliega aplicaciones en Vercel (edge functions, serverless, ISR, zero-config Next.js). Úsala cuando el operador diga o pida "despliega esto en Vercel", "súbelo a Vercel", "pon esta web/app online en Vercel", "configura el deploy en Vercel" o cierre un proyecto web listo para producción en esa plataforma. Último paso de la cadena de construir web/app.
author: vercel
category: development
tags: [nextjs, node, typescript]
---

# Vercel Deploy

Best practices for deploying and managing applications on the Vercel platform.

## Core Features
- **Next.js Integration**: Optimized deployment for Next.js apps with zero-config.
- **Serverless Functions**: Scalable backend logic that runs on demand.
- **Edge Functions**: Low-latency functions that run at the network edge, closer to users.
- **ISR (Incremental Static Regeneration)**: Update static content after your site has been built.

## Deployment Workflow
1. **Connect Repository**: Link your GitHub/GitLab/Bitbucket repo to Vercel.
2. **Environment Variables**: Configure secrets and API keys in the Vercel Dashboard.
3. **Build Settings**: Vercel automatically detects Next.js, Vite, and other frameworks.
4. **Preview Deployments**: Every pull request gets a dedicated staging URL.

*Refer to [Vercel's agent-skills](https://github.com/vercel-labs/agent-skills) for advanced configurations.*
