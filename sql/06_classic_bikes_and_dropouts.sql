-- Behavioral Analysis: Classic Bikes and System Dropouts / Abandonments
WITH Prepared_Data AS (
  -- Step 1: Extract months and structure data streams at the source
  SELECT 
    CASE 
      WHEN FORMAT_TIMESTAMP('%Y-%m', started_at) = '2025-04' THEN '2025-05'
      ELSE FORMAT_TIMESTAMP('%Y-%m', started_at) 
    END AS ride_month,
    rideable_type,
    member_casual,
    end_station_name,
    end_lat
  FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_enhanced`
  WHERE TRUE 
)

SELECT 
  IFNULL(ride_month, 'ANNUAL TOTAL') AS month,
  
  -- 1. General Classic Bike Volumes
  COUNT(CASE WHEN rideable_type = 'classic_bike' THEN 1 END) AS classic_total,
  
  COUNT(CASE WHEN rideable_type = 'classic_bike' AND member_casual = 'member' THEN 1 END) AS classic_member,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'classic_bike' AND member_casual = 'member' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'classic_bike' THEN 1 END), 0), 2), ' %') AS member_classic_percentage,
  
  COUNT(CASE WHEN rideable_type = 'classic_bike' AND member_casual = 'casual' THEN 1 END) AS classic_casual,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'classic_bike' AND member_casual = 'casual' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'classic_bike' THEN 1 END), 0), 2), ' %') AS casual_classic_percentage,
  
  -- 2. Abandonment Analysis
  COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' THEN 1 END) AS classic_abandoned_total,
  
  COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND member_casual = 'member' THEN 1 END) AS classic_abandoned_member,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND member_casual = 'member' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' THEN 1 END), 0), 2), ' %') AS member_abandon_percentage,
  
  COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND member_casual = 'casual' THEN 1 END) AS classic_abandoned_casual,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND member_casual = 'casual' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' THEN 1 END), 0), 2), ' %') AS casual_abandon_percentage,
  
  -- Behavioral Ratio (How many times more often do Casual riders abandon compared to Members)
  ROUND(
    COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND member_casual = 'casual' THEN 1 END) / 
    NULLIF(COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND member_casual = 'member' THEN 1 END), 0), 2
  ) AS casual_vs_member_abandon_ratio,

  -- 3. Correlation with Missing GPS Coordinates
  COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND end_lat IS NULL THEN 1 END) AS abandon_missing_gps_total,
  
  COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND end_lat IS NULL AND member_casual = 'member' THEN 1 END) AS abandon_missing_gps_member,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND end_lat IS NULL AND member_casual = 'member' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND end_lat IS NULL THEN 1 END), 0), 2), ' %') AS member_missing_gps_percentage,
  
  COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND end_lat IS NULL AND member_casual = 'casual' THEN 1 END) AS abandon_missing_gps_casual,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND end_lat IS NULL AND member_casual = 'casual' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'classic_bike' AND end_station_name = 'Abandoned / Auto-Closed' AND end_lat IS NULL THEN 1 END), 0), 2), ' %') AS casual_missing_gps_percentage

FROM Prepared_Data
GROUP BY ROLLUP(ride_month)
ORDER BY (month = 'ANNUAL TOTAL') ASC, month ASC;