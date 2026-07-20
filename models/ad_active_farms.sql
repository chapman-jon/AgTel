with farms as (

    select * from {{ ref('ad_clean_farms') }}

)

select *
from farms
where is_test = false
  and status = 'active'
