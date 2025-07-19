# Health Burden Index for Texas Cities (CDC PLACES Data, 2024 Release)
### Disclaimer
This dataset contains model-based place (incorporated and census-designated places) estimates. PLACES covers the entire United States—50 states and the District of Columbia—at county, place, census tract, and ZIP Code Tabulation Area levels. It provides information uniformly on this large scale for local areas at four geographic levels. Estimates were provided by the Centers for Disease Control and Prevention (CDC), Division of Population Health, Epidemiology and Surveillance Branch. PLACES was funded by the Robert Wood Johnson Foundation in conjunction with the CDC Foundation. The dataset includes estimates for 40 measures: 12 for health outcomes, 7 for preventive services use, 4 for chronic disease-related health risk behaviors, 7 for disabilities, 3 for health status, and 7 for health-related social needs. These estimates can be used to identify emerging health problems and to help develop and carry out effective, targeted public health prevention activities. Because the small area model cannot detect effects due to local interventions, users are cautioned against using these estimates for program or policy evaluations. Data sources used to generate these model-based estimates are Behavioral Risk Factor Surveillance System (BRFSS) 2022 or 2021 data, Census Bureau 2020 population data, and American Community Survey 2018–2022 estimates. The 2024 release uses 2022 BRFSS data for 36 measures and 2021 BRFSS data for 4 measures (high blood pressure, high cholesterol, cholesterol screening, and taking medicine for high blood pressure control among those with high blood pressure) that the survey collects data on every other year. More information about the methodology can be found at www.cdc.gov/places.

## Overview
This project analyzes city-level health burdens across Texas using the **CDC PLACES Local 2024 dataset**, which is based on 2022 BRFSS data. A custom **Health Burden Index (HBI)** was developed to assess the combined impact of four key health indicators: **obesity**, **diabetes**, **smoking**, and **depression**.

The goal is to identify cities with the highest health burden and explore patterns that can inform public health priorities and interventions.

> ⚠️ **Note**: The full dataset exceeds GitHub’s 25MB upload limit and is therefore not included in this repository. You can access it directly here (https://data.cdc.gov/d/eav7-hnsx).
>

(https://drive.google.com/file/d/1t7hzU7hbFb7OfXsaWgEGBpPhAGWN5lPH/view?usp=drive_link)


## 🧠 Project Objective
- Calculate a Health Burden Index for each city in Texas
- Visualize cities with high health burdens
- Provide insights and recommendations for public health planning
- Lay the foundation for future projects (statewide and national trend comparisons)

---

## ⚙️ Methodology

### 1. Data Cleaning & Filtering (SQL)
- Source: CDC PLACES Local 2024 data (2022)
- Selected Measures:
  - `OBESITY`: Obesity among adults
  - `DIABETES`: Diagnosed diabetes among adults
  - `CSMOKING`: Current smoking among adults
  - `DEPRESSION`: Depression among adults
- Filtered to Texas cities with population > 500
- Created a Health Burden Index = average of the 4 indicators

### 2. Data Formatting & Exploration (Google Sheets)
- Added population estimates using VLOOKUP
- Labeled cities by health burden level (High / Moderate / Low)
- Applied conditional formatting for quick visual scanning

### 3. Visualization (Tableau)
- Mapped all cities in Texas with geographic coordinates
- Applied color gradients by Health Burden Index
- Highlighted high-burden cities
- Annotated cities using labels and tooltips

https://data.cdc.gov/d/eav7-hnsx


---

## 📊 Key Insights

- Cities with the highest HBI are often smaller or mid-sized with limited population.
- Depression and obesity were consistent contributors in most high-burden cities.
- Urban centers generally had lower burden, but not always — highlighting disparities.

---

## ✅ Recommendations

- Prioritize health education and intervention efforts in identified **high-burden cities**.
- Support mental health infrastructure in regions with elevated depression rates.
- Encourage community-level data use to support targeted policy and funding.

