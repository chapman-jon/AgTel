with farms as (

    select * from {{ ref('bst_farms') }}

)

select *
from farms
where stat_cd = 'A'
  and country in ('United States', 'Canada')
