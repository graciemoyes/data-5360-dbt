{{ config(
    materialized = 'table',
    schema = 'ecoessentials_dw'
    )
}}


select
emaileventid as event_key,
emaileventid,
eventtype,
FROM {{ source('eco_email_src', 'marketingemails') }}