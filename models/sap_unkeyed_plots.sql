-- Active SAP plots with no plot-level enterprise ID. Whatever is assigned
-- above them, they cannot be matched to another system on the plot EID, so
-- field-EID-only parity counts each one as a SAP-only field. A plot with an
-- unassigned EID can't be matched or collapsed, so re-key de-duplication does
-- not apply and every row stays individual (as in sap_null_plots). Complement
-- of sap_keyed_plots.

with joined as (

    select * from {{ ref('sap_joined_plots') }}

)

select *
from joined
where plot_enterprise_id is null
