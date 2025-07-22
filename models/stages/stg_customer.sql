{{ config(materialized='view') }}

{% if execute %}
    {% set var_ldts = "SYSDATE()" %}
{% endif %}

{%- set yaml_metadata -%}
source_model:
    'TPC-H_SF1': 'Customer'
ldts: {{ var_ldts }}
rsrc: '!TPC_H_SF1.Customer'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{{ datavault4dbt.stage(include_source_columns = metadata_dict.get('include_source_columns'),
                                    ldts = metadata_dict.get('ldts'),
                                    rsrc = metadata_dict.get('rsrc'),
                                    source_model = metadata_dict.get('source_model'),
                                    hashed_columns = metadata_dict.get('hashed_columns'),
                                    derived_columns = metadata_dict.get('derived_columns'),
                                    sequence = metadata_dict.get('sequence'),
                                    prejoined_columns = metadata_dict.get('prejoined_columns'),
                                    missing_columns = metadata_dict.get('missing_columns'),
                                    multi_active_config = metadata_dict.get('multi_active_config'),
                                    enable_ghost_records = metadata_dict.get('enable_ghost_records')) }}