{{ config(
    materialized = 'table',
    schema = 'oliver_dw'
)}}

select
    d.date_key,
    e.employee_key,
    c.certification_name,
    c.certification_cost
from {{ ref('stg_employee_certifications') }} c
inner join {{ ref('oliver_dim_employee') }} e
    on c.first_name = e.first_name
    and c.last_name = e.last_name
inner join {{ ref('oliver_dim_date') }} d
    on d.date_key = c.certification_awarded_date
