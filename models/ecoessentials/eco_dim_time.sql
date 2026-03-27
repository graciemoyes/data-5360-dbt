{{ config(
    materialized = 'table',
    schema = 'ecoessentials_dw'
) }}

WITH time_data AS (
    SELECT DISTINCT
        eventtimestamp
    FROM {{ source('eco_email_src', 'marketingemails') }}
    WHERE eventtimestamp IS NOT NULL
)

SELECT
    TO_CHAR(eventtimestamp, 'HH24MISS')      AS time_key,
    DATE_PART(hour, eventtimestamp)          AS hour,
    DATE_PART(minute, eventtimestamp)        AS minute,
    DATE_PART(second, eventtimestamp)        AS second,
    TO_CHAR(eventtimestamp, 'HH24:MI:SS')    AS time_string
FROM time_data