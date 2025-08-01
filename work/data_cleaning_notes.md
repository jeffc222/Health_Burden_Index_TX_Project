# Data Cleaning Notes- Health Burden Index for Texas Cities (2024 CDC PLACES Data)
## Overview
This project analyzes the geographic distribution of chronic health burdens across Texas cities using the **CDC PLACES: Local Data for Better Health (2024 release)(../data/dataset_link.md)**. The data is mostly derived from the 2022 Behavioral Risk Factor Surveillance System (BRFSS). A custom **Health Burden Index (HBI)** was developed to measure the combined prevalence of four key indicators: **obesity, diabetes, smoking, and depression**, reported at the city (place) level.

The original dataset was imported into BigQuery and contained over **2.2 million rows** and **22 columns**. It included prevalence estimates for over 40 health outcomes across multiple geographic levels. This analysis focused specifically on place-level data for Texas. The data was filtered, reshaped, and visualized to enable meaningful city-level comparisons and support targeted public health planning. 

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

## Step 2: Classify Health Burden Levels and Add Popultaion Data (Google Sheets)
**Objective:** Enhance the **HBI** dataset by classifying cities into health burden categories and integrating population data for contextual analysis.

**Process**: After exporting the cleaned HBI dataset from BigQuery, the following steps were performed ing **Google Sheets:**

1. Created a new column for **Health Burden Level:**
   * **High** if HBI >= 30
   * **Moderate** if HBI <30 and >=20
   * **Low** if HBI <20
2. Applied conditional formatting to color-code the Health Burden Level column:
   * Red for High (>=30)
   * Yellow for Moderate (20-29.99)
   * Green for Low (<20)
3. Used VLOOKUP to join **TotalPopulation** and **TotalPop18plus** columns from a second sheet based on LocationID.
4. Combined the enriched HBI dataset and population data into a unified "hbi with pop" tab for further filtering and formatting.

**Rationale:**
Categorizing cities into burden levels improves interpretability and allows quick visual scanning of risk patterns. The threshold of **30+ for “High” HBI** reflects a severe cumulative burden when all four indicators (each often above national average) are elevated. **20–29.99 for “Moderate”** reflects elevated but non-critical levels, and scores **under 20** indicate relatively lower burden.

Including **population data** enables two important filters: (1) eliminating cities too small for stable estimates and (2) prioritizing cities based on impact potential. Both **TotalPopulation** and **TotalPop18plus** were included to allow flexibility, but only **TotalPopulation** was ultimately used for filtering.

---

## Step 3: Benchmarking and Final Filtering (Google Sheets)
**Objective:** Finalize the dataset for visualization by highlighting indicator-specific patterns and limiting the scope to actionable, reliable city-level data in Texas.

**Process:**
The following refinements were made in the same spreadsheet:
1. Used **SQL-calculated national averages** for each indicator (Obesity, Diabetes, Smoking, Depression) and entered these into a header row.
2. Applied **conditional formatting** to each indicator column:
   * Cells with values **above the national average** were highlighted in red
   * Cells **at or below average** remained unformatted
3. Filtered the unified dataset to include:
   * Only cities in Texas
   * Only cities with TotalPopulation > 500

**Rationale:**
Benchmarking cities against national averages helps contextualize local prevalence rates. Cities with HBI ≥ 30 and multiple indicators above national norms demand more urgent attention.

Filtering for Texas only narrowed the focus of the project, aligning with its original geographic scope. The population threshold of >500 excluded extremely small or rural towns where model-based estimates can be unstable, ensuring the final dataset was suitable for public health recommendations and visualization.











## 6. Exported Clean Dataset
Filtered final table to only include Texas cities with population > 500.

Exported to .xlsx and used that for Tableau mapping.

