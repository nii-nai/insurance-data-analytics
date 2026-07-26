# 📊 Insurance Analytics Portfolio Project

![Python](https://img.shields.io/badge/Python-3.x-3776AB?logo=python&logoColor=white)
![BigQuery](https://img.shields.io/badge/BigQuery-Google_Cloud-4285F4?logo=googlecloud&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-GoogleSQL-blue)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

An end-to-end analytics project exploring anonymized company and customer insurance data — from raw CSV ingestion through Python-based ETL, BigQuery data modeling, SQL analysis, and Power BI visualization — to uncover claims behavior trends and assess portfolio sustainability.

---

## 📑 Table of Contents

- [Overview](#-overview)
- [Objective](#-objective)
- [Tech Stack](#-tech-stack)
- [Data Sources](#-data-sources)
- [Data Model (ERD)](#-data-model-erd)
- [Pipeline / Methodology](#-pipeline--methodology)
- [Key Analyses](#-key-analyses)
- [Key Findings](#-key-findings)
- [Dashboard](#-dashboard)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Limitations & Next Steps](#-limitations--next-steps)
- [Author](#-author)

---

## 📝 Overview

This project analyzes anonymized company and customer insurance data to uncover trends in claim behavior across demographic and policy factors (age, dependents, smoker status), and evaluates overall claims performance against premiums collected. The pipeline covers the full analytics workflow: data ingestion, transformation, loading, SQL-based analysis, and dashboard visualization.

## 🎯 Objective

To explore how demographic and policy factors relate to claims behavior, and to assess the financial sustainability of the insurance portfolio by comparing claims paid out against premiums collected.

## 🛠 Tech Stack

| Layer | Tool |
|---|---|
| ETL / Transformation | Python (`pandas`, `NumPy`, `openpyxl`) |
| Data Warehouse | Google BigQuery |
| Analysis | GoogleSQL (BigQuery SQL) |
| Visualization | Power BI (DAX) |
| Presentation | Google Slides |

## 📂 Data Sources

Raw data was sourced as **two anonymized CSV files**:

- **Customers insurance data** — ~50,000 rows, covering individual customer policies, demographics, and claims behavior
- **Companies (corporate) insurance data** — ~2,500 rows, covering corporate policies, covered employees, and claims

> ⚠️ See [Limitations & Next Steps](#-limitations--next-steps) — the significant size difference between these two sources (50,000 vs. 2,500 rows) introduces bias when comparing across market segments.

## 🗂 Data Model (ERD)

The data was modeled into the following relational structure in BigQuery:

![Insurance ERD](assets/erd.png)

**Core entity groups:**
- **Corporate side** — `companies`, `branches`, `corporate_insurance`, `covered_employees`, `beneficiaries`
- **Retail/customer side** — `customers_info`, `customer_policies`, `agents`
- **Shared** — `insurance_products`, `policy_table`, `premium_payments`, `claims`, `claim_workflow`

## 🔄 Pipeline / Methodology

![Data Analytics Workflow](assets/workflow.png)

1. **CSV File** — Raw data collected and stored in CSV format
2. **Python (Transformation)** — Data cleaning, transformation, feature engineering, and preparation using `pandas`, `NumPy`, and `openpyxl`
3. **Google BigQuery (Query Database)** — Loaded transformed data and ran SQL queries on the data warehouse
4. **Power BI (Visualisations)** — Built interactive dashboards, KPIs, and insightful visualizations
5. **Google Slides (Presentation)** — Presented findings and recommendations to stakeholders

**Outcome:** Data-driven insights for better business decisions

## 🔍 Key Analyses

- **Age vs. Claim Amount** — Grouped employees/customers into age bands to compare claim volume and total claim amounts
- **Dependents vs. Claim Behavior** — Examined how number of dependents relates to claims filed and amounts paid
- **Smoker Status vs. Claim Behavior** — Compared claim amount and frequency between smokers and non-smokers
- **Claims per Employee** — Normalized claim counts by employee population for fair cross-group comparison
- **Claim-to-Premium Ratio** — Evaluated overall portfolio sustainability by comparing total claims paid to total premiums collected
- **Claims by Company, Type, and Time** — Broke down claim amounts by corporate client, claim type, and month/year trend

## 💡 Key Findings

- Older employees (55+) filed claims at a higher rate per employee (**1.09**) compared to middle-aged (**0.95**) and younger (**0.94**) employees — suggesting age-related risk should factor into premium structuring
- **Non-smokers** and customers with **no dependants** showed the **highest claim amounts and frequency**, a counterintuitive finding worth further investigation
- The overall **claim-to-premium ratio was 8.02** (Total Claims: **GHS 69.22M** vs. Total Premiums: **GHS 8.63M**) — meaning the company paid out roughly **8x more** in claims than it collected in premiums, a significant red flag for underwriting sustainability
- **Death Benefit** and **Surgery** were the largest claim types by amount, followed by Hospitalization and Emergency Care
- Of **2.5K** total claims, the majority (**1,736**) were Approved, with **508** Pending and **256** Rejected

## 📊 Dashboard

![Claims Dashboard](assets/dashboard_preview.png)

The Power BI dashboard (styled for a sample client, "Hollard") includes:
- KPI summary cards — Claim Amount, No. of Claims, Total Premiums, Claim-to-Premium Ratio
- Claim-to-premium amounts and ratio broken down by company
- Claim amount by claim type
- Claim amount trend by year and month
- Approval status breakdown (Approved / Pending / Rejected)
- Region and Year/Month slicers for interactive filtering

## 📁 Project Structure

```
insurance-analytics/
├── data/
│   └── raw/                     # customers_data.csv, companies_data.csv
├── etl/
│   └── transform.py             # Python transformation script (pandas, NumPy, openpyxl)
├── sql/
│   ├── schema.sql               # BigQuery table definitions
│   └── queries/                 # Analysis queries
├── dashboard/
│   └── insurance_dashboard.pbix
├── assets/
│   ├── erd.png
│   ├── workflow.png
│   └── dashboard_preview.png
└── README.md
```

## 🚀 Getting Started

### Prerequisites
- Python 3.x
- Google Cloud account with BigQuery access
- Power BI Desktop

### Setup

```bash
# 1. Clone this repository
git clone https://github.com/[your-username]/insurance-analytics.git
cd insurance-analytics

# 2. Install dependencies
pip install -r requirements.txt

# 3. Run the ETL script
python etl/transform.py
```

Then:
1. Load the transformed output into BigQuery using `sql/schema.sql`
2. Run analysis queries found in `sql/queries/`
3. Open `dashboard/insurance_dashboard.pbix` in Power BI Desktop and refresh the data connection

## ⚠️ Limitations & Next Steps

- **Sample size imbalance** — The sourced data came in two CSV files: customer insurance data (~50,000 rows) and companies insurance data (~2,500 rows). This disparity rendered analysis across market segments (retail vs. corporate) wholly biased, since the retail segment is over-represented relative to the corporate segment.
- **Next steps:**
  - Source a more balanced or proportionally-weighted sample across both segments before drawing cross-segment conclusions
  - Investigate the non-smoker / no-dependents claims finding further — determine whether this reflects a genuine risk pattern or a sampling artifact
  - Add predictive modeling to flag high-risk profiles ahead of policy underwriting
  - Automate the ETL pipeline (e.g. Cloud Functions, Airflow) for recurring refreshes

## 👤 Author

**[Your Name]**
[LinkedIn](#) · [Portfolio](#) · [Email](#)

---
⭐️ If you found this project useful, consider giving it a star!
