# Module 2 Homework

## Kestra Flow

This workflow orchestrates the downloading of NYC Taxi data for multiple years, months, and taxi types using nested `ForEach` loops and subflows.

```yaml
id: recursive_data_load
namespace: zoomcamp

tasks:
  - id: download_years
    type: io.kestra.plugin.core.flow.ForEach
    values: ["2020", "2021"]
    tasks:
      
      - id: download_months
        type: io.kestra.plugin.core.flow.ForEach
        values: ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
        tasks:

          - id: taxis
            type: io.kestra.plugin.core.flow.ForEach
            values: ["yellow", "green"]
            tasks:
              - id: call_taxi_flow
                type: io.kestra.plugin.core.flow.Subflow
                namespace: zoomcamp
                flowId: 08_gcp_taxi
                inputs:
                  taxi: "{{taskrun.value}}"
                  year: "{{parents[1].taskrun.value}}"
                  month: "{{parents[0].taskrun.value}}"
                wait: true
                transmitFailed: true
```

---

## Questions & Answers

### Question 1

> Within the execution for Yellow Taxi data for the year 2020 and month 12: what is the uncompressed file size (i.e. the output file `yellow_tripdata_2020-12.csv` of the extract task)?

**Answer:** `128.3 MiB`

---

### Question 2

> What is the rendered value of the variable `file` when the inputs taxi is set to `green`, year is set to `2020`, and month is set to `04` during execution?

**Answer:** `green_tripdata_2020-04.csv`

---

### Question 3

> How many rows are there for the Yellow Taxi data for all CSV files in the year 2020?

**Answer:** `24,648,499`

---

### Question 4

> How many rows are there for the Green Taxi data for all CSV files in the year 2020?

**Answer:** `1,734,051`

---

### Question 5

> How many rows are there for the Yellow Taxi data for the March 2021 CSV file?

**Answer:** `1,925,152`

---

### Question 6

> How would you configure the timezone to New York in a Schedule trigger?

**Answer:** Add a `timezone` property set to `America/New_York` in the Schedule trigger configuration.

```yaml
triggers:
  - id: schedule
    type: io.kestra.plugin.core.trigger.Schedule
    cron: "0 9 * * *"
    timezone: America/New_York
```
