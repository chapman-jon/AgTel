# Snowflake warehouse migration — status notes (June 2026)

*Data Platform — T. Beaulieu. Rolling notes, newest on top.*

## 2026-06-24

- Finance marts cutover COMPLETE. Legacy SQL Server reporting DB is now read-only;
  decommission ticket filed for Q4.
- dbt is confirmed as the standard transformation tool on Snowflake going forward.
  New pipelines should be dbt projects from day one — no more hand-managed views.
  The platform team maintains the deployment template (schedules, CI, permissions);
  analysts own their models.
- Reminder: developing locally against DuckDB and deploying to Snowflake via a
  profile/config swap is the pattern the analytics teams have been using happily
  for a few months now. The platform team endorses it — just don't hardcode
  warehouse-specific SQL where you can avoid it.

## 2026-05-30

- Consultant activity dashboards migrated. Two weeks of parallel run vs legacy
  showed matching numbers except the known timezone issue in visit timestamps
  (documented in the dashboard footnotes).
- Snowflake spend alerting now live; warehouse auto-suspend at 5 min idle. If your
  scheduled job is slow on Monday mornings, that's the cold start, not a
  regression. Stop filing tickets about it.

## 2026-05-02

- AgDigital platform datasets now landing in Snowflake RAW zone nightly (including
  the legacy-port tables). Reporting-layer extracts from the older systems
  continue as flat files for now — those source systems predate the integration
  tooling and the juice isn't worth the squeeze until their roadmaps settle.
- Access model simplified: analysts get read on RAW + write on their team schema.

## 2026-04-10

- Kickoff notes archived. Original scope doc lives in the platform wiki under
  "Warehouse Consolidation 2025-2026."
