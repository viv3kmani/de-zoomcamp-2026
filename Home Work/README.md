# Data Engineering Zoomcamp - Week 1 Homework

## Question 1: Understanding Docker Images

**Answer:** `25.3`

Understanding Docker image sizes and layers.

---

## Question 2: Understanding Docker Networking and docker-compose

**Answer:** `postgres:5432`

**Explanation:**  
In docker-compose, containers communicate using the service name as hostname and the internal container port (not the host-mapped port).

For the postgres service:
- **Hostname:** `postgres` (service/container name) or `db` (service name)
- **Port:** `5432` (internal container port, not the host port 5433)

---

## Question 3: Counting Short Trips

**Answer:** `8007`

**Query:**
```sql
SELECT COUNT(*) 
FROM public."green_tripdata_2025-11"
WHERE CAST(lpep_pickup_datetime AS DATE) >= '2025-11-01' 
  AND CAST(lpep_pickup_datetime AS DATE) < '2025-12-01'
  AND trip_distance <= 1
```

Count all trips in November 2025 with distance ≤ 1 mile.

---

## Question 4: Longest Trip for Each Day

**Answer:** `2025-11-14`

**Query:**
```sql
SELECT CAST(lpep_pickup_datetime AS DATE) as trip_date, *
FROM public."green_tripdata_2025-11"
WHERE lpep_pickup_datetime >= '2025-11-01' 
  AND lpep_pickup_datetime < '2025-12-01'
  AND trip_distance < 100
ORDER BY trip_distance DESC
LIMIT 1;
```

Identifies the date with the longest trip distance in November 2025 (excluding outliers > 100 miles).

---

## Question 5: Biggest Pickup Zone

**Question:** Which was the pickup zone with the largest total_amount (sum of all trips) on November 18th, 2025?

**Answer:** `East Harlem North`

**Query:**
```sql
SELECT t2."Zone", SUM(t1.fare_amount) as trip_amount 
FROM public."green_tripdata_2025-11" as t1
LEFT JOIN public.zones as t2 
  ON t1."PULocationID" = t2."LocationID"
WHERE t1.lpep_pickup_datetime >= '2025-11-18' 
  AND t1.lpep_pickup_datetime < '2025-11-19'
GROUP BY 1 
ORDER BY 2 DESC;
```

Aggregates total fare amount by pickup zone for trips on November 18th, 2025.

---

## Question 6: Largest Tip

**Question:** For passengers picked up in "East Harlem North" in November 2025, which drop-off zone had the largest tip?

**Answer:** `Yorkville West`

**Query:**
```sql
SELECT t3."Zone" as "DropZone",
       MAX(t1."tip_amount") as max_tip
FROM public."green_tripdata_2025-11" as t1
INNER JOIN public.zones as t2  
  ON t1."PULocationID" = t2."LocationID"
LEFT JOIN public.zones as t3
  ON t1."DOLocationID" = t3."LocationID"
WHERE t2."Zone" = 'East Harlem North'
  AND t1.lpep_pickup_datetime >= '2025-11-01' 
  AND t1.lpep_pickup_datetime < '2025-12-01'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
```

**Note:** It's tip, not trip. Returns the zone name, not the ID.

---

## Question 7: Terraform Workflow

**Answer:** `terraform init, terraform apply -auto-approve, terraform destroy`

**Explanation:**
- `terraform init` - Initialize Terraform working directory and download providers
- `terraform apply -auto-approve` - Apply configuration and create resources without manual approval
- `terraform destroy` - Destroy all resources managed by Terraform

---

## Technologies Used

- **Docker & Docker Compose** - Container orchestration
- **PostgreSQL** - Database for NYC taxi data
- **pgAdmin** - Database management interface
- **SQL** - Data analysis and querying
- **Terraform** - Infrastructure as Code for GCP resources
- **GCP** - Cloud platform (BigQuery, Cloud Storage)

---

## Project Structure

```
de-docker/
├── pipeline/
│   ├── docker-compose.yml
│   ├── Dockerfile
│   ├── ingest_data.py
│   └── taxi_zone_lookup.csv
└── Home Work/
    ├── Week 1
    └── README.md
```

---

## Setup Instructions

1. **Start Docker containers:**
   ```bash
   cd de-docker/pipeline
   docker-compose up -d
   ```

2. **Access pgAdmin:**
   - URL: http://localhost:8080
   - Email: pgadmin@pgadmin.com
   - Password: pgadmin

3. **Connect to PostgreSQL in pgAdmin:**
   - Host: `db` or `postgres`
   - Port: `5432`
   - Database: `ny_taxi`
   - Username: `postgres`
   - Password: `postgres`

4. **Tear down:**
   ```bash
   docker-compose down
   ```

---

## Key Learnings

✅ Docker networking and inter-container communication  
✅ SQL joins, aggregations, and window functions  
✅ PostgreSQL date handling and type casting  
✅ Terraform infrastructure provisioning  
✅ GCP service account configuration  

---

**Data Engineering Zoomcamp - Week 1 Complete!** 🚀
