# my-octanejs-exp

An interactive feature showcase for [OctaneJS](https://octanejs.dev) — demonstrating `@for`, `@if`, hooks anywhere (no rules of hooks), auto-inferred dependencies, and more.

## Tech stack

- **OctaneJS** — the source-aware JS framework this app showcases
- **Vite** — dev server and build tool
- **Tailwind CSS v4** — styling (via the Vite/PostCSS plugins)
- **TypeScript** — strict mode with the `@tsrx` compiler/plugin

## Getting started

```bash
npm install
npm run dev
```

Then open the URL Vite prints (default `http://localhost:5173`).

### Other scripts

| Command            | Description                        |
| ------------------ | ---------------------------------- |
| `npm run dev`      | Start the Vite dev server           |
| `npm run build`    | Production build to `dist/`         |
| `npm run typecheck`| Type-check the project (no emit)    |

## Project structure

```
src/
├── main.ts          # App entry point, mounts the root component
├── App.tsrx         # Root showcase component
├── components/      # Shared UI (Navbar, Footer, CodePanel)
├── sections/        # One section per featured OctaneJS feature
├── lib/             # Utilities (e.g. syntax highlighting)
└── styles/          # Global CSS
```

Each file in `src/sections/` demos a specific OctaneJS capability (effects, conditionals, loops, hooks anywhere, linked state, drafts, try/catch, performance).

## Tooling

- [`.prettierrc`](.prettierrc) — Prettier with the `@tsrx/prettier-plugin`
- [`tsconfig.json`](tsconfig.json) — strict TypeScript config with `jsxImportSource: "octane"`
- [`vite.config.ts`](vite.config.ts) — Vite wired to the Octane compiler and Tailwind