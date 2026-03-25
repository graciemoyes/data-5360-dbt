{{ config(
    materialized = 'table',
    schema = 'ecoessentials_dw'
) }}

SELECT
    c.custkey,
    d.date_key,
    ca.campaign_key,
    p.product_key,
    o.order_id,
    ol.discount,
    ol.quantity,
    ps.price,
    (ol.quantity) * (ol.price_after_discount) AS sales_amount

FROM GRACIEMOYES.ECOESSENTIALS_TRANSACTIONAL_DB."ORDER" o
INNER JOIN {{ source('eco_transactional_src', 'order_line') }} ol ON o.order_id = ol.order_id
INNER JOIN {{ source('eco_transactional_src', 'product') }} ps ON ol.product_id = ps.product_id
INNER JOIN {{ ref('eco_dim_customer') }} c ON c.Customer_id = o.Customer_id
INNER JOIN {{ ref('eco_dim_date') }} d ON d.date_day = DATE(o.order_timestamp)
INNER JOIN {{ ref('eco_dim_campaign') }} ca ON ca.campaign_id = ol.campaign_id
INNER JOIN {{ ref('eco_dim_products') }} p ON p.product_id = ol.product_id