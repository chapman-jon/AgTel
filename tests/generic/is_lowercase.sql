{% test is_lowercase(model, column_name) %}

-- Fails if any row has a value that is not already lowercase (i.e. differs from
-- its lowercased form). Nulls are ignored. Used to assert the *_clean_* layer
-- case-folds enterprise IDs so cross-system matching is case-insensitive.
select {{ column_name }}
from {{ model }}
where {{ column_name }} <> lower({{ column_name }})

{% endtest %}
