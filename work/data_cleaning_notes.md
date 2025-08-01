# Data Cleaning Notes- Health Burden Index for Texas Cities (2024 CDC PLACES Data)
## Overview
This project analyzes the geographic distribution of chronic health burdens across Texas cities using the **[CDC PLACES: Local Data for Better Health (2024 release)](../data/dataset_link.md)**. The data is primarily from the 2022 Behavioral Risk Factor Surveillance System (BRFSS). A custom **Health Burden Index (HBI)** was developed to measure the combined prevalence of four key indicators: **obesity, diabetes, smoking, and depression**, reported at the city (place) level.

The **Health Burden Index (HBI)** is a simple average of the prevalence rates of the four selected conditions, calculated for each city to capture its overall chronic disease burden in a single score. This metric enables comparison across locations by summarizing multiple health risks into one interpretable value. 

The original dataset was imported into BigQuery and contained over **2.2 million rows** and **22 columns**. It included prevalence estimates for over 40 health outcomes across multiple geographic levels. This analysis focused specifically on place-level data for Texas. The data was filtered, reshaped, and visualized to enable meaningful city-level comparisons and support targeted public health planning. 

The goal of this analysis was to **identify Texas cities** with notably **high cumulative health burdens** to inform targeted community interventions. 


---

## Step 1: Dataset Extraction and Reshaping (SQL in BigQuery)
**Objective:** Create a city-level dataset from the CDC PLACES Local 2024 release that includes the four core health indicators needed to calculate the **Health Burden Index (HBI).**

**Process:** The full [CDC PLACES Local 2024 dataset](../data/dataset_link.md), containing over **2.2 million rows** across all U.S. geographies, was imported into **Google BigQuery** to support scalable querying. Using SQL, the dataset was filtered to include only:
* **YEAR** = 2022
* **Data_Value_Type** = 'Crude Prevalence'
* **Measure_ID** (Health Indicators) = 'OBESITY', 'DIABETES', 'CSMOKING', 'DEPRESSION'
* Only rows with **non-null values** for all selected indicators

The filtered records were then reshaped using a **pivot transformation** (MAX(CASE WHEN ...)) so that each row represented a unique city/place, with four separate columns for the health indicators. A new column was created to calculate the **Health Burden Index (HBI)** by averaging the four prevalence values.

**Rationale:**

The **2024 PLACES Local** dataset is derived from the CDC’s 2022 BRFSS cycle and provides model-based estimates of health conditions at small geographic units such as cities and census-designated places. Among the 40+ measures included in the release, four indicators were selected for the **HBI** to reflect both clinical relevance and widespread public health significance.

The use of **Crude Prevalence** ensures consistency across cities without adjusting for age or demographic weights, making comparisons more direct. Implementing the data transformation and HBI calculation in SQL allowed efficient processing of millions of records and produced a clean, wide-format dataset tailored for city-level analysis in later steps.

--- 

## Step 2: Classify Health Burden Levels and Add Population Data (Google Sheets)
**Objective:** Enhance the **HBI** dataset by categorizing cities based on their calculated **HBI** and integrating population data for contextual analysis.

**Process**: After exporting the cleaned HBI dataset from BigQuery, the following steps were performed in **Google Sheets:**

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

Categorizing cities into burden levels improves interpretability and allows quick visual scanning of risk patterns. The threshold of **30+ for “High” HBI** represents a severe cumulative burden when multiple key health indicators exceed national norms. **20–29.99 for “Moderate”** reflects elevated but non-critical levels, and scores **under 20** indicate relatively lower burden.

Including **population data** enables two important filters: 

1. **Eliminating cities too small** for stable estimates
2. Prioritizing cities based on impact potential. 

Both **TotalPopulation** and **TotalPop18plus** were included to allow flexibility, but only **TotalPopulation** was ultimately used for filtering.

---

## Step 3: Benchmarking and Final Filtering (Google Sheets)
**Objective:** Finalize the dataset for visualization by highlighting indicator-specific patterns and narrowing the focus to reliable, actionable city-level data in Texas. 

**Process:**
The following refinements were completed in **Google Sheets:**
1. Applied **conditional formatting** to each indicator column (Obesity, Diabetes, Smoking, Depression) based on the corresponding **national average** (calculated in SQL):
   * Cells with values above the national average were highlighted:
     * Obesity → light orange
     * Diabetes → light blue
     * Smoking → light red
     * Depression → light purple
2. Filtered the dataset to include only:
   * Cities located in **Texas**
   * Cities with **TotalPopulation > 500**

**Rationale:**

Comparing cities to national benchmarks for each indicator highlights specific areas of concern and helps prioritize intervention efforts. Cities with high HBI and multiple elevated indicators can be flagged for urgent attention. These visual cues make the dashboard immediately actionable even without technical background.

Limiting the dataset to **Texas cities with >500 residents** improves interpretability and reduces statistical noise from sparsely populated locations, ensuring that the final visualization is grounded in stable and policy-relevant data.

---

## Step 4: Visualization and Storytelling (Tableau)
**Objective:** Build an interactive, map-based dashboard to help stakeholders easily explore and compare city-level Health Burden Index (HBI) patterns across Texas.

**Process:** Using the finalized and filtered Google Sheets export, the following steps were completed in **Tableau Public:**

1. Uploaded the cleaned dataset with Texas cities (population > 500) and geolocation coordinates.
2. Created a **choropleth-style map** of Texas using latitude and longitude fields from the original dataset.
3. Used **color encoding** to represent HBI categories:
   * Red for High (HBI ≥ 30)
   * Yellow for Moderate (20-29.99)
   * Green for Low (< 20)
4. Customized map tooltips to display city name, HBI, and all four health indicator values.
5. Applied label visibility logic to emphasize **only High HBI cities,** reducing clutter and focusing attention.
6. Published the dashboard with clear legends and interactive hover features.

**Rationale:**

A geographic visualization enables intuitive exploration of spatial disparities in health burden. By categorizing cities visually, the map allows public health professionals, policymakers, and community leaders to identify problem areas quickly. Showing the four individual indicators in the tooltip also preserves analytic depth without overwhelming the map interface.

Labeling **only High HBI** cities was a deliberate design choice to prevent visual overload while still allowing users to explore all cities via hover interactions.

---

## Limitations and Design Considerations
* The **CDC PLACES dataset is model-based,** meaning prevalence estimates are not directly observed but derived from statistical modeling. Estimates may not capture hyperlocal variation or effects from recent interventions.
* The HBI is a **custom metric,** not a CDC-provided field. While it aggregates four validated indicators, it is not an official index and should be interpreted accordingly.
* Cities with **population < 500** were excluded to avoid statistical noise in small-area estimates and improve clarity in the visualization.
* The project used **2022 BRFSS-based model estimates** from the [2024 PLACES Local release](../data/dataset_link.md). Measures such as high blood pressure were excluded as they were based on 2021 BRFSS data in this release cycle.
* Geolocation fields were used as-is from the dataset, **no manual geocoding or correction was applied.**
* **Google Sheets** was used for lightweight analysis.For more advanced statistical modeling or time-series comparisons, a tool like Python or R would be more suitable.

