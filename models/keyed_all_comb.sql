-- keyed_parity guaranteed to carry every non-empty membership combination.
-- A region with no matchable field EIDs is absent from keyed_parity; this
-- model backfills those combinations with counts of 0 so all 2^3 - 1 = 7
-- non-empty (bst, sap, ad) combinations are always present. The all-zero
-- combination is intentionally excluded. Downstream of keyed_parity and
-- upstream of field_eid_parity.

with all_combinations as (

    select b.flag as bst, s.flag as sap, a.flag as ad
    from (values (0), (1)) as b(flag)
    cross join (values (0), (1)) as s(flag)
    cross join (values (0), (1)) as a(flag)
    where not (b.flag = 0 and s.flag = 0 and a.flag = 0)

),

keyed_parity as (

    select * from {{ ref('keyed_parity') }}

)

select
    all_combinations.bst,
    all_combinations.sap,
    all_combinations.ad,
    coalesce(keyed_parity.count, 0)             as count,
    coalesce(keyed_parity.farm_parity_count, 0) as farm_parity_count,
    coalesce(keyed_parity.full_parity_count, 0) as full_parity_count
from all_combinations
left join keyed_parity
    on  all_combinations.bst = keyed_parity.bst
    and all_combinations.sap = keyed_parity.sap
    and all_combinations.ad  = keyed_parity.ad
