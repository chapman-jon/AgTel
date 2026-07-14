-- Enterprise IDs (EIDs) for every fully-matched field hierarchy across all
-- three sources, stacked into a common (farmer, farm, field) shape and
-- de-duplicated. The top level is farmer (AD) / grower (BST) / partner (SAP)
-- and the leaf is field (AD, BST) / plot (SAP); all three map to the same
-- real-world entities via their shared EIDs. UNION removes rows that are
-- identical across sources (the cross-system overlap), so there are no
-- duplicates.

with ad as (

    select
        farmer_enterprise_id    as farmer_eid,
        farm_enterprise_id      as farm_eid,
        field_enterprise_id     as field_eid
    from {{ ref('ad_non_null_fields') }}

),

bst as (

    select
        grower_enterprise_id    as farmer_eid,
        farm_enterprise_id      as farm_eid,
        field_enterprise_id     as field_eid
    from {{ ref('bst_non_null_fields') }}

),

sap as (

    select
        partner_enterprise_id   as farmer_eid,
        farm_enterprise_id      as farm_eid,
        plot_enterprise_id      as field_eid
    from {{ ref('sap_non_null_plots') }}

)

select farmer_eid, farm_eid, field_eid from ad
union
select farmer_eid, farm_eid, field_eid from bst
union
select farmer_eid, farm_eid, field_eid from sap
