-- The parity counts must sum to the full non_null_joined population; if they
-- don't, a triple was dropped or double-counted during aggregation.
with parity_total as (

    select sum(count) as total from {{ ref('non_null_parity') }}

),

joined_total as (

    select count(*) as total from {{ ref('non_null_joined') }}

)

select *
from parity_total
cross join joined_total
where parity_total.total <> joined_total.total
