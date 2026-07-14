-- non_null_parity guaranteed to carry every non-empty membership combination.
-- A region with no fully-matched triples is absent from non_null_parity; this
-- model backfills those combinations with a count of 0 so all 2^3 - 1 = 7
-- non-empty (bst, sap, ad) combinations are always present. The all-zero
-- combination is intentionally excluded. Downstream of non_null_parity and
-- upstream of field_parity.

with all_combinations as (

    select b.flag as bst, s.flag as sap, a.flag as ad
    from (values (0), (1)) as b(flag)
    cross join (values (0), (1)) as s(flag)
    cross join (values (0), (1)) as a(flag)
    where not (b.flag = 0 and s.flag = 0 and a.flag = 0)

),

non_null_parity as (

    select * from {{ ref('non_null_parity') }}

)

select
    all_combinations.bst,
    all_combinations.sap,
    all_combinations.ad,
    coalesce(non_null_parity.count, 0) as count
from all_combinations
left join non_null_parity
    on  all_combinations.bst = non_null_parity.bst
    and all_combinations.sap = non_null_parity.sap
    and all_combinations.ad  = non_null_parity.ad
