-- ============================================================
-- eCanvasser CRM — Үүргийн систем (админ / ухуулагч)
-- Supabase Dashboard → SQL Editor → New query → бүхэлд нь
-- хуулж буулгаад RUN дарна.
--
-- ⚠ ДООРХ 'eazzaya10@gmail.com'-ийг өөрийн админ и-мэйлээр
--   СОЛИНО УУ (өөр и-мэйлээр нэвтэрдэг бол)!
-- ============================================================

-- 1. Хэрэглэгчийн үүргийн хүснэгт
create table if not exists app_users (
  email text primary key,
  name text default '',
  role text not null default 'canvasser' check (role in ('admin','canvasser')),
  created_at timestamptz default now()
);
alter table app_users enable row level security;

-- Админ эсэхийг шалгах функц (RLS дүрмүүдэд ашиглана)
create or replace function is_admin() returns boolean
language sql security definer stable
set search_path = public
as $$
  select exists(
    select 1 from app_users
    where email = (auth.jwt()->>'email') and role = 'admin'
  );
$$;

drop policy if exists "own or admin read" on app_users;
create policy "own or admin read" on app_users for select to authenticated
  using (email = (auth.jwt()->>'email') or is_admin());
drop policy if exists "admin write" on app_users;
create policy "admin write" on app_users for all to authenticated
  using (is_admin()) with check (is_admin());

-- Эхний админыг бүртгэх (и-мэйлээ шалгаарай!)
insert into app_users (email, name, role)
values ('eazzaya10@gmail.com', 'Админ', 'admin')
on conflict (email) do update set role = 'admin';

-- 2. Ухуулагчид + КПИ хүснэгт
create table if not exists canvassers (
  id uuid primary key default gen_random_uuid(),
  email text unique not null,
  name text not null,
  ward text default '',
  reached int default 0,
  supporters int default 0,
  coverage int default 0,
  surveys int default 0,
  active boolean default true,
  created_at timestamptz default now()
);
alter table canvassers enable row level security;

drop policy if exists "admin all" on canvassers;
create policy "admin all" on canvassers for all to authenticated
  using (is_admin()) with check (is_admin());
drop policy if exists "own kpi" on canvassers;
create policy "own kpi" on canvassers for select to authenticated
  using (email = (auth.jwt()->>'email'));

-- 3. Сонгогчдын мэдээлэлд ЗӨВХӨН админ хүрнэ
--    (ухуулагч нэвтэрсэн ч сонгогчдыг харж чадахгүй болно)
drop policy if exists "authenticated read"   on contacts;
drop policy if exists "authenticated insert" on contacts;
drop policy if exists "authenticated update" on contacts;
drop policy if exists "authenticated delete" on contacts;
drop policy if exists "admin only" on contacts;
create policy "admin only" on contacts for all to authenticated
  using (is_admin()) with check (is_admin());
