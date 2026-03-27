{{ config(
    materialized = 'table',
    schema = 'ecoessentials_dw'
    )
}}


select
product_id as product_key,
product_id,
product_type,
product_name
FROM {{ source('eco_transactional_src', 'product') }}