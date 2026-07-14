with joined as (

    select * from {{ ref('ad_joined_fields') }}

)

select *
from joined
where field_enterprise_id is not null
  and farm_enterprise_id is not null
  and farmer_enterprise_id is not null
