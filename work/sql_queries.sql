WITH filtered_indicators AS (
  SELECT
    StateAbbr,
    StateDesc,
    LocationName,
    MeasureId,
    Data_Value AS Value,
    Geolocation,
    LocationID
  FROM
    places-564877.place.placelocal
  WHERE
    Year = 2022
    AND MeasureId In ('OBESITY', 'DIABETES', 'CSMOKING', 'DEPRESSION')
    AND Data_Value IS NOT NULL
    AND Data_Value_Type = 'Crude prevalence'
)
, pivoted_data AS(
  SELECT
    StateAbbr,
    StateDesc,
    LocationName,
    LocationId,
    Geolocation,
    MAX(CASE WHEN MeasureId = 'OBESITY' THEN Value END) AS Obesity,
    MAX(CASE WHEN MeasureId = 'DIABETES' THEN Value END) AS Diabetes,
    MAX(CASE WHEN MeasureId = 'CSMOKING' THEN Value END) AS Smoking,
    MAX(CASE WHEN MeasureId = 'DEPRESSION' THEN Value END) AS Depression
  FROM
    filtered_indicators
  GROUP BY 
    StateAbbr, StateDesc, LocationName, LocationID, Geolocation
)
SELECT 
  *,
  ROUND ((Obesity + Diabetes + Smoking + Depression) / 4, 2) AS Health_Burden_Index
FROM
  pivoted_data
ORDER BY
  Health_Burden_Index DESC
