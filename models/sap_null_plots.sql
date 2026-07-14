with joined as (

    select * from {{ ref('sap_joined_plots') }}

)

select *
from joined
where plot_enterprise_id is null
   or farm_enterprise_id is null
   or partner_enterprise_id is null
