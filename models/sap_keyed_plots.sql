-- Active SAP plots that carry a plot-level enterprise ID, de-duplicated to one
-- row per plot EID. SAP re-keys plots (the same physical field re-surveyed and
-- re-entered under a new PLOT_ID), so rows sharing a plot EID collapse to a
-- single representative (lowest PLOT_ID) and each field is counted once — the
-- same convention as sap_non_null_plots, but at the plot-EID grain rather than
-- the full-triple grain because field-EID-only parity matches on the plot EID
-- alone. Complement of sap_unkeyed_plots.

with joined as (

    select * from {{ ref('sap_joined_plots') }}

)

select *
from joined
where plot_enterprise_id is not null
qualify row_number() over (
    partition by plot_enterprise_id
    order by plot_id
) = 1
