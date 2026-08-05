-- A field EID has its full hierarchy in parity across all three systems
-- exactly when the same (farmer, farm, field) EID triple exists in all three
-- sources (each source maps a field EID to at most one hierarchy), so the
-- full_parity_count in the center region of field_eid_parity must equal the
-- center count of field_parity. If they diverge, the two tables disagree
-- about what full-hierarchy parity means.
with field_eid_center as (

    select full_parity_count as total
    from {{ ref('field_eid_parity') }}
    where bst = 1 and sap = 1 and ad = 1

),

field_parity_center as (

    select count as total
    from {{ ref('field_parity') }}
    where bst = 1 and sap = 1 and ad = 1

)

select *
from field_eid_center
cross join field_parity_center
where field_eid_center.total <> field_parity_center.total
