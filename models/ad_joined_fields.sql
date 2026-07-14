with fields as (

    select * from {{ ref('ad_active_fields') }}

),

farms as (

    select * from {{ ref('ad_active_farms') }}

),

farmers as (

    select * from {{ ref('ad_active_farmers') }}

)

select
    fields.field_id,
    fields.enterprise_id    as field_enterprise_id,
    farms.farm_id,
    farms.enterprise_id     as farm_enterprise_id,
    farmers.farmer_id,
    farmers.enterprise_id   as farmer_enterprise_id

from fields
inner join farms
    on fields.farm_id = farms.farm_id
inner join farmers
    on farms.farmer_id = farmers.farmer_id
