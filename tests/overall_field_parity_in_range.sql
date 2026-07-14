-- Overall field parity is a ratio, so it must fall within [0, 1].
select *
from {{ ref('overall_field_parity') }}
where overall_field_parity < 0
   or overall_field_parity > 1
