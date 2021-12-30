WITH all_history AS (

SELECT 
	
	hc.customer_pk 
	, scd.first_name 
	, scd.last_name 
	, scd.email 
	, scd.effective_from 
	, COALESCE(lead(effective_from) OVER (PARTITION BY hc.customer_pk ORDER BY scd.effective_from), '9999-12-31') AS effective_to

FROM dbt.hub_customer hc 
	LEFT JOIN dbt.sat_customer_details scd ON scd.customer_pk = hc.customer_pk
	
WHERE hc.customer_pk IN ('ec8956637a99787bd197eacd77acce5e')	

)

SELECT 

	  customer_pk 
	, first_name 
	, last_name 
	, email 
--	, effective_from 
--	, effective_to
	
FROM all_history	
	
WHERE current_timestamp BETWEEN effective_from AND effective_to -- '2021-12-10 20:55:03'
	AND customer_pk IN ('ec8956637a99787bd197eacd77acce5e')

;

SELECT current_timestamp ;