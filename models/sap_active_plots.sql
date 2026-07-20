with plots as (

    select * from {{ ref('sap_clean_plots') }}

)

select *
from plots
where ZZSTAT = '02'
  and coalesce(LOEVM, '') <> 'X'
  and LAND1 in ('US', 'CA')
