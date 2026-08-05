-- Field-level enterprise IDs from every source that carries one, stacked into
-- a single column and de-duplicated: the universe of matchable field EIDs for
-- field-EID-only parity. The leaf level is field (AD, BST) / plot (SAP); all
-- three map to the same real-world entities via their shared EIDs. UNION
-- removes IDs that are identical across sources (the cross-system overlap),
-- so each field EID appears once.

with ad as (

    select field_enterprise_id as field_eid
    from {{ ref('ad_keyed_fields') }}

),

bst as (

    select field_enterprise_id as field_eid
    from {{ ref('bst_keyed_fields') }}

),

sap as (

    select plot_enterprise_id as field_eid
    from {{ ref('sap_keyed_plots') }}

)

select field_eid from ad
union
select field_eid from bst
union
select field_eid from sap
