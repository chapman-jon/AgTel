with fields as (

    select * from {{ ref('bst_current_fields') }}

)

select *
from fields
where stat_cd = 'A'
  and field_use_cd = 'PROD'
  and country in ('United States', 'Canada')
