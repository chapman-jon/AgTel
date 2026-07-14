with partners as (

    select * from {{ ref('ZAGT_PARTNER') }}

)

select *
from partners
where ZZSTAT = '02'
  and coalesce(LOEVM, '') <> 'X'
  and PARTNER_TYPE = 'C'
  and LAND1 in ('US', 'CA')
