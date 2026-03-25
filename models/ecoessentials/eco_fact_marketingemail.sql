{{ config(
    materialized='table',
    schema='ecoessentials_dw'
) }}

SELECT
    e.cust_key,
    e.campaign_key,
    d.date_key,
    e.email_key,
    e.event_key,
    t.time_key
FROM {{ ref('stg_marketing_emails') }} e

-- Join to customer dimension if needed
INNER JOIN {{ ref('eco_dim_customer') }} c
    ON e.cust_key = c.customer_id

-- Join to campaign dimension
INNER JOIN {{ ref('eco_dim_campaign') }} ca
    ON e.campaign_key = ca.campaign_id

-- Join to date dimension
INNER JOIN {{ ref('eco_dim_date') }} d
    ON e.event_date = d.date_day  -- adjust if your dim_date uses `date_key`

-- Join to time dimension
INNER JOIN {{ ref('eco_dim_time') }} t
    ON e.event_time = t.time_key