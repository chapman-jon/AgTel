# AD Legacy Port — Runbook & Data Notes

*AgDigital platform team — working notes (S. Chen)*
*Status: living document, updated as the port stabilizes*

These are the running notes for the AD dataset — the port of farmer/farm/field data from the legacy system into AgDigital's schema. Keeping this honest and current so people stop DMing me the same questions.

## What AD contains

- Farmer, farm, and field master data ported from the legacy system.
- Coverage: **US and Canada only** (`country_code` = `USA` / `CAN`). The legacy system never held other geographies, so neither does AD.
- The port ran in waves starting Oct 2024; `created_at` reflects when the record landed in AD, not when the entity originally came into existence in the legacy system. Don't use `created_at` for tenure analysis.

## Status values

`status` on all three tables:

- `active` — record is live. What you'd expect.
- `inactive` — record was live at some point but retired either in the legacy system before the port, or in AD since.
- `archived` — record was dead weight in the legacy system (duplicates, abandoned setups, ancient history) and was ported only for completeness/audit. Never operational in AD.

## Test records — please read

During port validation we created synthetic farmers/farms/fields to exercise the pipelines. These are flagged with `is_test = true`. **They were never cleaned up** (deliberately — we re-run validation after each wave), so any analysis on AD data must filter them out. Yes, some test records have `status = 'active'`; the status column reflects the simulated lifecycle, not whether the record is real. `is_test` is the only reliable indicator.

## Hierarchy

Strict farmer → farm → field. Every field belongs to exactly one farm, every farm to exactly one farmer. The port enforced this (legacy orphans were attached to placeholder parents and archived).

Note fields don't carry their own `country_code` — country is a property of the farm (fields inherit it). This matches the legacy model.

## Enterprise IDs

`enterprise_id` is stamped by the EDM assignment process downstream of the port; we don't populate it ourselves. Coverage is decent but not complete — assignment is still working through the backlog, so plenty of legitimate records still have it null. (See EDM's overview page if you don't know what Enterprise IDs are.)

## Known issues / gotchas

- `updated_at` is null for records untouched since their port wave landed.
- Farm/field names came over as-is from legacy; casing and punctuation are inconsistent. Do not match on names.
- Area (`area_ha`) is null where the legacy system had no boundary data.
