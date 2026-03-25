{{ config(
    materialized = 'table',
    schema = 'ecoessentials_dw'
    )
}}


select
to_char(eventtimestamp, 'HH24MISS') as time_key,
extract(hour from eventtimestamp)   as hour,
extract(minute from eventtimestamp) as minute,
extract(second from eventtimestamp) as second
FROM {{ source('eco_email_src', 'marketingemails') }}