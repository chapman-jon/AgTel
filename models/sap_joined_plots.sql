with plots as (

    select * from {{ ref('sap_active_plots') }}

),

farms as (

    select * from {{ ref('sap_active_farms') }}

),

partners as (

    select * from {{ ref('sap_active_partners') }}

)

select
    plots.PLOT_ID           as plot_id,
    plots.ZZEID             as plot_enterprise_id,
    farms.FARM_ID           as farm_id,
    farms.ZZEID             as farm_enterprise_id,
    partners.PARTNER_ID     as partner_id,
    partners.ZZEID          as partner_enterprise_id

from plots
inner join farms
    on plots.FARM_ID = farms.FARM_ID
inner join partners
    on farms.PARTNER_ID = partners.PARTNER_ID
