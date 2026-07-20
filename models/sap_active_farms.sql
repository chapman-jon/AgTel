with farms as (

    select * from {{ ref('sap_clean_farms') }}

)

select *
from farms
where ZZSTAT = '02'
  and coalesce(LOEVM, '') <> 'X'
  and LAND1 in ('US', 'CA')
