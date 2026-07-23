-- Current version of each BST field. bst_fields is a type 2 table: when a
-- field's record is updated, the prior version is kept as another row with the
-- same field_id, so a field can appear multiple times. The current record is
-- the row with the greatest upd_dt; a null upd_dt means the record was never
-- updated, so it can only be current when it is the field's only row (nulls
-- sort last). bst_clean_fields guarantees (field_id, upd_dt) is unique, so the
-- pick is deterministic.
select *
from {{ ref('bst_clean_fields') }}
qualify row_number() over (
    partition by field_id
    order by upd_dt desc nulls last
) = 1
