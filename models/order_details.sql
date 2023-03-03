-- Nesta etapa, o objetivo é criar duas colunas: total e discount
--      total = unit_price. * quantity 
--      discount = total - (unit_price * quantity) -- aqui o unit_price vem da tabela de produtos

select
od.order_id,
od.product_id,
od.unit_price,
od.quantity,
pr.product_name,
pr.supplier_id,
pr.category_id,
od.unit_price * od.quantity as total,
(pr.unit_price * od.quantity) - total as discount
from {{source('sources','order_details')}} od
left join {{source('sources','products')}} pr 
    on od.product_id = pr.product_id