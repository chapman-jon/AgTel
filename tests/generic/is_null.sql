{% test is_null(model, column_name) %}

-- Fails if any row has a non-null value in column_name.
select {{ column_name }}
from {{ model }}
where {{ column_name }} is not null

{% endtest %}
