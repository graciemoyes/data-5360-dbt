{{ config(
    materialized = 'table',
    schema = 'oliver_dw'
) }}

SELECT
    c.customer_key,
    d.date_key,
    s.store_key,
    p.product_key,
    e.employee_key,
    ol.Quantity,
    ol.Unit_Price,
    (ol.quantity) * (ol.unit_price) AS dollars_sold

FROM {{ source('oliver_landing', 'orderline') }} ol
INNER JOIN {{ source('oliver_landing', 'orders') }} o ON o.order_ID = ol.order_ID
INNER JOIN {{ ref('oliver_dim_customer') }} c ON o.Customer_ID = c.Customer_ID
INNER JOIN {{ ref('oliver_dim_employee') }} e ON e.employee_ID = o.employee_ID
INNER JOIN {{ ref('oliver_dim_store') }} s ON s.store_ID = o.store_ID
INNER JOIN {{ ref('oliver_dim_product') }} p ON ol.product_ID = p.product_ID
INNER JOIN {{ ref('oliver_dim_date') }} d ON d.date_key = o.order_date