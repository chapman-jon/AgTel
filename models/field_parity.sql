-- Field-parity table. Extends all_comb (the Venn regions for fully matched EID
-- triples, with every non-empty combination guaranteed present) by folding in
-- the null-EID records from each source. A record with a null enterprise ID
-- cannot be matched to any other system, so it belongs exclusively to its own
-- source's single-source region: ad_null_fields -> AD-only, bst_null_fields ->
-- BST-only, sap_null_plots -> SAP-only. Scalar subqueries in the select clause
-- add these counts onto the corresponding single-source regions; multi-source
-- regions are unchanged. all_comb guarantees each single-source region exists,
-- so the null counts always have a row to attach to.

select
    bst,
    sap,
    ad,
    count
        + case when ad = 1 and bst = 0 and sap = 0
               then (select count(*) from {{ ref('ad_null_fields') }})
               else 0 end
        + case when bst = 1 and ad = 0 and sap = 0
               then (select count(*) from {{ ref('bst_null_fields') }})
               else 0 end
        + case when sap = 1 and ad = 0 and bst = 0
               then (select count(*) from {{ ref('sap_null_plots') }})
               else 0 end
        as count
from {{ ref('all_comb') }}
