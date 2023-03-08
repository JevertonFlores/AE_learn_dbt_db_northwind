select
{{retorna_campo()}}
from {{ref('joins')}}
where category_name = '{{var('category')}}'