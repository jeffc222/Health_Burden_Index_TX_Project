# Data Cleaning Notes- Health Burden Index for Texas Cities (2024 CDC PLACES Data)
## Overview
This project analyzes the geographic distribution of chronic health burdens across Texas cities using the **CDC PLACES: Local Data for Better Health (2024 release)(../data/dataset_link.md)**. The data is mostly derived from the 2022 Behavioral Risk Factor Surveillance System (BRFSS). A custom **Health Burden Index (HBI)** was developed to measure the combined prevalence of four key indicators: **obesity, diabetes, smoking, and depression**, reported at the city (place) level.

The original dataset was imported into BigQuery and contained over **2.2 million rows** and **22 columns**. It included prevalence estimates for over 40 health outcomes across multiple geographic levels. This analysis focuseed specifically on place-level data for Texas. The data was filtered, reshaped, and visualized to enable meaningful city-level comparisons and support targeted public health planning. 

covering model-based prevalence estimates for more than 40 health outcomes across multiple geographies. This project focused exclusively on **place-level data within Texas**, which was cleaned, reshaped, and visualized to support city-level comparisons and inform public health interventions.

---

## Step 1: Dataset Extraction and Reshaping (SQL in BigQuery)
**Objective:** Create a city-level dataset from the CDC PLACES Local 2024 release that includes the four core health indicators needed to calculate the **Health Burden Index (HBI).**

**Process:** The full CDC PLACES Local 2024 dataset, containing over **2.2 million rows** across all U.S. geographies, was imported into **Google BigQuery** to support scalable querying. Using SQL, the dataset was filtered to include only:
* **YEAR** = 2022
* **Data_Value_Type** = 'Crude Prevalence'
* **Measure_ID** (Health Indicators = 'OBESITY', 'DIABETES', 'CSMOKING', 'DEPRESSION'
* **Non-null values** for all selected indicators

The filtered records were then reshaped using a **pivot transformation** (MAX(CASE WHEN ...)) so that each row represented a unique city/place, with four separate columns for the health indicators. A new column was created to calculate the **Health Burden Index (HBI)** by averaging the four prevalence values.

**Rationale:**
The **2024 PLACES Local** dataset is derived from the CDC’s 2022 BRFSS cycle and provides model-based estimates of health conditions at small geographic units such as cities and census-designated places. Among the 40+ measures included in the release, four indicators were selected for the **HBI** to reflect both clinical relevance and widespread public health significance.

The use of **Crude Prevalence** ensures consistency across cities without adjusting for age or demographic weights, making comparisons more direct. Implementing the data transformation and HBI calculation in SQL allowed efficient processing of millions of records and produced a clean, wide-format dataset tailored for city-level analysis in later steps.

--- 

## Step 2: Data Reshaping and Index Construction (SQL)
**Objective:** Pivot the dataset and calculate a composite **Health Burden Index (HBI)** for each city.

**Process:**
* Applied MAX(CASE WHEN...) statements to pivot the data into wide format, producing one row per city with columns for each of the four indicators.
* Calculated the **HBI** as the arithmetic mean of the four selected prevalence values, rounded to two decimal places.
* Ranked all cities in Texas by descending HBI value to identify the highest-burden areas.

**Rationale:** A wide format enabled straightforward aggregation and ranking. Using a **simple average** of the four indicators ensures transparency, avoids weighting bias, and gives equal consideration to all conditions. The resulting index allows for a single-metric comparison of health burden across cities.

---

## Step 3: Population Data Join and Filtering (Google Sheets)
**Objective:** Enrich the dataset with city population estimates and exclude sparsely populated areas.

**Process:**
* Used a secondary table from the same PLACES dataset containing **TotalPopulation** for each location.
* Imported the table into Google Sheets and merged it with the main HBI dataset using LocationID via **VLOOKUP.**
* Applied a **population filter** to retain only cities with **500 or more residents.**

**Rationale:** Cities with very small populations often produce unstable estimates that can distort rankings due to model-based variability or rounding artifacts. A 500-person cutoff balances inclusivity with data reliability, helping to ensure that trends reflect meaningful community-level burdens rather than statistical noise.

---



## 5. Formatting in Google Sheets
Ensured consistent number formatting (1–2 decimal places).

Applied filters to allow exploratory sorting (by state, city, indicator, etc.).

Conditional formatting:
* Health Level colors: Green (Low), Yellow (Moderate), Red (High)
* Highlighted values above national averages

## 6. Exported Clean Dataset
Filtered final table to only include Texas cities with population > 500.

Exported to .xlsx and used that for Tableau mapping.

