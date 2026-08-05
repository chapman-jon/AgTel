-- Active AD fields with no field-level enterprise ID. Whatever is assigned
-- above them, they cannot be matched to another system on the field EID, so
-- field-EID-only parity counts each one as an AD-only field. Complement of
-- ad_keyed_fields.

with joined as (

    select * from {{ ref('ad_joined_fields') }}

)

select *
from joined
where field_enterprise_id is null
