# Prompts for AI agents

Use these in order. Each prompt assumes the agent has read `AGENTS.md` and `docs/PRD.md`. Paste one at a time and review before the next.

## Master prompt (paste first)
> You are a senior full-stack engineer. Read `AGENTS.md`, `docs/PRD.md`, `data/seed.json` and `supabase/schema.sql`. Build the production version of the Tech Light Up website in a new folder `web/` using Next.js (App Router, TypeScript), Tailwind CSS and Supabase. Match the look and behaviour of the prototype in `index.html`, `styles.css` and `app.js`: seven tabs (Home, Volunteer Needs, Talent, Experts & Sessions, Hire, Careers, Volunteer), white background, pink/teal/navy palette, rotating photo ring, spinning turbine logo, typewriter message, photo marquees, captioned collage, text-size, high-contrast, read-aloud and voice-search accessibility features. Use images from `assets/img/`. Work in the 12 steps of `docs/PROMPTS.md`; stop after each step with a summary and the commands to verify it. Never edit faces in photos and never invent facts about people.

## 1. Project setup
> Create `web/` with Next.js (App Router, TypeScript, Tailwind, ESLint). Add Zod, React Hook Form and `@supabase/supabase-js`. Copy `assets/img` to `web/public/img`. Set up design tokens in `tailwind.config.ts` (pink `#d6336c`, teal `#2c8f84`, navy `#262d5e`, blue `#1f6f9a`, gold `#f1c75b`), a root layout with the sticky header (turbine logo, "Tech Light Up" wordmark with tagline, 7 tab links, A+/contrast/read-aloud buttons) and a footer. Acceptance: `npm run dev` shows the header on every route, keyboard navigation works.

## 2. Database
> Apply `supabase/schema.sql` to a new Supabase project (write the migration in `supabase/migrations`). Write a seed script `web/scripts/seed.ts` that loads `data/seed.json` into the tables. Add typed helpers with generated Supabase types. Acceptance: tables exist, RLS enabled, seed runs idempotently.

## 3. Home page
> Build the Home route: hero with rotating photo ring (photos stay upright) and spinning turbine; photo marquee; empowerment banner with six people; vision with eight "Why we need this" cards; city filter (Bangalore, Chennai); partner NGOs with category filter; seven workshop cards with pink "specially abled" and teal "underprivileged" tags and illustrated images; upcoming workshops with teams; past workshops (At Christel House); captioned collage (At Unnati Foundation). All from the database. Respect `prefers-reduced-motion`. Acceptance: matches the prototype at 360px and 1280px.

## 4. NGOs and volunteer needs
> Build the Volunteer Needs route listing each NGO with its needs, and the Volunteer route (typewriter message, ways to help, how matching works, interest form). Form posts to a server action validated with Zod, saves to `volunteer_signups`, sends an email through Resend, shows a success message. Acceptance: invalid input shows accessible errors; row appears in the database.

## 5. Talent directory
> Build the Talent route: cards, text search plus voice search (Web Speech API), filters by city, talent and individual/group, performance gallery. Add Supabase Auth (email magic link). Signed-in talent can create and edit their own profile (name, age, city, talent, community) with a required consent checkbox; new profiles need admin approval before they are public. Acceptance: RLS blocks editing other people's profiles.

## 6. Experts & Sessions
> Build the Experts & Sessions route: hero with Learn/Grow/Make an Impact blocks, category chips, search, expert cards (photo, category pill, role, topics, short text, **Book a session**, **Know more**). Build `/experts/[slug]` with a showcase image row, About, section cards, expertise and topic chips, availability and a booking CTA. Booking form saves to `session_bookings` and emails the team. Seed Jeevitha Pandurangaiah, CM Manjunath and Srujana Kodati from `data/seed.json`. Acceptance: Know more page works for all three; unknown details are shown as TODO, not invented.

## 7. Hire and workshop booking
> Build the Hire route (featured Sunadha Band and Sunadha Dance Troupe, event request form) and the workshop registration form on Home. Save to `hire_requests` and `workshop_registrations`, email the team, and show a status page by reference number. Contact details of artists stay hidden until a request is confirmed. Acceptance: confirmation email and database row are created.

## 8. Careers
> Build the Careers route: outcomes and call-to-action text, six illustrated career panels, three step cards, open roles from `jobs` (expandable description, apply button saving to `job_applications`) and a "list your openings" form for corporates. Mark sample jobs clearly. Acceptance: admin can publish or hide a job.

## 9. Admin panel
> Build `/admin` (role `admin` only): tables to approve talent profiles, edit NGOs, needs, workshops, experts, jobs; view and update status of volunteer signups, hire requests, session bookings, registrations; CSV export for each. Acceptance: non-admin users are redirected; all actions are audited in `audit_log`.

## 10. Messaging and notifications
> Add in-platform messaging between a requester and the team after a booking is confirmed (Supabase Realtime). Email notifications with Resend; optional WhatsApp alert that only links back to the site. Acceptance: no phone numbers appear in public pages or API responses.

## 11. Accessibility and performance pass
> Run axe and Lighthouse on every route. Fix all serious issues. Verify keyboard-only use, screen-reader labels, text-size and high-contrast modes, read-aloud, reduced motion. Use `next/image` with responsive sizes and lazy loading. Targets: Lighthouse accessibility 95+, LCP under 2.5 s on 4G.

## 12. Deploy
> Deploy to Vercel with environment variables for Supabase and Resend. Add Sentry and PostHog. Write `docs/DEPLOY.md` with steps, environment variable names (no secrets) and a launch checklist including photo consent confirmation.

## Reusable prompts
- **Add an expert:** "Add a new expert from this profile text and these photos. Follow the structure of CM Manjunath in `data/seed.json`. Do not invent titles or credentials; mark missing details TODO."
- **Review:** "Review the last change for accessibility, privacy and PRD compliance. List problems by severity."
- **Content import:** "Convert this NGO list (table) into rows for `ngos`, `volunteer_needs` and `talents`, then update the seed script."
