-- all_comb must contain exactly the 7 non-empty (bst, sap, ad) combinations.
-- Fewer means a region is missing; more means a duplicate or the all-zero row
-- leaked in.
select count(*) as n
from {{ ref('all_comb') }}
having count(*) <> 7
