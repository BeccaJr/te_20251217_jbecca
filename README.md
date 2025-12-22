
# Analytics Engineering Technical Exercise

This repository contains the complete solution for the **Analytics Engineering Technical Exercise**, including analytical SQL queries and a dbt-based data transformation pipeline built on Snowflake.

---

## 📌 Project Overview

The objective of this project is to demonstrate practical Analytics Engineering skills, including:

- Writing analytical SQL to answer business questions
- Designing and implementing a dbt transformation pipeline
- Modeling fact tables for analytical use cases
- Applying data quality tests and documentation best practices
- Communicating assumptions and results clearly

The hypothetical business context is a **scooter rental company** operating across multiple U.S. Metropolitan Statistical Areas (MSAs).

---

## 🗂️ Repository Structure

```
.
├── analysis/                 # Ad-hoc analysis files (if any)
├── data/                     # Optional local data (not used in this exercise)
├── images/                   # Visual assets (charts and dbt docs screenshots)
│   ├── provider_share_dc_2020.png
│   ├── dbt_docs_lineage.png
│   ├── dbt_docs_fct_provider_msa_day.png
│   └── dbt_docs_fct_company_msa_avg_disp_monthly.png
├── macros/                   # dbt macros (if applicable)
├── models/
│   ├── sources/              # Raw data from Snowflake
│   ├── staging/              # Staging models (stg_)
│   ├── tmp/                  # Temporary / intermediate models (tmp_)
│   └── marts/                # Final fact models (fct_)
├── snapshots/                # dbt snapshots (not used)
├── tests/                    # Custom tests (if any)
├── dbt_project.yml           # dbt project configuration
├── packages.yml              # dbt package dependencies
├── profiles_temp.yml         # Example dbt profile (no credentials)
├── SUBMISSION.md             # Exercise answers and results
└── README.md                 # Project documentation (this file)
```

---

## 🧠 Data Sources

Raw data is provided in Snowflake under the `TE_RAW.SCOOTERS` schema:

- **SCOOTER_LOCATIONS**  
  Semi-structured (JSON) scooter location data containing:
  - Scooter identifier (`decoded_id`)
  - Provider
  - Latitude / Longitude
  - Timestamp (`extracted_at`)
  - H3 hexagon indexes

- **US_HEX7_MSA**  
  Mapping table between H3 resolution-7 hexagons and U.S. MSAs.

Raw data sources are declared in the models/sources/ directory using dbt source() configurations.
These definitions act as the contract between the raw data layer and the analytics transformation pipeline.

Defining sources explicitly enables:
  - Clear lineage from raw data to analytical models
  - Source-level documentation and metadata visibility in dbt docs
  - Freshness monitoring and data quality validation at the ingestion boundary

---

## 🧱 dbt Modeling Approach

The dbt project follows standard Analytics Engineering best practices:

### 1️⃣ Staging Models (`stg_`)
- Extract and normalize fields from raw semi-structured JSON
- Apply consistent naming and data types
- Serve as the single entry point to raw data

### 2️⃣ Temporary Models (`tmp_`)
- Deduplicate scooter readings using window functions
- Calculate first/last scooter positions per day
- Compute daily displacement metrics

### 3️⃣ Fact Models (`fct_`)
Final analytical models answering the business questions:

#### `fct_provider_msa_day`
**Grain:** provider × MSA × day  
**Metric:** count of unique scooters per provider per MSA per day

#### `fct_company_msa_avg_disp_monthly`
**Grain:** provider × MSA × month  
**Metric:** monthly average of daily scooter displacement, calculated as the distance between the first and last scooter position per day

---

## 🧪 Data Quality & Testing

- Primary keys defined for all fact models
- dbt schema tests applied:
  - `unique`
  - `not_null`
- Source freshness checks configured for raw scooter location data

All tests pass successfully using `dbt test`.

---

## 📊 Analytical SQL Exercise

Part 1 of the exercise includes:

- SQL queries answering business questions about scooter distribution
- Aggregations by MSA, provider, and time
- A 100% stacked column chart showing daily provider scooter share in the Washington, DC MSA

Queries, results, and visualizations are fully documented in **SUBMISSION.md**.

---

## 📚 Documentation

dbt documentation was generated using:

```bash
dbt docs generate
dbt docs serve
```

Screenshots of the dbt documentation and lineage graphs are included in the `images/` directory.

---

## ▶️ How to Run the Project

1. Install dbt (CLI)
2. Configure your Snowflake profile using `profiles_temp.yml` as a reference
3. Install dependencies:
   ```bash
   dbt deps
   ```
4. Run models:
   ```bash
   dbt run
   ```
5. Run tests:
   ```bash
   dbt test
   ```
6. Generate documentation:
   ```bash
   dbt docs generate
   dbt docs serve
   ```

---

## 📝 Notes & Assumptions

- Analysis is limited to U.S. MSAs using the `US_HEX7_MSA` mapping
- Scooters are assumed to belong to a single MSA per day based on their hex7 location
- Displacement is calculated using Snowflake spatial functions (`ST_DISTANCE`)
- Timestamps are assumed to be in UTC

---

## 👤 Author

**José Celso Becca Júnior**  
Analytics Engineering Technical Exercise  

---

## ✅ Status

✔ Project completed  
✔ All deliverables submitted  
✔ dbt models, tests, and documentation finalized  
