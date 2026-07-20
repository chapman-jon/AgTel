with joined as (

    select * from {{ ref('sap_joined_plots') }}

)

-- SAP re-keys plots: the same physical field can be re-surveyed and re-entered
-- under a new PLOT_ID while keeping the same (plot, farm, partner) EID triple, so
-- both rows are in scope and active. A field must be counted once, so we collapse
-- rows sharing the full EID triple to a single representative (lowest PLOT_ID).
-- De-duplicating here — after scoping and the hierarchy join — means it runs over
-- the in-scope population on the true match key (the whole triple); plots with an
-- unassigned EID can't be matched or collapsed and stay individual in
-- sap_null_plots.
select *
from joined
where plot_enterprise_id is not null
  and farm_enterprise_id is not null
  and partner_enterprise_id is not null
qualify row_number() over (
    partition by plot_enterprise_id, farm_enterprise_id, partner_enterprise_id
    order by plot_id
) = 1
