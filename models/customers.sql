-- Aprimeira tarefa do projeto é levar a tabela de customers, porém sem que os registros estejam duplicados.
    -- Regra: é considerado um cliente duplicado quando há o mesmo 'company_name' e 'contact_name'.

/* - Primeira etapa: Iremos utilizar uma CTE para dividir essa tarefa em 3 etapas.
        Na primeira etapa, utilizaremos uma 'window function' para criar uma nova coluna e 
        esta nova coluna irá repetir o id do cliente, quando o cliente estiver duplicado, conforme a regra de negócio.

    - Segunda etapa: Iremos fazer um 'distinct' desta nova coluna que foi criada, assim poderemos sacar os cliente duplicados.

    - Na última fase da CTE, faremos um SELECT na tabela de origem, verificando onde o id do cliente estiver na tabela com o distinct. */

with markup as (
select *,
first_value(customer_id)
over(partition by company_name, contact_name 
order by company_name
rows between unbounded preceding and unbounded following) as result
from {{source('sources', 'customers')}}
),
removed as (
    select distinct result 
    from markup
),
final as (
    select *
    from {{source('sources', 'customers')}}
    where customer_id in (
                            select result from removed
                            )
    )

select * from final