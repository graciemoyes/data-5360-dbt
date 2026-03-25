{{ config(
    materialized = 'table',
    schema = 'ecoessentials_dw'
    )
}}


select
campaign_id as campaign_key,
campaign_id,
campaign_name,
campaign_discount
FROM {{ source('eco_transactional_src', 'promotional_campaign') }}