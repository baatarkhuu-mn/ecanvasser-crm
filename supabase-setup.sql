-- ============================================================
-- eCanvasser CRM — Supabase өгөгдлийн сангийн тохиргоо
-- Supabase Dashboard → SQL Editor → New query → энэ файлыг
-- бүхэлд нь хуулж буулгаад RUN дарна.
-- ============================================================

-- Сонгогчдын хүснэгт
create table if not exists contacts (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  ward text default '',
  phone text default '',
  stance text default 'Тэнцсэн',
  support int default 50,
  last_contact text default 'Өнөөдөр',
  created_at timestamptz default now()
);

-- Хамгаалалт: зөвхөн нэвтэрсэн хэрэглэгч унших/бичих эрхтэй.
-- (anon түлхүүр нийтэд ил байсан ч нэвтрээгүй хүн юу ч харахгүй)
alter table contacts enable row level security;

drop policy if exists "authenticated read"   on contacts;
drop policy if exists "authenticated insert" on contacts;
drop policy if exists "authenticated update" on contacts;
drop policy if exists "authenticated delete" on contacts;

create policy "authenticated read"   on contacts for select to authenticated using (true);
create policy "authenticated insert" on contacts for insert to authenticated with check (true);
create policy "authenticated update" on contacts for update to authenticated using (true);
create policy "authenticated delete" on contacts for delete to authenticated using (true);

-- Эхлэлийн (демо) өгөгдөл — хүсвэл энэ хэсгийг алгасаж болно
insert into contacts (name, ward, phone, stance, support, last_contact) values
 ('Б. Болормаа',   '3-р хороо', '9911-2233', 'Дэмжигч',      92, '2 хоног'),
 ('Д. Ганбат',     '5-р хороо', '8800-4521', 'Эргэлзэж буй', 48, '4 хоног'),
 ('Н. Сараа',      '1-р хороо', '9090-1122', 'Дэмжигч',      88, '1 хоног'),
 ('Ц. Энхтуяа',    '7-р хороо', '9555-6677', 'Тэнцсэн',      60, '5 хоног'),
 ('Г. Бат-Эрдэнэ', '3-р хороо', '8811-9900', 'Эсрэг',        18, '1 долоо хоног'),
 ('О. Мөнхзул',    '2-р хороо', '9933-2211', 'Дэмжигч',      79, '3 хоног'),
 ('Л. Тэмүүлэн',   '5-р хороо', '8877-6655', 'Эргэлзэж буй', 41, '6 хоног'),
 ('Ж. Оюунчимэг',  '1-р хороо', '9012-3456', 'Тэнцсэн',      55, '2 хоног'),
 ('Б. Тэгшбаяр',   '7-р хороо', '9876-5432', 'Дэмжигч',      84, 'Өнөөдөр'),
 ('С. Алтанцэцэг', '2-р хороо', '9123-4567', 'Эсрэг',        22, '1 долоо хоног'),
 ('Х. Дөлгөөн',    '3-р хороо', '9234-5678', 'Дэмжигч',      90, '1 хоног'),
 ('Р. Мягмар',     '5-р хороо', '9345-6789', 'Тэнцсэн',      58, '4 хоног');
