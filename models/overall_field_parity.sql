-- Overall Field Parity: a single number summarising cross-system field parity.
-- The share of fields present in all three systems (the 1,1,1 region) out of
-- every field across all regions of field_parity. 1.0 means perfect parity
-- (every field exists in all three systems); values near 0 mean little overlap.

with field_parity as (

    select * from {{ ref('field_parity') }}

)

select
    1.0 * sum(case when bst = 1 and sap = 1 and ad = 1 then count else 0 end)
        / sum(count) as overall_field_parity
from field_parity
