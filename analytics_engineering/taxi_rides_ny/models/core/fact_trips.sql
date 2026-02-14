{{
    config(
        materialized='table'
    )
}}

with green_tripsdata as (
    select *
    from 
    {{ ref('stg_taxidata__green_tripdata') }}
),

yellow_tripsdata as (
    select *
    from 
    {{ ref('stg_taxidata__yellow_tripdata') }}
),

trips_unioned as (
    select * from green_tripsdata
    union all
    select * from yellow_tripsdata
),
pickup_zones  as (
    select locationid as p_location_id, borough AS pickup_borough, zone AS pickup_zone, service_zone as pickup_service_zone from {{ ref('dim_zones') }}
    where borough <> 'unknown'
),

dropoff_zones  as (
    select locationid as d_location_id, borough as  dropoff_borough, zone as dropoff_zone, service_zone as dropoff_service_zone from {{ ref('dim_zones') }}
    where borough <> 'unknown'
)

select *
from trips_unioned
inner join pickup_zones
on trips_unioned.pickup_location_id = pickup_zones.p_location_id
inner join dropoff_zones
on trips_unioned.dropoff_location_id = dropoff_zones.d_location_id
