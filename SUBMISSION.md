# Technical Exercise Submission

**Candidate Name:** José Celso Becca Júnior

**Submission Date:** 2025-12-26

**GitHub Repository:** https://github.com/BeccaJr/te_20251217_jbecca

---

> **⚠️ IMPORTANT: This file must be edited using a text editor (e.g., VS Code, Sublime Text, vim, nano, etc.). Add your answers to this file and commit it to the repository.**

---

## Instructions for Completing This File

**Important:** For all result tables, follow the specified ordering exactly as indicated.

- Copy results directly from your query outputs. TIP: Use [this tool](https://www.tablesgenerator.com/markdown_tables) to generate the tables in Markdown format.
- Preserve exact column names and order
- For percentage columns, indicate whether values are 0-1 or 0-100 scale

---

## Part 1: Analytical SQL Exercise

### SQL Question 1

**Question:** Write a query that computes for each MSA, the unique scooter count, and unique scooter count as a % of all scooters, displaying only the top 3 MSAs (by scooter count) for the month of January 2020.

**Query:**
```sql
WITH
BASE AS (
    SELECT 
        M.MSA
        , COUNT(DISTINCT(S.DECODED_ID)) AS UNIQUE_SCOOTER_COUNT
    FROM 
        TE_ANALYTICS.BI.SCOOTERS_PARSED S
    INNER JOIN 
        TE_ANALYTICS.BI.US_HEX7_MSA M
    ON
        S.HEX7 = M.HEX7
    WHERE
        DATE(EXTRACTED_AT) BETWEEN '2020-01-01' AND '2020-01-31'
    GROUP BY
        M.MSA
)
SELECT
    MSA
    , UNIQUE_SCOOTER_COUNT
    , SUM(UNIQUE_SCOOTER_COUNT) OVER() AS TOTAL_SCOOTER_COUNT
    , UNIQUE_SCOOTER_COUNT / SUM(UNIQUE_SCOOTER_COUNT) OVER() AS UNIQUE_SCOOTER_PERC
    , RANK() OVER(ORDER BY UNIQUE_SCOOTER_COUNT DESC) AS RANK
FROM
    BASE
QUALIFY
    RANK <= 3
ORDER BY
    RANK
```

**Results (Top 3 MSAs, ordered by RANK ASC):**

| MSA                                          | UNIQUE_SCOOTER_COUNT | TOTAL_SCOOTER_COUNT | UNIQUE_SCOOTER_PERC | RANK |
|----------------------------------------------|----------------------|---------------------|---------------------|------|
| Austin-Round Rock-Georgetown, TX             | 7688                 | 41362               | 0.185871            | 1    |
| Washington-Arlington-Alexandria, DC-VA-MD-WV | 7255                 | 41362               | 0.175403            | 2    |
| Atlanta-Sandy Springs-Alpharetta, GA         | 7099                 | 41362               | 0.171631            | 3    |

*Note: TOTAL_SCOOTER_COUNT represents the total unique scooters across all MSAs for the time period*

**Notes (optional):**
*UNIQUE_SCOOTER_PERC is expressed on a 0–1 scale and represents the share of unique scooters in each MSA relative to the total unique scooters observed during January 2020.*

---

### SQL Question 2

**Question:** Write a query that computes the overall rank of MSAs based on the number of unique scooters for March 3rd, 2020. The MSA with the most scooters will have rank = 1.

**Query:**
```sql
WITH
BASE AS (
    SELECT 
        M.MSA
        , COUNT(DISTINCT(S.DECODED_ID)) AS UNIQUE_SCOOTER_COUNT
    FROM 
        TE_ANALYTICS.BI.SCOOTERS_PARSED S
    INNER JOIN 
        TE_ANALYTICS.BI.US_HEX7_MSA M
    ON
        S.HEX7 = M.HEX7
    WHERE
        DATE(EXTRACTED_AT) = '2020-03-03'
    GROUP BY
        M.MSA
)
SELECT
    UNIQUE_SCOOTER_COUNT
    , MSA
    , RANK() OVER(ORDER BY UNIQUE_SCOOTER_COUNT DESC) AS RANK
FROM
    BASE
ORDER BY
    RANK
```

**Results (All MSAs, ordered by MSA_RANK ASC):**

| UNIQUE_SCOOTER_COUNT | MSA                                            | RANK |
|----------------------|------------------------------------------------|------|
| 3545                 | Austin-Round Rock-Georgetown, TX               | 1    |
| 3432                 | Miami-Fort Lauderdale-Pompano Beach, FL        | 2    |
| 2595                 | San Francisco-Oakland-Berkeley, CA             | 3    |
| 2371                 | Washington-Arlington-Alexandria, DC-VA-MD-WV   | 4    |
| 2088                 | Atlanta-Sandy Springs-Alpharetta, GA           | 5    |
| 1433                 | Dallas-Fort Worth-Arlington, TX                | 6    |
| 1233                 | New York-Newark-Jersey City, NY-NJ-PA          | 7    |
| 982                  | Sacramento-Roseville-Folsom, CA                | 8    |
| 963                  | Tampa-St. Petersburg-Clearwater, FL            | 9    |
| 722                  | Baltimore-Columbia-Towson, MD                  | 10   |
| 580                  | Nashville-Davidson--Murfreesboro--Franklin, TN | 11   |
| 549                  | Richmond, VA                                   | 12   |
| 296                  | Columbus, OH                                   | 13   |
| 246                  | Salt Lake City, UT                             | 14   |
| 245                  | Portland-Vancouver-Hillsboro, OR-WA            | 15   |
| 197                  | Charlotte-Concord-Gastonia, NC-SC              | 16   |
| 191                  | Boise City, ID                                 | 17   |
| 125                  | Harrisonburg, VA                               | 18   |
| 99                   | Cincinnati, OH-KY-IN                           | 19   |
| 13                   | Roanoke, VA                                    | 20   |

---

### SQL Question 3

**Question:** Provide a 100% stacked column chart showing the % scooter share of each provider company for each day of 2020 for the MSA that contains Washington, DC. Each column represents one day, with provider shares stacked to total 100%. The scooter share is the number of unique scooters a provider has in an MSA on a given day as a percentage of all the scooters seen that day in the same MSA.

**Query:**
```sql
WITH
BASE AS (
    SELECT 
        S.PROVIDER
        , DATE(S.EXTRACTED_AT) AS DATE
        , COUNT(DISTINCT(S.DECODED_ID)) AS PROVIDER_SCOOTERS
    FROM
        TE_ANALYTICS.BI.SCOOTERS_PARSED S
    INNER JOIN 
        TE_ANALYTICS.BI.US_HEX7_MSA M
    ON
        S.HEX7 = M.HEX7
    WHERE
        M.MSA ILIKE '%Washington%'
    AND
        DATE(S.EXTRACTED_AT) BETWEEN '2020-01-01' AND '2020-12-31'
    GROUP BY
        S.PROVIDER
        , DATE
)
SELECT
    PROVIDER_SCOOTERS / SUM(PROVIDER_SCOOTERS) OVER(PARTITION BY DATE) AS PERC_SHARE
    , PROVIDER
    , DATE
FROM
    BASE
ORDER BY
    DATE ASC
    , PROVIDER DESC
```

**Visualization:**

*Image Link:* https://github.com/BeccaJr/te_20251217_jbecca/blob/main/images/provider_share_dc_2020.png

*Note: Place your visualization image in an `images/` folder in the repository and update the link above*

*Note: Percentages are expressed on a 0–1 scale in the underlying data and shown as percentages in the visualization. Each column represents the distribution of unique scooters by provider for a single day within the Washington, DC MSA.*

**Total Rows Returned:** 316

**First 10 Rows (ordered by DATE ASC, PROVIDER DESC):**

| PERC_SHARE | PROVIDER     | DATE       |
|------------|--------------|------------|
| 0.162045   | revel        | 2020-01-25 |
| 0.249048   | jump         | 2020-01-25 |
| 0.021751   | boltmobility | 2020-01-25 |
| 0.567156   | bird         | 2020-01-25 |
| 0.165034   | revel        | 2020-01-26 |
| 0.260959   | jump         | 2020-01-26 |
| 0.023724   | boltmobility | 2020-01-26 |
| 0.550284   | bird         | 2020-01-26 |
| 0.166240   | revel        | 2020-01-27 |
| 0.270077   | jump         | 2020-01-27 |

**Last 10 Rows (ordered by DATE ASC, PROVIDER DESC):**

| PERC_SHARE | PROVIDER     | DATE       |
|------------|--------------|------------|
| 0.060117   | boltmobility | 2020-04-14 |
| 0.411303   | revel        | 2020-04-15 |
| 0.532182   | jump         | 2020-04-15 |
| 0.056515   | boltmobility | 2020-04-15 |
| 0.388060   | revel        | 2020-04-16 |
| 0.562189   | jump         | 2020-04-16 |
| 0.049751   | boltmobility | 2020-04-16 |
| 0.459235   | revel        | 2020-04-17 |
| 0.482529   | jump         | 2020-04-17 |
| 0.058236   | boltmobility | 2020-04-17 |

**Notes (optional):**
- The analysis reflects the actual availability of data for the Washington, DC MSA in 2020, which spans from late January to mid-April based on the underlying dataset.
- Scooter share is defined as the daily count of unique scooters per provider divided by the total number of scooters observed in the MSA on the same day, ensuring that each day sums to 100%.
- Scooters located outside U.S. MSAs are implicitly excluded through the join with the US_HEX7_MSA mapping table.

---

## Part 2: Data Transformation Exercise (dbt)

### DBT Question 1: Provider Scooters by MSA and Day

**Question:** How many unique scooters each provider has in each MSA on any given day?

**Model Name:** `fct_provider_msa_day.sql`

**Approach/Logic:**
The raw scooter location data was first normalized in staging models, extracting relevant fields from the semi-structured JSON. A temporary deduplication model was introduced to ensure a single scooter reading per scooter per timestamp using a window function.

The final fact model aggregates the deduplicated data at the grain of provider, MSA, and day, counting distinct scooters per group.

**Top 5 Rows (ordered by COUNT_SCOOTER DESC, DATE DESC):**

| PROVIDER_MSA_DAY_SK              | MSA                                | PROVIDER | DATE       | COUNT_SCOOTERS |
|----------------------------------|------------------------------------|----------|------------|----------------|
| 75b679b4c812473e9bd9726865e36a64 | Los Angeles-Long Beach-Anaheim, CA | bird     | 2020-03-10 | 6320           |
| 744159e26699756142b51a265205ab48 | Los Angeles-Long Beach-Anaheim, CA | bird     | 2020-02-16 | 4564           |
| fcd076506319482dc61f4352949c80b4 | Los Angeles-Long Beach-Anaheim, CA | bird     | 2020-03-08 | 4155           |
| e149efc4796188c62c6eff137a642217 | Los Angeles-Long Beach-Anaheim, CA | bird     | 2020-02-07 | 3841           |
| def887e36e36434bfbd3beda99589994 | Los Angeles-Long Beach-Anaheim, CA | bird     | 2020-03-05 | 3675           |

---

### DBT Question 2: Monthly Average Daily Displacement

**Question:** What is the monthly average of daily scooter displacement by company and MSA?

**Model Name:** `fct_company_msa_avg_disp_monthly.sql`

**Approach/Logic:**
Daily displacement was calculated as the distance between the first and last recorded scooter position per scooter per day, using Snowflake’s ST_DISTANCE function.

Daily displacement values were then averaged at the monthly level by provider and MSA to produce the final fact table.

**Top 5 Rows (ordered by AVERAGE_DISPLACEMENT DESC):**

| COMPANY_MSA_MONTH_SK             | MSA                                   | PROVIDER | MONTH      | AVERAGE_DISPLACEMENT |
|----------------------------------|---------------------------------------|----------|------------|----------------------|
| e610f6d7af554434a26de0bb3f539e46 | San Francisco-Oakland-Berkeley, CA    | scoot    | 2020-02-01 | 2205.99143442        |
| c97fb2379b00107cb2c45a85a2b24105 | San Francisco-Oakland-Berkeley, CA    | scoot    | 2020-01-01 | 2125.074249897       |
| 90eb8d95da9bd6cf683000a7c2063d52 | New York-Newark-Jersey City, NY-NJ-PA | revel    | 2020-01-01 | 2054.144284918       |
| 3d61d9d3149284d48594a9d8fc60ec71 | New York-Newark-Jersey City, NY-NJ-PA | revel    | 2020-02-01 | 1984.372330372       |
| 6ab463391887a7aa78c5fe821573ae1c | San Francisco-Oakland-Berkeley, CA    | scoot    | 2020-03-01 | 1937.497521407       |

---

## Additional Notes

- Assumed that a scooter belongs to a single MSA per day based on its hex7 location.
- Displacement is calculated using first and last observed positions per scooter per day.
- Records outside US MSAs are excluded via the US_HEX7_MSA join.
- dbt documentation screenshots (lineage and final models) are included in the `images/` directory.

---

## Checklist Before Submission

- [x] All SQL queries formatted and tested
- [x] All result markdown tables populated
- [x] Visualization for SQL Question 3 created and linked
- [x] All dbt models pushed to GitHub
- [x] All dbt tests passing (`dbt test` runs without errors)
- [x] dbt documentation screenshot added to repository
- [x] This SUBMISSION.md file completed and pushed to GitHub
- [x] Repository is clean (no unnecessary files, no credentials)
