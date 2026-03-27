{{ config(
    materialized = 'table',
    schema = 'ecoessentials_dw'
) }}

SELECT
    t.time_key,
    d.date_key,
    cu.custkey,
    c.campaign_key,
    e.event_key,
    em.email_key

FROM {{ source ('eco_email_src', 'marketingemails') }} me

JOIN {{ ref('eco_dim_date') }} d
    ON d.date_day = CAST(me.eventtimestamp AS DATE)

JOIN {{ ref('eco_dim_time') }} t
    ON t.time_key = TO_CHAR(me.eventtimestamp, 'HH24MISS')

-- could be duplicates, but there are missing customerids in the source table
JOIN {{ ref('eco_dim_customer') }} cu
    ON cu.customer_first_name = me.subscriberfirstname
    AND cu.customer_last_name = me.subscriberlastname
    AND cu.customer_email = me.subscriberemail

JOIN {{ ref('eco_dim_campaign') }} c
    ON c.campaign_id = me.campaignid

JOIN {{ ref('eco_dim_event') }} e
    ON e.emaileventid = me.emaileventid

JOIN {{ ref('eco_dim_email') }} em
    ON em.emailid = me.emailid