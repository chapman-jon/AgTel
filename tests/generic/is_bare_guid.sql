{% test is_bare_guid(model, column_name) %}

-- Fails if any non-null value is not a bare 36-character GUID — i.e. it still
-- carries wrapping such as BST's legacy braced format. Nulls are ignored.
-- Used to assert the *_clean_* layer fully unwraps enterprise IDs before any
-- cross-system matching (and, on sources with no known wrapping, that none
-- has crept in).
select {{ column_name }}
from {{ model }}
where {{ column_name }} is not null
  and (
    length({{ column_name }}) <> 36
    or position('{' in {{ column_name }}) > 0
    or position('}' in {{ column_name }}) > 0
  )

{% endtest %}
