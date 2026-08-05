-- Field-EID parity table: the Venn regions when parity is determined using
-- the field EIDs alone, built to show how the full-hierarchy aspect of the
-- parity definition impacts parity. Extends keyed_all_comb (the Venn regions
-- for matchable field EIDs, with every non-empty combination guaranteed
-- present) by folding in the unkeyed records from each source, mirroring how
-- field_parity folds in its null-EID records: a record with no field-level
-- EID cannot be matched to any other system, so it belongs exclusively to its
-- own source's single-source region (ad_unkeyed_fields -> AD-only,
-- bst_unkeyed_fields -> BST-only, sap_unkeyed_plots -> SAP-only). Scalar
-- subqueries in the select clause add these counts onto the corresponding
-- single-source regions; multi-source regions are unchanged. Alongside count,
-- farm_parity_count shows how many field-EID matches in each region also have
-- the farm level in parity, and full_parity_count how many have the full
-- farmer -> farm -> field hierarchy in parity (the definition used by
-- field_parity), so leadership can read off how much each additional
-- hierarchy requirement shrinks the overlap. In single-source regions the two
-- parity columns are null rather than 0: with no counterpart system the
-- hierarchy comparison does not apply, and a 0 would misread as a measured
-- result (contrast the BST/AD region, whose 0 is real — matches exist there
-- and none survive the farm requirement).

select
    bst,
    sap,
    ad,
    count
        + case when ad = 1 and bst = 0 and sap = 0
               then (select count(*) from {{ ref('ad_unkeyed_fields') }})
               else 0 end
        + case when bst = 1 and ad = 0 and sap = 0
               then (select count(*) from {{ ref('bst_unkeyed_fields') }})
               else 0 end
        + case when sap = 1 and ad = 0 and bst = 0
               then (select count(*) from {{ ref('sap_unkeyed_plots') }})
               else 0 end
        as count,
    case when bst + sap + ad = 1 then null else farm_parity_count end
        as farm_parity_count,
    case when bst + sap + ad = 1 then null else full_parity_count end
        as full_parity_count
from {{ ref('keyed_all_comb') }}
