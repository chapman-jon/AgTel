with plots as (

    select * from {{ ref('ZAGT_PLOT') }}

)

select *
from plots
where ZZSTAT = '02'
  and coalesce(LOEVM, '') <> 'X'
  and LAND1 in ('US', 'CA')
