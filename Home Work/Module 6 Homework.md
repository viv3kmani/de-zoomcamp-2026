# Module 6 Homework

## Questions & Answers

### Question 1

> **Install Spark and PySpark**
>
> Install Spark, run PySpark, create a local Spark session, and execute `spark.version`.

**Answer:** `4.1.1`

---

### Question 2

> **Yellow November 2025**
>
> Read November 2025 Yellow taxi data into a Spark DataFrame.
> Repartition to 4 partitions and save to Parquet.
>
> What is the average size of the created `.parquet` files (MB)?
>
> Options: `6MB`, `25MB`, `75MB`, `100MB`

**Answer:** `25MB`

---

### Question 3

> **Count Records**
>
> How many taxi trips started on `2025-11-15`?
>
> Options: `62,610`, `102,340`, `162,604`, `225,768`

**Answer:** `162,604`

**Query:**

```python
df.createOrReplaceTempView("trips")

spark.sql("""
    SELECT COUNT(*) AS trip_count
    FROM trips
    WHERE DATE(tpep_pickup_datetime) = '2025-11-15'
""").show()
```

---

### Question 4

> **Longest Trip**
>
> What is the length of the longest trip in the dataset (in hours)?
>
> Options: `22.7`, `58.2`, `90.6`, `134.5`

**Answer:** `134.5`

---

### Question 5

> **User Interface**
>
> Spark's application dashboard runs on which local port?
>
> Options: `80`, `443`, `4040`, `8080`

**Answer:** `4040`

---

### Question 6

> **Least Frequent Pickup Location Zone**
>
> Load zone lookup data into a temporary Spark view:
>
> `wget https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv`
>
> Using zone lookup + Yellow November 2025 data, find the least frequent pickup zone.
>
> Options:
> `Governor's Island/Ellis Island/Liberty Island`
> `Arden Heights`
> `Rikers Island`
> `Jamaica Bay`

**Answer:** `Governor's Island/Ellis Island/Liberty Island and Arden Heights`

**Query:**

```python
df_final = df.join(spark_zones, df.PULocationID == spark_zones.locationid)

df_final.groupBy("zone").count().orderBy("count").show()
```