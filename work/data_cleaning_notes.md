# Data Cleaning Notes

## 1. Data Source
**Dataset**: CDC PLACES Local Data – 2024 Release

**Geographic unit**: City/Place Level

**Year**: 2022

**Used only rows with Data_Value_Type** = 'Crude Prevalence'

## 2. Initial Filtering via SQL
Selected 4 indicators for the Health Burden Index:
* Obesity (OBESITY)
* Diabetes (DIABETES)
* Smoking (CSMOKING)
* Depression (DEPRESSION)

Filtered for:
* Only 2022 data
* Only rows where Data_Value IS NOT NULL

## 3. Data Pivot and Index Creation
Used CASE WHEN statements in SQL to pivot the selected indicators.

Calculated Health_Burden_Index = average of the 4 indicators.

Created a Health_Level bucket:
* High (≥ 30)
* Moderate (20 to < 30)
* Low (< 20)

## 4. Joined Population Data
Extracted a separate table with TotalPopulation by city.

Used VLOOKUP in Google Sheets to join population data into the HBI table.

Filtered out cities with population < 500 to remove extremely small rural areas.

## 5. Formatting in Google Sheets
Ensured consistent number formatting (1–2 decimal places).

Applied filters to allow exploratory sorting (by state, city, indicator, etc.).

Conditional formatting:
* Health Level colors: Green (Low), Yellow (Moderate), Red (High)
* Highlighted values above national averages

## 6. Exported Clean Dataset
Filtered final table to only include Texas cities with population ≥ 500.

Exported to .xlsx and used that for Tableau mapping.

