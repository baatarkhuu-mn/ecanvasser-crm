# eCanvasser CRM — Кампанит ажлын платформ

Монгол хэл дээрх кампанит ажлын CRM. Нэг файлтай статик сайт + Supabase өгөгдлийн сан.

**Live:** https://eazzaya10-oss.github.io/ecanvasser-crm/

## Горимууд

- **Демо горим** — `index.html` доторх `SB_URL`/`SB_KEY` хоосон үед. Бүх өгөгдөл зохиомол, юу ч хадгалагдахгүй.
- **Жинхэнэ горим** — Supabase холбосон үед. Сонгогчдыг нэмэх/засах/устгах нь өгөгдлийн санд хадгалагдаж, бүх төхөөрөмж дээр ижил харагдана. Нэвтрэхэд жинхэнэ и-мэйл/нууц үг шаардана.

## Supabase холбох заавар

1. [supabase.com](https://supabase.com) дээр бүртгүүлнэ (GitHub-аараа нэвтэрч болно) → **New project** үүсгэнэ
2. **SQL Editor** → New query → энэ repo-гийн [`supabase-setup.sql`](supabase-setup.sql) файлын агуулгыг хуулж буулгаад **Run** дарна
3. **Authentication → Users → Add user** — админы и-мэйл, нууц үг оруулна (**Auto Confirm User** чагтална)
4. **Project Settings → API** хэсгээс дараах 2 утгыг авна:
   - Project URL (жишээ: `https://xxxx.supabase.co`)
   - `anon` `public` түлхүүр
5. `index.html` доторх `SB_URL`, `SB_KEY`-д утгуудыг оруулаад commit + push хийнэ

> **Нууцлал:** `anon` түлхүүр нийтэд ил байхад зориулагдсан — хүснэгтийн хамгаалалт (RLS) нь нэвтрээгүй хүнд өгөгдөл өгөхгүй. Харин **Service Role** түлхүүрийг хэзээ ч кодод бүү оруул.
