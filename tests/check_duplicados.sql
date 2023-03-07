select
count(*) as contagem,
company_name,
contact_name
from {{ref('customers')}}
group by company_name, contact_name
having contagem > 1