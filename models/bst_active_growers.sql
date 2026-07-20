with growers as (

    select * from {{ ref('bst_clean_growers') }}

)

select *
from growers
where stat_cd = 'A'
  and country in ('United States', 'Canada')
