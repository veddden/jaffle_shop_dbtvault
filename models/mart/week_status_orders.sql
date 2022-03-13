with orders as (
    select * from {{ref('sat_order_details')}}
),

result as (
    select
        date_trunc('week', order_date) as order_week,
        status,
        count(order_pk)
    from orders
    group by order_week, status
    order by order_week desc, status

)

select * from result
