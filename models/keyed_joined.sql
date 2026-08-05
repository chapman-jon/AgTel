-- The universe of matchable field EIDs (unioned_field_eids) left-joined back
-- to each source's keyed model. For every field EID it records which of the
-- three systems contain it and, for each system that does, the farm and
-- farmer EIDs that system hangs the field under. The join key is the field
-- EID alone, so a source is flagged present whenever it has the field, even
-- if it ties the field to a different farm or farmer than the other systems —
-- that disagreement is what the parity flags then measure:
--
--   farm_in_parity:   the field EID is in at least two systems and every
--                     system containing it agrees on a non-null farm EID.
--   farmer_in_parity: the same agreement at the farmer level.
--   full_in_parity:   both of the above, i.e. the full farmer -> farm ->
--                     field hierarchy matches — the full-hierarchy parity
--                     definition used by field_parity.
--
-- Null is never a match, so a null farm or farmer EID in any containing
-- system breaks parity at that level; a field EID present in only one system
-- has no counterpart to be in parity with, so its flags are false. One row
-- per field EID; feeds the downstream field-EID parity (Venn) table.

with unioned as (

    select * from {{ ref('unioned_field_eids') }}

),

ad as (

    select
        field_enterprise_id     as field_eid,
        farm_enterprise_id      as farm_eid,
        farmer_enterprise_id    as farmer_eid
    from {{ ref('ad_keyed_fields') }}

),

bst as (

    select
        field_enterprise_id     as field_eid,
        farm_enterprise_id      as farm_eid,
        grower_enterprise_id    as farmer_eid
    from {{ ref('bst_keyed_fields') }}

),

sap as (

    select
        plot_enterprise_id      as field_eid,
        farm_enterprise_id      as farm_eid,
        partner_enterprise_id   as farmer_eid
    from {{ ref('sap_keyed_plots') }}

),

joined as (

    select
        unioned.field_eid,
        (ad.field_eid  is not null) as in_ad,
        (bst.field_eid is not null) as in_bst,
        (sap.field_eid is not null) as in_sap,
        ad.farm_eid                 as ad_farm_eid,
        bst.farm_eid                as bst_farm_eid,
        sap.farm_eid                as sap_farm_eid,
        ad.farmer_eid               as ad_farmer_eid,
        bst.farmer_eid              as bst_farmer_eid,
        sap.farmer_eid              as sap_farmer_eid

    from unioned
    left join ad
        on unioned.field_eid = ad.field_eid
    left join bst
        on unioned.field_eid = bst.field_eid
    left join sap
        on unioned.field_eid = sap.field_eid

),

flagged as (

    select
        *,

        cast(in_ad as int) + cast(in_bst as int) + cast(in_sap as int) >= 2
            and (not in_ad  or ad_farm_eid  is not null)
            and (not in_bst or bst_farm_eid is not null)
            and (not in_sap or sap_farm_eid is not null)
            and (not (in_ad  and in_bst) or ad_farm_eid  = bst_farm_eid)
            and (not (in_ad  and in_sap) or ad_farm_eid  = sap_farm_eid)
            and (not (in_bst and in_sap) or bst_farm_eid = sap_farm_eid)
            as farm_in_parity,

        cast(in_ad as int) + cast(in_bst as int) + cast(in_sap as int) >= 2
            and (not in_ad  or ad_farmer_eid  is not null)
            and (not in_bst or bst_farmer_eid is not null)
            and (not in_sap or sap_farmer_eid is not null)
            and (not (in_ad  and in_bst) or ad_farmer_eid  = bst_farmer_eid)
            and (not (in_ad  and in_sap) or ad_farmer_eid  = sap_farmer_eid)
            and (not (in_bst and in_sap) or bst_farmer_eid = sap_farmer_eid)
            as farmer_in_parity

    from joined

)

select
    *,
    (farm_in_parity and farmer_in_parity) as full_in_parity
from flagged
