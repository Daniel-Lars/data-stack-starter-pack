{% macro create_full_sample(table_name) %}

    {% do log("Yooooo running the full sample") %}
    {% set sql %}
    CREATE SCHEMA IF NOT EXISTS {{ target.schema }};
    DROP TABLE IF EXISTS webshop.{{ target.schema }}.{{table_name}};
    create table webshop.{{ target.schema }}.{{table_name}} as
    select *
    from foreign_raw.{{table_name}}
    {% endset %}
    {% do run_query(sql) %}

    {% do log("Executing SQL: " ~ sql, info=True) %}
    {% do log("Created full sample") %}

{% endmacro %}


{% macro get_graph_node() %}

    {% if execute %}
        {% for node in graph.sources.values() %}
            {% set table_name = node.name %}
            {% do log("Source: " ~ table_name, info=True) %}
            {% do log("Source: " ~ node, info=True) %}
            {% do log("sample_type: " ~ node.config.sample_type, info=True) %}
        {% endfor %}
    {% endif %}

{% endmacro %}
