-- Staging over the raw ad_fields seed: conforms the enterprise ID to a single
-- representation before any matching, passing every other column through
-- unchanged. GUIDs are case-insensitive and each system stores them per its own
-- convention (SAP uppercase, BST/AD lowercase), so we case-fold to lowercase;
-- the all-zeros placeholder GUID written by early backfill tooling means
-- "unassigned", so it collapses to null.
select * replace (
    nullif(lower(enterprise_id), '00000000-0000-0000-0000-000000000000') as enterprise_id
)
from {{ ref('ad_fields') }}
