with joined as (

    select * from {{ ref('ad_joined_fields') }}

)

select *
from joined
where field_enterprise_id is null
   or farm_enterprise_id is null
   or farmer_enterprise_id is null
