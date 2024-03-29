{{
    config(
        materialized='table',
        post_hook=["commit;
            GRANT USAGE ON SCHEMA {{target.schema}} TO GROUP biuser;
            GRANT SELECT ON TABLE {{target.schema}}.bireport TO GROUP biuser;
        "]
    )

}}


select
*
from {{ref('joins')}}