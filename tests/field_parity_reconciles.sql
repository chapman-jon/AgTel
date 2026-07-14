-- field_parity must account for every field in the universe: the fully-matched
-- non_null_joined triples plus every null-EID record from the three sources.
-- If the totals disagree, a null count landed in the wrong region (or nowhere).
with parity_total as (

    select sum(count) as total from {{ ref('field_parity') }}

),

expected_total as (

    select
        (select count(*) from {{ ref('non_null_joined') }})
        + (select count(*) from {{ ref('ad_null_fields') }})
        + (select count(*) from {{ ref('bst_null_fields') }})
        + (select count(*) from {{ ref('sap_null_plots') }}) as total

)

select *
from parity_total
cross join expected_total
where parity_total.total <> expected_total.total
