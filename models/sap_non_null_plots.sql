with joined as (

    select * from {{ ref('sap_joined_plots') }}

)

select *
from joined
where plot_enterprise_id is not null
  and farm_enterprise_id is not null
  and partner_enterprise_id is not null
