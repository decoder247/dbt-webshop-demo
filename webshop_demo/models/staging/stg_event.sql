with source as (
    select * from {{ source('webshop', 'event') }}
)

select 
    id as event_id,
    created_at,
    modified_at,
    type,
    event
from source