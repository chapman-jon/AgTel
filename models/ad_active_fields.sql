with fields as (

    select * from {{ ref('ad_fields') }}

)

select *
from fields
where is_test = false
  and status = 'active'
