-- Active BST fields that carry a field-level enterprise ID, whether or not the
-- farm and grower above them are keyed. Field-EID-only parity matches on the
-- field EID alone, so a field with an unassigned EID higher up the hierarchy
-- is still matchable here (unlike bst_non_null_fields, which requires the full
-- triple). Complement of bst_unkeyed_fields.

with joined as (

    select * from {{ ref('bst_joined_fields') }}

)

select *
from joined
where field_enterprise_id is not null
