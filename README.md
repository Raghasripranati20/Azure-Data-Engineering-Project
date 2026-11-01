# AdventureWorks-Azure-Project

An end-to-end data engineering project built on the **AdventureWorks** dataset using the **Azure** ecosystem. Raw CSV files are ingested dynamically with **Azure Data Factory (ADF)**, transformed with **Azure Databricks** following the **Medallion Architecture** (Bronze → Silver → Gold), served through **Azure Synapse Analytics**, and visualized in a **Power BI** report.

---

## Architecture

```
GitHub (source CSVs)
        │
        ▼
Azure Data Factory  ──►  Azure Data Lake Storage Gen2
(dynamic pipelines)       ├── Bronze  (raw data)
                          ├── Silver  (cleaned / transformed via Databricks)
                          └── Gold    (curated, served via Synapse)
                                   │
                                   ▼
                       Azure Synapse Analytics
                  (external tables + Gold views)
                                   │
                                   ▼
                              Power BI
```



---

## Tech Stack

| Layer | Tool |
|---|---|
| Ingestion / Orchestration | Azure Data Factory (ADF) |
| Storage | Azure Data Lake Storage Gen2 |
| Transformation | Azure Databricks (PySpark) |
| Serving / Warehousing | Azure Synapse Analytics (Serverless SQL Pool) |
| Visualization | Power BI |
| Version Control | Git / GitHub |

---

## Project Structure

```
Adventure_Works_DataEngineering_Project/
│
├── Dataset/                      # Source AdventureWorks CSV files
│   ├── AdventureWorks_Calendar.csv
│   ├── AdventureWorks_Customers.csv
│   ├── AdventureWorks_Product_Categories.csv
│   ├── AdventureWorks_Product_Subcategories.csv
│   ├── AdventureWorks_Products.csv
│   ├── AdventureWorks_Returns.csv
│   ├── AdventureWorks_Sales_2015.csv
│   ├── AdventureWorks_Sales_2016.csv
│   ├── AdventureWorks_Sales_2017.csv
│   └── AdventureWorks_Territories.csv
│
├── Silver_Layer/
│   └── SILVER_LAYER.ipynb        # Databricks notebook for transformations
│
├── Gold_Layer/
│   ├── Create Schema.sql         # Creates schema in Synapse
│   ├── External_table.sql        # External tables over Gold data
│   └── create views gold.sql     # Gold-layer views
│
├── git.json                      # Config driving the dynamic ADF pipelines
├── power bi report azure project.pbix   # Power BI report
└── README.md
```

---

## Pipeline Walkthrough

### 1. Data Ingestion – Azure Data Factory (Bronze)
- Source CSV files are pulled from GitHub using a **dynamic, parameterized ADF pipeline**.
- `git.json` holds the file/path metadata that is passed into the pipeline (via Lookup + ForEach activities), so a single pipeline can ingest all datasets without hardcoding each one.
- Data lands as-is in the **Bronze** container of Azure Data Lake Storage Gen2.

### 2. Transformation – Azure Databricks (Silver)
- `SILVER_LAYER.ipynb` reads the Bronze data and applies PySpark transformations such as:
  - Schema enforcement and data type casting
  - Cleaning and standardizing columns
  - Handling nulls / duplicates
  - Date and derived-column creation
- Cleaned data is written to the **Silver** container (Parquet/Delta).

### 3. Serving – Azure Synapse Analytics (Gold)
- `Create Schema.sql` – creates the `gold` schema.
- `External_table.sql` – defines external tables pointing to the Silver/Gold data in the data lake.
- `create views gold.sql` – builds business-ready views used for reporting.

### 4. Reporting – Power BI
- `power bi report azure project.pbix` connects to the Synapse Gold views and presents key sales insights (sales, returns, products, customers, territories, trends over time).



## Dataset

The **AdventureWorks** dataset consists of 10 CSV files:

| File | Description |
|---|---|
| Calendar | Date dimension |
| Customers | Customer details |
| Product_Categories | Product categories |
| Product_Subcategories | Product subcategories |
| Products | Product master data |
| Returns | Returned items |
| Sales_2015 / 2016 / 2017 | Sales transactions by year |
| Territories | Sales territories |

---

## How to Run

1. **Provision Azure resources**: Resource Group, Storage Account (ADLS Gen2) with `bronze`, `silver`, `gold` containers, Azure Data Factory, Azure Databricks workspace, and Azure Synapse workspace.
2. **Configure ADF**: connect ADF to this GitHub repo, create linked services (HTTP/GitHub source and ADLS sink), and import the dynamic pipeline using `git.json`.
3. **Run the ingestion pipeline** to load raw CSVs into the Bronze layer.
4. **Run the Databricks notebook** (`Silver_Layer/SILVER_LAYER.ipynb`) to produce Silver data. Make sure the cluster has access to your storage account.
5. **Run the Gold SQL scripts in Synapse** in this order:
   1. `Create Schema.sql`
   2. `External_table.sql`
   3. `create views gold.sql`
6. **Open the Power BI report** (`.pbix`), update the data source to your Synapse serverless SQL endpoint, and refresh.

---

## Key Learnings

- Building metadata-driven, dynamic pipelines in ADF
- Implementing the Medallion Architecture on Azure
- Large-scale transformations with PySpark in Databricks
- Using Synapse external tables and views over a data lake
- Connecting Power BI to Synapse for analytics

---



⭐ If you found this project helpful, consider giving it a star!
