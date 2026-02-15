Question 1. dbt Lineage and Execution
Given a dbt project with the following structure:

models/
├── staging/
│   ├── stg_green_tripdata.sql
│   └── stg_yellow_tripdata.sql
└── intermediate/
    └── int_trips_unioned.sql (depends on stg_green_tripdata & stg_yellow_tripdata)
If you run dbt run --select int_trips_unioned, what models will be built?

stg_green_tripdata, stg_yellow_tripdata, and int_trips_unioned (upstream dependencies)

Answer: int_trips_unioned only


Question 2. dbt Tests
You've configured a generic test like this in your schema.yml:

columns:
  - name: payment_type
    data_tests:
      - accepted_values:
          arguments:
            values: [1, 2, 3, 4, 5]
            quote: false
Your model fct_trips has been running successfully for months. A new value 6 now appears in the source data.

What happens when you run dbt test --select fct_trips?


Answer :dbt will fail the test, returning a non-zero exit code

Question 3. Counting Records in fct_monthly_zone_revenue
After running your dbt project, query the fct_monthly_zone_revenue model.

What is the count of records in the fct_monthly_zone_revenue model?

Answer: 15,421


Question 4. Best Performing Zone for Green Taxis (2020)
Using the fct_monthly_zone_revenue table, find the pickup zone with the highest total revenue (revenue_monthly_total_amount) for Green taxi trips in 2020.

Which zone had the highest revenue?

Answer: East Harlem North


Question 5. Green Taxi Trip Counts (October 2019)
Using the fct_monthly_zone_revenue table, what is the total number of trips (total_monthly_trips) for Green taxis in October 2019?

Answer: 384,624

Create a staging model for the For-Hire Vehicle (FHV) trip data for 2019.

Question 6. Build a Staging Model for FHV Data
Create a staging model for the For-Hire Vehicle (FHV) trip data for 2019.

Load the FHV trip data for 2019 into your data warehouse
Create a staging model stg_fhv_tripdata with these requirements:
Filter out records where dispatching_base_num IS NULL
Rename fields to match your project's naming conventions (e.g., PUlocationID → pickup_location_id)
What is the count of records in stg_fhv_tripdata?


Answer: 43,244,693

with 

source as (

    select * from {{ source('raw', 'fhv_tripdata') }}

),

renamed as (

    select

        cast(dispatching_base_num as string) as dispatching_base_num
        cast(pickup_datetime as timestamp) as pickup_datetime
        cast(dropoff_datetime as timestamp) as dropoff_datetime
        cast(pulocationid as integer) as pickup_location_id
        cast(dolocationid as  integer) as dropoff_location_id
        cast(sr_flag as string) as store_and_fwd_flag
        cast(affiliated_base_number as string) as affiliated_base_number

    from source

)

select * from renamed



-- Sample records for dev environment using deterministic date filter
{% if target.name == 'dev' %}
where pickup_datetime >= '2019-01-01' and pickup_datetime < '2019-02-01'
{% endif %}



