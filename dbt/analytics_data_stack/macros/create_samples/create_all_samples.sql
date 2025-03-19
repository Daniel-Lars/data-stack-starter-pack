{% macro create_all_samples() %}

    {% if execute %}
        {% for node in graph.sources.values() %}
            {% set table_name = node.name %}
            {% set sample_type = node.config.sample_type %}
            {% do log("Source: " ~ node.name, info=True) %}
            {% do log("sample_type: " ~ node.config.sample_type, info=True) %}
            {% if sample_type == "full_sample" %} {{ create_full_sample(table_name) }} {% endif %}
        {% endfor %}
    {% endif %}

{% endmacro %}
