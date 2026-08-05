-- field_eid_parity must account for every field in the universe: the matchable
-- field EIDs in keyed_joined plus every unkeyed record from the three sources.
-- If the totals disagree, an unkeyed count landed in the wrong region (or
-- nowhere).
with parity_total as (

    select sum(count) as total from {{ ref('field_eid_parity') }}

),

expected_total as (

    select
        (select count(*) from {{ ref('keyed_joined') }})
        + (select count(*) from {{ ref('ad_unkeyed_fields') }})
        + (select count(*) from {{ ref('bst_unkeyed_fields') }})
        + (select count(*) from {{ ref('sap_unkeyed_plots') }}) as total

)

select *
from parity_total
cross join expected_total
where parity_total.total <> expected_total.total
