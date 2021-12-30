{{
    config(
        materialized='table'
    )
}}

SELECT

	  date_trunc('week', sod.order_date) AS order_week  
	, sod.status 
	, {{ dbt_utils.surrogate_key(["date_trunc('week', sod.order_date)", 'status']) }} as id
	, count(ho.order_pk)

FROM {{ ref('hub_order') }} AS ho
	LEFT JOIN {{ ref('sat_order_details') }} sod ON sod.order_pk = ho.order_pk 

GROUP BY 1, 2

ORDER BY order_week DESC 	
