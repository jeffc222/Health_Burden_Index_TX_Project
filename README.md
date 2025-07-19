# Health Burden Index for Texas Cities (CDC PLACES Data, 2024 Release)
### Disclaimer
This dataset contains model-based place (incorporated and census-designated places) estimates. PLACES covers the entire United States—50 states and the District of Columbia—at county, place, census tract, and ZIP Code Tabulation Area levels. It provides information uniformly on this large scale for local areas at four geographic levels. Estimates were provided by the Centers for Disease Control and Prevention (CDC), Division of Population Health, Epidemiology and Surveillance Branch. PLACES was funded by the Robert Wood Johnson Foundation in conjunction with the CDC Foundation. The dataset includes estimates for 40 measures: 12 for health outcomes, 7 for preventive services use, 4 for chronic disease-related health risk behaviors, 7 for disabilities, 3 for health status, and 7 for health-related social needs. These estimates can be used to identify emerging health problems and to help develop and carry out effective, targeted public health prevention activities. Because the small area model cannot detect effects due to local interventions, users are cautioned against using these estimates for program or policy evaluations. Data sources used to generate these model-based estimates are Behavioral Risk Factor Surveillance System (BRFSS) 2022 or 2021 data, Census Bureau 2020 population data, and American Community Survey 2018–2022 estimates. The 2024 release uses 2022 BRFSS data for 36 measures and 2021 BRFSS data for 4 measures (high blood pressure, high cholesterol, cholesterol screening, and taking medicine for high blood pressure control among those with high blood pressure) that the survey collects data on every other year. More information about the methodology can be found at www.cdc.gov/places.

## Overview
This project analyzes city-level health burdens across Texas using the **CDC PLACES Local 2024 dataset**, which is based on 2022 BRFSS data. A custom **Health Burden Index (HBI)** was developed to assess the combined impact of four key health indicators: **obesity**, **diabetes**, **smoking**, and **depression**.

The goal is to identify cities with the highest health burden and explore patterns that can inform public health priorities and interventions.

> ⚠️ **Note**: The full dataset exceeds GitHub’s 25MB upload limit and is therefore not included in this repository. You can access it directly from the [CDC Data Portal](https://data.cdc.gov/500-Cities-Places/PLACES-Local-Data-for-Better-Health-Place-Data-202/eav7-hnsx/about_data). 

# Objective
To identify and compare cities in Texas based on a calculated health burden score. This allows:
* Insight into local health disparities
* Visual exploration of geographic health risk clusters
* Foundation for combining with future trend analysis (Project 2) and model validation (Project 3)

# Tools and Technologies
* SQL (BigQuery): Data cleaning, filtering, and calculation of Health Burden Index
* Google Sheets: Lookup, formatting, and simple visualization
* Tableau Public: Geospatial mapping and dashboard visualization
* GitHub: Documentation and project portfolio

