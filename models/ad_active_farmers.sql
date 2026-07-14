with farmers as (

    select * from {{ ref('ad_farmers') }}

)

select *
from farmers
where is_test = false
  and status = 'active'
