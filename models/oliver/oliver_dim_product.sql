{{ config(
    materialized = 'table',
    schema = 'oliver_dw_source'
    )
}}


select
product_id as product_key,
product_id,
product_name,
description
FROM {{ source('oliver_landing', 'product') }}