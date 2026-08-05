-- The three measures must nest in every multi-source region: a field can only
-- have its farm level in parity if it is counted in the region, and
-- full-hierarchy parity additionally requires the farm level, so
-- count >= farm_parity_count >= full_parity_count >= 0. Single-source regions
-- have no counterpart system, so the hierarchy comparison does not apply and
-- both parity counts must be null there — and only there.
select *
from {{ ref('field_eid_parity') }}
where (
        bst + sap + ad = 1
        and (farm_parity_count is not null or full_parity_count is not null)
      )
   or (
        bst + sap + ad > 1
        and (
            farm_parity_count is null
            or full_parity_count is null
            or farm_parity_count > count
            or full_parity_count > farm_parity_count
            or full_parity_count < 0
        )
      )
