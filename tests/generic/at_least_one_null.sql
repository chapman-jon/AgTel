{% test at_least_one_null(model, columns) %}

-- Fails for any row in which every listed column is non-null, i.e. the row
-- has no null among `columns`. Used to assert that each row carries at least
-- one null enterprise ID.
select *
from {{ model }}
where
{%- for column in columns %}
    {{ column }} is not null{% if not loop.last %} and{% endif %}
{%- endfor %}

{% endtest %}
