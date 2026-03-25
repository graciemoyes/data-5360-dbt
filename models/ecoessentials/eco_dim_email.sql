{{ config(
    materialized = 'table',
    schema = 'ecoessentials_dw'
    )
}}


select
emailid as email_key,
emailid,
emailname,
FROM {{ source('eco_email_src', 'marketingemails') }}
