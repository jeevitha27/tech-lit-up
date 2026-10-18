# Tech Light Up: Project Requirement Document (v2)

*Empowering Abilities · Bangalore and Chennai · Reflects the live prototype as of 13 Oct 2026*

## 1. Overview
Tech Light Up is a web platform where NGOs, specially abled people and underprivileged students get a stage, skills and careers. Companies, temples and event organisers can hire artists and groups, book workshops and sessions with experts, list jobs, and volunteer. Motto: **Technology for everyone. Opportunity for every ability.**
Reference sites: atypicaladvantage.in (concept), OKRE (white background, bold circles and pills).

## 2. Goals
1. Let anyone hire specially abled artists or groups from partner NGOs.
2. Let anyone book workshops and expert sessions for specially abled or underprivileged learners.
3. List every NGO's volunteering needs and match volunteers to them.
4. Give corporates a place to list openings for trained candidates.
5. Keep conversations and bookings on the platform.

## 3. Users and roles
| Role | Needs |
|---|---|
| Visitor / corporate / event organiser | Browse, hire talent, book workshops and sessions |
| Volunteer | See NGO needs, submit interest |
| Talent (individual or group) | Own profile, add or edit with consent |
| Expert | Profile with sessions, receives booking requests |
| NGO coordinator | Manage NGO page and volunteer needs |
| Admin (Tech Light Up team) | Approve profiles and NGOs, handle requests, export data |

## 4. Information architecture (7 tabs)
| Tab | Purpose | Key content and features |
|---|---|---|
| Home | Story and discovery | Hero with rotating photo ring and spinning turbine logo; photo marquee; empowerment banner (6 people); vision and 8 "Why we need this" icon cards; stats; city filter (Bangalore, Chennai); partner NGOs with category filter; 7 bookable workshops tagged specially abled / underprivileged; upcoming workshops with guidance and execution teams; past workshops (At Christel House); captioned photo collage (At Unnati Foundation); workshop registration form |
| Volunteer Needs | Where to help | Each NGO's needs; "I want to help" links to the volunteer form |
| Talent | Directory | Cards from database, search with voice, filters (city, talent, individual or group), add or edit profile with consent, performance gallery |
| Experts & Sessions | Book expertise | Hero, category chips, search, expert cards, **Book a session** and **Know more** (full profile page), booking form |
| Hire | Book artists | Featured talent (Sunadha Band, Sunadha Dance Troupe), event request form (corporate, temple, festival, school) |
| Careers | Jobs | Context first (outcomes and call to action), illustrated career panels, three steps, open roles with descriptions, corporates can list roles |
| Volunteer | Contribute beyond donations | Heading "Ready to Make a Difference Beyond Donations? Then Volunteer", typewriter message, ways to help, how matching works, interest form |

## 5. Content inventory (seed data in `data/seed.json`)
- **NGOs:** Samarthanam International (HSR Layout, workshops after Oct 15), Win Vinaya (past Utopus CSR partner), Unnati Foundation (free 35-day training to employment), Vindhya (skills, jobs and AI for persons with disabilities, women, underserved).
- **Workshops:** Dance & Movement, Effective Communication, AI & Technology Awareness, Singing & Music, Social Media Awareness, Craft & Arts, Hotel Management.
- **Upcoming:** Workshop 1 Dance (Bharatnatyam): beneficiary Samarthanam, guidance Prathiba Narayani (Hreem Kari School), execution Arul, Srujana, Swathi, Jeevitha; Workshop 2 Effective Communication (Speechcraft, 5 steps): guidance Arvind, Anugrah; execution Trevita, Sapna, Sandhi, Niraj, Swapnil, Abhinaba, Kirti; content creators Shanmukha, Mahantesh.
- **Experts:** Jeevitha Pandurangaiah (Data Engineer, Vestas; Toastmasters club president), CM Manjunath (corporate trainer, storytelling facilitator, digital marketing trainer), Srujana Kodati (SDE at IBM, Bharatnatyam dancer).
- **Talent:** Renuka, Sridevi, Chinnari, Usha, Praveen, Sunadha Dance Troupe, Sunadha Band.
- **Jobs:** 8 roles (one real Win Vinaya trainee posting for deaf candidates in Tirunelveli; the rest are samples).

## 6. Functional requirements
- **FR-1 NGO directory:** list, filter by category and city, detail with needs.
- **FR-2 Volunteer signup:** name, contact, city, NGO, help type, message; confirmation and admin notification.
- **FR-3 Workshop booking and registration:** request form, admin follow-up by email or WhatsApp.
- **FR-4 Talent profiles:** create, edit, delete by owner or admin; consent checkbox mandatory; admin approval before public.
- **FR-5 Talent search:** text, voice, filters by city, talent, type.
- **FR-6 Hire request:** event type, talent, date, city, details; status tracking.
- **FR-7 Experts:** profile (role, categories, topics, bio sections, expertise, availability, links, showcase media); category filter; search; Book a session; Know more page.
- **FR-8 Careers:** roles with description and apply; corporate listing request; admin publishes.
- **FR-9 Admin panel:** approve, edit, export CSV for every table above.
- **FR-10 In-platform messaging:** after a booking is confirmed, contact details revealed; no raw phone numbers before that.
- **FR-11 Notifications:** email now; WhatsApp as alert-only links back to the site.

## 7. Design system
- **Colours:** background white `#ffffff`; pink `#d6336c` (primary action); teal `#2c8f84`; navy `#262d5e` (text and headings `#1d2144`); blue `#1f6f9a`; gold `#f1c75b`/`#c98a14`; light pink panel `#fdeef3`.
- **Type:** Century Gothic / Avenir Next / Calibri / Arial, headings weight 800.
- **Shapes:** circles, pills, rounded cards (22-26px), flat buttons (6px radius), no heavy shadows.
- **Motion (all off under reduced motion):** rotating photo ring with upright photos, spinning turbine, scrolling photo strips, floating icons, typewriter message, gentle zoom on collage tiles.
- **Imagery:** real photos from NGOs and events (unaltered, cropped only); illustrated scenes for workshops and careers where no photo exists (people drawn with wheelchairs, blindfolds and sunglasses as relevant).
- **Inclusion tags:** pink = specially abled, teal = underprivileged, on every workshop card.

## 8. Non-functional requirements
- **Accessibility:** WCAG 2.2 AA, keyboard navigation, labels and alt text on all images, text size toggle, high-contrast mode, read-aloud, voice search, reduced motion respected.
- **Privacy:** consent for every profile and photo; guardian consent for minors; do not publish phone numbers; comply with India's DPDP Act 2023; photos of children only with school and parent consent.
- **Performance:** production images through a CDN with responsive sizes (prototype uses resized JPEGs in `assets/img`); LCP under 2.5 s on 4G.
- **Security:** row-level security on every table, server-side validation, rate-limited forms, spam protection.
- **Internationalisation:** English now; Kannada and Tamil planned.

## 9. Data model
`ngos`, `ngo_categories`, `volunteer_needs`, `volunteer_signups`, `talents`, `experts`, `expert_media`, `workshops`, `workshop_sessions`, `session_team_members`, `workshop_registrations`, `session_bookings`, `hire_requests`, `jobs`, `job_applications`, `past_events`, `event_photos`, `profiles` (auth users with roles), `messages`. Full SQL in `supabase/schema.sql`.

## 10. Technology
Next.js (App Router, TypeScript), Tailwind CSS, Supabase (PostgreSQL, Auth, Storage, RLS, Realtime), Zod and React Hook Form, Resend (email), WhatsApp Business or MSG91 (alerts), Vercel (hosting), Sentry and PostHog. Optional: Claude API for an accessible assistant; Google Places API into a staging table for NGO discovery with admin approval.

## 11. Prototype status and gaps
- The current site is a static prototype (`index.html`, `styles.css`, `app.js`). Forms are demo only; talent profiles save in the browser (`localStorage`).
- Sample or placeholder data: NGO volunteer needs, most jobs, session availability, photo captions.
- To confirm: CM Manjunath's title and credentials (LinkedIn could not be read), Srujana's availability, event names for captions, Win Vinaya posting still open, consent for photos of children, real contact channels.
- Not yet built: login, database, admin panel, messaging, email, other experts from the template (Niraj Kumar, Swathi R, Arul, Jeevitha S, Mahantesh, Vidhita, Shivam).

## 12. Roadmap
1. **Phase 1 (MVP):** database, NGO directory, volunteer needs and signup, workshops and registration, talent directory, hire request, email notifications.
2. **Phase 2:** experts and session booking, careers, admin panel, auth and profile editing.
3. **Phase 3:** in-platform messaging, voice and read-aloud polish, Kannada and Tamil, analytics, testimonials.
