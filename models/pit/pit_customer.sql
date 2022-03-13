
{{ config(enabled=True, materialized='pit_incremental') }}

{%- set yaml_metadata -%}
source_model: hub_customer
src_pk: CUSTOMER_HK
as_of_dates_table: AS_OF_DATE
satellites: 
  SAT_CUSTOMER_DETAILS:
    pk:
      PK: CUSTOMER_HK
    ldts:
      LDTS: LOAD_DATETIME
  SAT_CUSTOMER_LOGIN:
    pk:
      PK: CUSTOMER_HK
    ldts:
      LDTS: LOAD_DATETIME
stage_tables: 
  STG_CUSTOMER_DETAILS: LOAD_DATETIME
  STG_CUSTOMER_LOGIN: LOAD_DATETIME    
src_ldts: LOAD_DATETIME
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}
{% set src_pk = metadata_dict['src_pk'] %}
{% set as_of_dates_table = metadata_dict['as_of_dates_table'] %}
{% set satellites = metadata_dict['satellites'] %}
{% set stage_tables = metadata_dict['stage_tables'] %}
{% set src_ldts = metadata_dict['src_ldts'] %}

{{ dbtvault.pit(source_model=source_model, src_pk=src_pk,
                as_of_dates_table=as_of_dates_table,
                satellites=satellites,
                stage_tables=stage_tables,
                src_ldts=src_ldts) }}