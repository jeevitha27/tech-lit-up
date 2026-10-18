# AGENTS.md: Tech Light Up

Instructions for AI coding agents (Codex, Antigravity, Claude Code, Cursor). Read this file and `docs/PRD.md` before changing anything.

## What this project is
Tech Light Up connects NGOs, specially abled people and underprivileged students with stages, skills and careers. Anyone can hire artists, book workshops and expert sessions, list jobs, or volunteer. Cities: Bangalore and Chennai.

## Current state
- `index.html`, `styles.css`, `app.js`: working static prototype (vanilla JS, no build step). Forms are demo only.
- `data/seed.json`: all site content (NGOs, workshops, experts, talent, jobs, upcoming workshops).
- `assets/img/`: web-optimised images used by the prototype. `photos/`: organised originals. See `docs/ASSET_MANIFEST.md`.
- `supabase/schema.sql`: database schema and row-level security to start from.
- Target: production app in Next.js (App Router, TypeScript, Tailwind) with Supabase. Build it in a new folder `web/`; keep the prototype as the visual reference.

## Commands
- Run the prototype: `npx serve .` or `python3 -m http.server 8080`
- Production app (once created): `cd web && npm run dev`, `npm run lint`, `npm run build`

## Design tokens (match the prototype)
White background; pink `#d6336c` primary action; teal `#2c8f84`; navy `#262d5e`; blue `#1f6f9a`; gold `#f1c75b`. Headings weight 800 in Century Gothic / Avenir / Arial. Circles, pills, rounded cards, flat 6px buttons. Pink tag = specially abled, teal tag = underprivileged.

## Rules
1. **Accessibility first:** WCAG 2.2 AA, keyboard operable, alt text, visible focus, labels on every input, respect `prefers-reduced-motion`, keep the text-size, high-contrast, read-aloud and voice-search features.
2. **Photos:** never edit, filter or regenerate faces. Crop and resize only. Do not publish photos of children without recorded consent.
3. **Privacy:** consent checkbox required for every public profile; do not show phone numbers or emails publicly; validate all input on the server (Zod).
4. **Data:** treat `data/seed.json` as seed content. Mark placeholder content (NGO needs, sample jobs) as sample until confirmed.
5. **Do not invent facts** about people or organisations. If a detail is missing, leave a visible TODO and list it in the PR summary.
6. Use Supabase row-level security on every table; never expose the service role key to the browser.
7. Small commits, one feature per branch, conventional commit messages.

## Definition of done
Feature matches the PRD requirement, passes lint and build, works on 360px and 1280px widths, passes a keyboard-only run-through, has no console errors, and includes seed data or a migration.

## Open items to confirm with the owner
CM Manjunath's title and credentials; Srujana Kodati's availability; event names for photo captions; whether the Win Vinaya job posting is open; photo consent for children; real contact channels (email, WhatsApp).
