-- The universe of fully-matched field-hierarchy EIDs (unioned_eids) left-joined
-- back to each source's non_null model. For every distinct (farmer, farm, field)
-- EID triple it records which of the three systems contains that exact triple.
-- The join key is the full triple, so a source is only flagged present when it
-- ties the same field to the same farm and farmer. One row per distinct triple;
-- feeds the downstream field-parity (Venn) table.

with unioned as (

    select * from {{ ref('unioned_eids') }}

),

ad as (

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

select
    unioned.farmer_eid,
    unioned.farm_eid,
    unioned.field_eid,
    (ad.field_eid  is not null) as in_ad,
    (bst.field_eid is not null) as in_bst,
    (sap.field_eid is not null) as in_sap

from unioned
left join ad
    on  unioned.farmer_eid = ad.farmer_eid
    and unioned.farm_eid   = ad.farm_eid
    and unioned.field_eid  = ad.field_eid
left join bst
    on  unioned.farmer_eid = bst.farmer_eid
    and unioned.farm_eid   = bst.farm_eid
    and unioned.field_eid  = bst.field_eid
left join sap
    on  unioned.farmer_eid = sap.farmer_eid
    and unioned.farm_eid   = sap.farm_eid
    and unioned.field_eid  = sap.field_eid
