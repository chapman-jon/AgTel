-- Every triple in non_null_joined originates from the union of the three
-- source non_null models, so at least one source flag must be true. A row with
-- all flags false would mean the left join silently failed to match its origin.
select *
from {{ ref('non_null_joined') }}
where not (in_ad or in_bst or in_sap)
