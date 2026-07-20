-- Staging over the raw bst_fields seed: conforms the enterprise ID to a single
-- representation before any matching, passing every other column through
-- unchanged. GUIDs are case-insensitive and each system stores them per its own
-- convention (SAP uppercase, BST/AD lowercase), so we case-fold to lowercase;
-- the all-zeros placeholder GUID written by early backfill tooling means
-- "unassigned", so it collapses to null.
select * replace (
    nullif(lower(entrpr_guid), '00000000-0000-0000-0000-000000000000') as entrpr_guid
)
from {{ ref('bst_fields') }}
