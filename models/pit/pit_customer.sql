with all_history as (
  select
    hc.customer_pk,
    scd.first_name,
    scd.last_name,
    scd.email,
    scdc.age,
    scdc.country,
    scd.effective_from as scd_effective_from,
    coalesce (lead(scd.effective_from) over (partition by hc.customer_pk order by scd.effective_from), '9999-12-31') as scd_effective_to,
    scdc.effective_from as scdc_effective_from,
    coalesce (lead(scdc.effective_from) over (partition by hc.customer_pk order by scdc.effective_from), '9999-12-31') as scdc_effective_to
  from dbt.hub_customer hc
    left join dbt.sat_customer_details scd on scd.customer_pk = hc.customer_pk
    left join dbt.sat_customer_details_crm scdc on scdc.customer_pk = hc.customer_pk
  where hc.customer_pk in ('6974ce5ac660610b44d9b9fed0ff9548')
)

select
  customer_pk,
  first_name,
  last_name,
  email,
  age,
  country
  --effective_from,
  --effective_to
from all_history
where 1=1
  and current_timestamp between scd_effective_from and scd_effective_to
  and current_timestamp between scdc_effective_from and scdc_effective_to
  and customer_pk in ('6974ce5ac660610b44d9b9fed0ff9548');

select current_timestamp;

--'2022-03-28 21:44:05'