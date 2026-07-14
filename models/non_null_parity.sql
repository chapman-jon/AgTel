-- Field-parity table: one row per Venn region, i.e. per distinct combination of
-- which systems contain a fully-matched (farmer, farm, field) EID triple. BST,
-- SAP and AD are 1/0 membership flags and count is the number of triples in
-- that region. The all-zero region never appears because every triple in
-- non_null_joined belongs to at least one source.

with joined as (

    select * from {{ ref('non_null_joined') }}

)

select
    cast(in_bst as int) as bst,
    cast(in_sap as int) as sap,
    cast(in_ad as int)  as ad,
    count(*)            as count
from joined
group by 1, 2, 3
