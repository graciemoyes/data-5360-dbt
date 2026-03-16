{{ config(
    materialized = 'table',
    schema = 'oliver_dw'
    )
}}


select
store_id as store_key,
store_id,
store_name,
street,
city,
state
FROM {{ source('oliver_landing', 'store') }}