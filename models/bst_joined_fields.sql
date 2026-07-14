with fields as (

    select * from {{ ref('bst_active_fields') }}

),

farms as (

    select * from {{ ref('bst_active_farms') }}

),

growers as (

    select * from {{ ref('bst_active_growers') }}

)

select
    fields.field_id,
    fields.entrpr_guid     as field_enterprise_id,
    farms.farm_id,
    farms.entrpr_guid      as farm_enterprise_id,
    growers.grower_id,
    growers.entrpr_guid    as grower_enterprise_id

from fields
inner join farms
    on fields.farm_id = farms.farm_id
inner join growers
    on farms.grower_id = growers.grower_id
