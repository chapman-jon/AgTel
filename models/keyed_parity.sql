-- Field-EID parity table: one row per Venn region, i.e. per distinct
-- combination of which systems contain a matchable field EID. BST, SAP and AD
-- are 1/0 membership flags; count is the number of field EIDs in that region,
-- farm_parity_count how many of them also have the farm level in parity, and
-- full_parity_count how many have the full farmer -> farm -> field hierarchy
-- in parity. Single-source regions have no counterpart system to match, so
-- their parity counts are always 0. The all-zero region never appears because
-- every field EID in keyed_joined belongs to at least one source.

with joined as (

    select * from {{ ref('keyed_joined') }}

)

select
    cast(in_bst as int) as bst,
    cast(in_sap as int) as sap,
    cast(in_ad as int)  as ad,
    count(*)            as count,
    sum(case when farm_in_parity then 1 else 0 end) as farm_parity_count,
    sum(case when full_in_parity then 1 else 0 end) as full_parity_count
from joined
group by 1, 2, 3
