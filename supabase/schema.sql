-- Tech Light Up: starting schema (PostgreSQL / Supabase)
create extension if not exists "pgcrypto";

create type app_role as enum ('visitor','talent','expert','ngo','admin');
create type request_status as enum ('new','in_review','confirmed','declined','done');

create table profiles (
  id uuid primary key references auth.users on delete cascade,
  full_name text, role app_role not null default 'visitor', created_at timestamptz default now()
);

create table ngo_categories (id serial primary key, name text unique not null);
create table ngos (
  id uuid primary key default gen_random_uuid(), name text not null, city text check (city in ('Bangalore','Chennai')),
  area text, category_id int references ngo_categories, description text, image_path text, published boolean default true, created_at timestamptz default now()
);
create table volunteer_needs (id uuid primary key default gen_random_uuid(), ngo_id uuid references ngos on delete cascade, need text not null, is_sample boolean default true);
create table volunteer_signups (
  id uuid primary key default gen_random_uuid(), full_name text not null, contact text not null, city text, ngo_id uuid references ngos,
  help_type text, message text, status request_status default 'new', created_at timestamptz default now()
);

create table talents (
  id uuid primary key default gen_random_uuid(), owner_id uuid references profiles, name text not null, kind text check (kind in ('Individual','Group')) default 'Individual',
  age int, city text check (city in ('Bangalore','Chennai')), talent text not null, community text, photo_path text,
  consent boolean not null default false, approved boolean not null default false, created_at timestamptz default now(),
  constraint consent_required check (consent = true)
);

create table experts (
  id uuid primary key default gen_random_uuid(), slug text unique not null, owner_id uuid references profiles, name text not null, role_line text,
  categories text[] default '{}', topics_line text, summary text, roles text[] default '{}', facts text[] default '{}', about text[] default '{}',
  sections jsonb default '[]', expertise text[] default '{}', topics text[] default '{}', available_for text[] default '{}', works_across text[] default '{}',
  linkedin_url text, source_url text, cover_path text, profile_photo_path text, published boolean default false, created_at timestamptz default now()
);
create table expert_media (id uuid primary key default gen_random_uuid(), expert_id uuid references experts on delete cascade, path text not null, caption text, fit text default 'cover', sort int default 0);

create table workshops (id uuid primary key default gen_random_uuid(), title text not null, description text, audience text[] default '{}', image_key text, published boolean default true);
create table workshop_sessions (
  id uuid primary key default gen_random_uuid(), workshop_id uuid references workshops, title text, venue text, starts_on date, date_note text,
  beneficiary text, steps jsonb default '[]'
);
create table session_team_members (id uuid primary key default gen_random_uuid(), session_id uuid references workshop_sessions on delete cascade, team text check (team in ('guidance','execution','content')), name text not null, note text);
create table workshop_registrations (id uuid primary key default gen_random_uuid(), workshop_id uuid references workshops, full_name text not null, contact text not null, status request_status default 'new', created_at timestamptz default now());
create table session_bookings (id uuid primary key default gen_random_uuid(), expert_id uuid references experts, requester text not null, contact text not null, group_size text, need text, status request_status default 'new', created_at timestamptz default now());
create table hire_requests (id uuid primary key default gen_random_uuid(), requester text not null, contact text not null, event_type text, talent_needed text, event_date date, city text, details text, status request_status default 'new', reference text default substr(md5(random()::text),1,8), created_at timestamptz default now());

create table jobs (id uuid primary key default gen_random_uuid(), title text not null, description text, city text, employer text, is_sample boolean default true, published boolean default false, created_at timestamptz default now());
create table job_applications (id uuid primary key default gen_random_uuid(), job_id uuid references jobs, full_name text not null, contact text not null, created_at timestamptz default now());

create table past_events (id uuid primary key default gen_random_uuid(), headline text not null, venue_or_ngo text, blurb text, sort int default 0);
create table event_photos (id uuid primary key default gen_random_uuid(), event_id uuid references past_events on delete cascade, path text not null, caption text, layout text default 'sq', consent_confirmed boolean default false, sort int default 0);

create table messages (id uuid primary key default gen_random_uuid(), thread_ref text not null, sender uuid references profiles, body text not null, created_at timestamptz default now());
create table audit_log (id bigserial primary key, actor uuid, action text, entity text, entity_id text, at timestamptz default now());

-- Row level security
create or replace function is_admin() returns boolean language sql stable as $$
  select exists (select 1 from profiles where id = auth.uid() and role = 'admin') $$;

alter table ngos enable row level security;            create policy "public read" on ngos for select using (published);            create policy "admin all" on ngos for all using (is_admin());
alter table volunteer_needs enable row level security; create policy "public read" on volunteer_needs for select using (true);       create policy "admin all" on volunteer_needs for all using (is_admin());
alter table talents enable row level security;
create policy "public read approved" on talents for select using (approved);
create policy "owner read" on talents for select using (owner_id = auth.uid());
create policy "owner write" on talents for insert with check (owner_id = auth.uid() and consent);
create policy "owner update" on talents for update using (owner_id = auth.uid()) with check (owner_id = auth.uid() and consent and approved = false);
create policy "admin all" on talents for all using (is_admin());
alter table experts enable row level security;         create policy "public read" on experts for select using (published);          create policy "admin all" on experts for all using (is_admin());
alter table expert_media enable row level security;    create policy "public read" on expert_media for select using (true);          create policy "admin all" on expert_media for all using (is_admin());
alter table workshops enable row level security;       create policy "public read" on workshops for select using (published);        create policy "admin all" on workshops for all using (is_admin());
alter table jobs enable row level security;            create policy "public read" on jobs for select using (published);             create policy "admin all" on jobs for all using (is_admin());
alter table past_events enable row level security;     create policy "public read" on past_events for select using (true);           create policy "admin all" on past_events for all using (is_admin());
alter table event_photos enable row level security;    create policy "public read confirmed" on event_photos for select using (consent_confirmed); create policy "admin all" on event_photos for all using (is_admin());
-- Form tables: anyone may insert, only admin may read
alter table volunteer_signups enable row level security;  create policy "anyone insert" on volunteer_signups for insert with check (true);  create policy "admin read" on volunteer_signups for select using (is_admin());
alter table workshop_registrations enable row level security; create policy "anyone insert" on workshop_registrations for insert with check (true); create policy "admin read" on workshop_registrations for select using (is_admin());
alter table session_bookings enable row level security;   create policy "anyone insert" on session_bookings for insert with check (true);   create policy "admin read" on session_bookings for select using (is_admin());
alter table hire_requests enable row level security;      create policy "anyone insert" on hire_requests for insert with check (true);      create policy "admin read" on hire_requests for select using (is_admin());
alter table job_applications enable row level security;   create policy "anyone insert" on job_applications for insert with check (true);   create policy "admin read" on job_applications for select using (is_admin());
alter table messages enable row level security;           create policy "admin all" on messages for all using (is_admin());
