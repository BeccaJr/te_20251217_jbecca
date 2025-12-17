# Technical Exercise Submission

**Candidate Name:** [Your Name]

**Submission Date:** [YYYY-MM-DD]

**GitHub Repository:** [Repository URL]

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
-- Your SQL query here
```

**Results (Top 3 MSAs, ordered by RANK ASC):**

| Row | MSA | UNIQUE_SCOOTER_COUNT | TOTAL_SCOOTER_COUNT | UNIQUE_SCOOTER_PERC | RANK |
| --- | --- | --- | --- | --- | --- |
| 1   |     |     |     |     |     |
| 2   |     |     |     |     |     |
| 3   |     |     |     |     |     |

*Note: TOTAL_SCOOTER_COUNT represents the total unique scooters across all MSAs for the time period*

**Notes (optional):**
*Add any relevant comments about assumptions, data quality issues, or edge cases encountered*

---

### SQL Question 2

**Question:** Write a query that computes the overall rank of MSAs based on the number of unique scooters for March 3rd, 2020. The MSA with the most scooters will have rank = 1.

**Query:**
```sql
-- Your SQL query here
```

**Results (All MSAs, ordered by MSA_RANK ASC):**

| Row | UNIQUE_SCOOTERS_COUNT | MSA | MSA_RANK |
| --- | --- | --- | --- |
| 1   |     |     |     |
| 2   |     |     |     |
| 3   |     |     |     |
| 4   |     |     |     |
| 5   |     |     |     |
| 6   |     |     |     |
| 7   |     |     |     |
| 8   |     |     |     |
| 9   |     |     |     |
| 10  |     |     |     |

**Notes (optional):**
*Add any relevant comments about assumptions, data quality issues, or edge cases encountered*

---

### SQL Question 3

**Question:** Provide a 100% stacked column chart showing the % scooter share of each provider company for each day of 2020 for the MSA that contains Washington, DC. Each column represents one day, with provider shares stacked to total 100%. The scooter share is the number of unique scooters a provider has in an MSA on a given day as a percentage of all the scooters seen that day in the same MSA.

**Query:**
```sql
-- Your SQL query here
```

**Visualization:**

![Provider Share Chart](./images/your_image.png)

*Note: Place your visualization image in an `images/` folder in the repository and update the link above*

**Total Rows Returned:** [Enter total count]

**First 10 Rows (ordered by DATE ASC, PROVIDER DESC):**

| PERC_SHARE | PROVIDER | DATE |
| --- | --- | --- |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |

**Last 10 Rows (ordered by DATE ASC, PROVIDER DESC):**

| PERC_SHARE | PROVIDER | DATE |
| --- | --- | --- |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |
|     |     |     |

**Notes (optional):**
*Add any relevant comments about assumptions, data quality issues, or edge cases encountered*

---

## Part 2: Data Transformation Exercise (dbt)

### DBT Question 1: Provider Scooters by MSA and Day

**Question:** How many unique scooters each provider has in each MSA on any given day?

**Model Name:** `fct_provider_msa_day.sql`

**Approach/Logic:**
*Describe your data model design: staging models used, deduplication logic, grain of final model*

**Top 5 Rows (ordered by COUNT_SCOOTER DESC, DATE DESC):**

| MSA | PROVIDER | DATE | COUNT_SCOOTER |
| --- | --- | --- | --- |
| 1   |     |     |     |
| 2   |     |     |     |
| 3   |     |     |     |
| 4   |     |     |     |
| 5   |     |     |     |

---

### DBT Question 2: Monthly Average Daily Displacement

**Question:** What is the monthly average of daily scooter displacement by company and MSA?

**Model Name:** `fct_company_msa_avg_disp_monthly.sql`

**Approach/Logic:**
*Describe your approach: how you calculated displacement, how you aggregated to monthly averages, which Snowflake distance function used*

**Top 5 Rows (ordered by AVERAGE_DISPLACEMENT DESC):**

| MSA | PROVIDER | MONTH | AVERAGE_DISPLACEMENT |
| --- | --- | --- | --- |
| 1   |     |     |     |
| 2   |     |     |     |
| 3   |     |     |     |
| 4   |     |     |     |
| 5   |     |     |     |

---

## Additional Notes

*Use this section to add any clarifications, assumptions, or explanations about your approach:*

-
-
-

---

## Checklist Before Submission

- [ ] All SQL queries formatted and tested
- [ ] All result markdown tables populated
- [ ] Visualization for SQL Question 3 created and linked
- [ ] All dbt models pushed to GitHub
- [ ] All dbt tests passing (`dbt test` runs without errors)
- [ ] dbt documentation screenshot added to repository
- [ ] This SUBMISSION.md file completed and pushed to GitHub
- [ ] Repository is clean (no unnecessary files, no credentials)
