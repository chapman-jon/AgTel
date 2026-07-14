with joined as (

    select * from {{ ref('bst_joined_fields') }}

)

select *
from joined
where field_enterprise_id is null
   or farm_enterprise_id is null
   or grower_enterprise_id is null
