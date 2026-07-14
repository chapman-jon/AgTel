{% test unique_combination(model, columns) %}

-- Fails if the combination of `columns` is not unique, i.e. any duplicate row
-- exists over the listed columns.
select
{%- for column in columns %}
    {{ column }}{% if not loop.last %},{% endif %}
{%- endfor %}
from {{ model }}
group by
{%- for column in columns %}
    {{ column }}{% if not loop.last %},{% endif %}
{%- endfor %}
having count(*) > 1

{% endtest %}
