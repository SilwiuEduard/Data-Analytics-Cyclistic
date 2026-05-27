# 🚴 Cyclistic Bike-Share Analysis

## 📌 Project Overview

The objective is to analyze historical trip data from **Cyclistic**, a prominent bike-share company in Chicago, to identify behavioral variations between two distinct user segments: **Annual Members** and **Casual Riders**.

The strategic business objective is to design a data-driven marketing blueprint to convert casual riders into high-value annual members, ensuring sustainable long-term revenue growth for the company.

---

## 📊 Quick Links & Interactive Assets

- 📊 **Tableau Live Dashboard:** [Explore the Interactive Visualizations](https://public.tableau.com/views/Cyclist-KPIDataAnalysis-SilviuEduardChiriloaie/1_1NumberofridesperdayMembersvs_Casual?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
- 📄 **Executive Presentation:** [View Final Slide Deck (PDF)](presentation/Cyclistic%20Stratetic%20Conversion%20Analysis.pdf)

---

## 🛠️ Data Analysis Methodology

### 1. Ask

- **Core Business Question:** How do annual members and casual riders use Cyclistic bikes differently?
- **Objective:** Deliver compelling, data-backed insights and actionable recommendations to Lily Moreno (Director of Marketing) to guide the next phase of digital advertising and conversion strategies.

### 2. Prepare (Data Source & Architecture)

- **Data Scope:** Historical trip records spanning from **May 2025 to April 2026** (12 individual CSV files).
- **Data Source:** Open-source public data provided by the City of Chicago through Motivate International Inc. under an explicit data license agreement.
- **Volume Metrics:** The initial raw dataset contained **~5.69 million records**. Following a rigorous data cleaning pipeline, the final analytical dataset contains **5,541,510 valid rows**.
- **Tech Stack:** **Google BigQuery (SQL)** was selected to architect and manage this project. Utilizing cloud data warehousing allowed processing at a scale that far overcomes Excel's physical limit of 1.04 million rows, ensuring performance optimization, security, and absolute reproducibility.

### 3. Process & Data Engineering Highlights

Data integrity was systematically established through comprehensive cleaning and engineering protocols in BigQuery:

- **Schema Validation:** Verified that all 12 structural source files maintained identical column configurations and data types prior to execution.
- **Timeline Anomaly Resolution:** Identified and programmatically bypassed a structural naming mismatch within the January 2026 source archive, manually verifying timeline alignments.
- **Strict Business Rules Execution:**
  - Filtered out all trips with a duration under 60 seconds (`ride_length_seconds < 60`) to eliminate accidental unlocks and system testing events, safely removing **155,916 rows**.
  - Detected and purged negative trip durations caused by backend system synchronization errors.
- **Feature Enrichment:** Extracted `ride_length` (modeled both as continuous numeric seconds and structured timestamps) and engineered a standardized `day_of_week` calendar mapping (where 1 represents Monday and 7 represents Sunday).
- **Missing Value Analysis:** Segmented null tracking across station fields. Proved that `electric_bike` null entries natively correlate with dockless, street-flexible urban parking models, whereas classic bike null entries successfully pinpointed localized hardware and docking terminal maintenance issues.

### 4. Analyze

Key behavioral insights extracted from the structured datasets:

- **Commuting vs. Leisure:** Annual members display sharp utilization spikes during weekday rush hours (07:00–09:00 and 16:00–18:00), signaling deep reliance on bike-sharing for daily workplace commuting. Conversely, casual riders exhibit steady afternoon growth building heavily into a dominant weekend leisure footprint.
- **The Financial Argument:** Members consistently opt for shorter, utility-driven trips. Casual riders heavily dominate long and very long trip brackets (30+ and 60+ minutes), making them prime targets for membership cost-efficiency mapping.
- **Leisure & Circular Spatial Patterns:** A deep dive into spatial data reveals that for casual riders, the **top 6 most popular stations are identical for both trip starts and trip ends**. This high correlation strongly highlights a recreational, loop-based behavior, where users rent and return assets within the exact same high-traffic tourism or waterfront hubs.
- **Structural Anomalies:** Tracked asset behavior metrics including dropouts/system abandonments on traditional classic bikes and the operational flexibility of free-floating dockless electric units.

### 5. Share

Data visualizations and dashboards were engineered using **Tableau** to present clear narrative trends to stakeholders. The visual pipeline matches the automated aggregation metrics derived directly from the underlying SQL queries.

### 6. Act (Top Strategic Recommendations)

1. **Targeted Duration ROI Ads:** Launch targeted digital campaigns aimed at casual riders who clock trips over 30 minutes on weekends, demonstrating the exact pricing pivot where an annual membership saves them money.
2. **High-Traffic Hub Campaigns:** Prioritize localized physical and digital marketing spend at the Top 15 stations most frequented by casual riders during peak seasons.
3. **The Weekend-to-Member Gateway Pass:** Introduce a seasonal or weekend-only pass that offers a seamless, automated upgrade path allowing users to credit pass costs toward a full annual membership subscription.

---

## 📂 Repository Architecture

```text
├── scripts/                          # Enterprise SQL Analysis Scripts (BigQuery)
│   ├── 04_daily_summary_kpi.sql
│   ├── 05_monthly_summary_kpi.sql
│   ├── 06_classic_bikes_and_dropouts.sql
│   ├── 07_electric_bikes_and_dockless.sql
│   ├── 08_hourly_distribution.sql
│   ├── 09_top_15_stations.sql
│   └── 10_financial_argument_duration_distribution.sql
├── visualizations/                   # Clean Tableau Chart Exports & Mini-Gallery
│   ├── dashboard_preview.png
│   └── README.md
├── presentation/                     # Final Executive Deliverables
│   ├── cyclistic_executive_presentation.pdf
│   └── cyclistic_executive_presentation.pptx
└── README.md                         # Main Documentation Hub


Author: Silviu Eduard Chiriloaie

Data Analytics Portfolio Case Study
```
