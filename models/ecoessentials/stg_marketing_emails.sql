{{ config(
    materialized='table',
    schema='ecoessentials_dw'
) }}

SELECT
    TRY_TO_NUMBER(NULLIF(CUSTOMERID, 'NULL')) AS cust_key,
    TRY_TO_NUMBER(NULLIF(CAMPAIGNID, 'NULL')) AS campaign_key,
    DATE(EVENTTIMESTAMP) AS event_date,
    TO_CHAR(EVENTTIMESTAMP, 'HH24MISS') AS event_time,
    TRY_TO_NUMBER(NULLIF(EMAILID, 'NULL')) AS email_key,
    EMAILEVENTID AS event_key,
    EVENTTIMESTAMP
FROM {{ source('eco_email_src', 'marketingemails') }}