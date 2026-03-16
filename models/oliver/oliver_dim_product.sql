{{ config(
    materialized = 'table',
    schema = 'oliver_dw'
    )
}}


select
product_id as product_key,
product_id,
product_name,
description
FROM {{ source('oliver_landing', 'product') }}