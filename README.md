# Tech Light Up: Empowering Abilities

Static prototype of the Tech Light Up website plus everything an AI agent needs to build the production web app.

## Run the prototype
```
npx serve .          # or: python3 -m http.server 8080
```
Open http://localhost:3000 (or :8080).

## Folder guide
| Path | What it holds |
|---|---|
| `index.html`, `styles.css`, `app.js` | The prototype (7 tabs, vanilla JS) |
| `data/seed.json` | All content: NGOs, workshops, experts, talent, jobs, upcoming workshops |
| `assets/img/` | Resized images the prototype loads (by category) |
| `photos/` | Every photo and reference you shared, organised (originals, HEIC converted to JPG) |
| `docs/PRD.md` | Project Requirement Document v2 |
| `docs/PROMPTS.md` | Step-by-step prompts for AI agents |
| `docs/ASSET_MANIFEST.md` | Which photo is used where |
| `supabase/schema.sql` | Database schema and RLS policies |
| `AGENTS.md` | Instructions for Codex and other agents (`CLAUDE.md`, `GEMINI.md`, `.agent/` point to it) |

## Build the production app with an agent
1. Open this folder in Codex or Antigravity.
2. Paste the **Master prompt** from `docs/PROMPTS.md`, then work through steps 1 to 12.
