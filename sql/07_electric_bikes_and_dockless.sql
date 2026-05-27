-- Behavioral Analysis: Electric Bikes and Dockless / Free-Floating Flexibility
WITH Prepared_Data AS (
  -- Step 1: Extract data and map historical timeline anomalies at the source
  SELECT 
    CASE 
      WHEN FORMAT_TIMESTAMP('%Y-%m', CAST(started_at AS TIMESTAMP)) = '2025-04' THEN '2025-05'
      ELSE FORMAT_TIMESTAMP('%Y-%m', CAST(started_at AS TIMESTAMP))
    END AS ride_month,
    rideable_type,
    member_casual,
    start_station_name,
    end_station_name,
    end_lat
  FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_enhanced`
)

SELECT 
  IFNULL(ride_month, 'ANNUAL TOTAL') AS month,
  
  -- 1. General Electric Bike Volumes
  COUNT(CASE WHEN rideable_type = 'electric_bike' THEN 1 END) AS electric_total,
  
  COUNT(CASE WHEN rideable_type = 'electric_bike' AND member_casual = 'member' THEN 1 END) AS electric_member,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'electric_bike' AND member_casual = 'member' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'electric_bike' THEN 1 END), 0), 2), ' %') AS member_electric_percentage,
  
  COUNT(CASE WHEN rideable_type = 'electric_bike' AND member_casual = 'casual' THEN 1 END) AS electric_casual,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'electric_bike' AND member_casual = 'casual' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'electric_bike' THEN 1 END), 0), 2), ' %') AS casual_electric_percentage,
  
  -- 2. Free-Floating Street Station Starts (Dockless Start)
  COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' THEN 1 END) AS electric_dockless_start_total,
  
  COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND member_casual = 'member' THEN 1 END) AS electric_dockless_start_member,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND member_casual = 'member' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' THEN 1 END), 0), 2), ' %') AS member_dockless_start_percentage,
  
  COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND member_casual = 'casual' THEN 1 END) AS electric_dockless_start_casual,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND member_casual = 'casual' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' THEN 1 END), 0), 2), ' %') AS casual_dockless_start_percentage,
  
  -- 3. Fully Free-Floating Trips (Dockless Start + Dockless End)
  COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND end_station_name = 'Dockless / On-Street End' THEN 1 END) AS electric_fully_dockless_total,
  
  COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND end_station_name = 'Dockless / On-Street End' AND member_casual = 'member' THEN 1 END) AS electric_fully_dockless_member,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND end_station_name = 'Dockless / On-Street End' AND member_casual = 'member' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND end_station_name = 'Dockless / On-Street End' THEN 1 END), 0), 2), ' %') AS member_fully_dockless_percentage,
  
  COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND end_station_name = 'Dockless / On-Street End' AND member_casual = 'casual' THEN 1 END) AS electric_fully_dockless_casual,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND end_station_name = 'Dockless / On-Street End' AND member_casual = 'casual' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND end_station_name = 'Dockless / On-Street End' THEN 1 END), 0), 2), ' %') AS casual_fully_dockless_percentage,
  
  -- Missing GPS Coordinates tracking on Fully Dockless Streams
  COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND end_station_name = 'Dockless / On-Street End' AND end_lat IS NULL THEN 1 END) AS fully_dockless_missing_gps_total,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND end_station_name = 'Dockless / On-Street End' AND end_lat IS NULL THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'electric_bike' AND start_station_name = 'Dockless / On-Street Start' AND end_station_name = 'Dockless / On-Street End' THEN 1 END), 0), 2), ' %') AS fully_dockless_missing_gps_percentage,

  -- 4. Free-Floating Street Station Ends (Dockless End)
  COUNT(CASE WHEN rideable_type = 'electric_bike' AND end_station_name = 'Dockless / On-Street End' THEN 1 END) AS electric_dockless_end_total,
  
  COUNT(CASE WHEN rideable_type = 'electric_bike' AND end_station_name = 'Dockless / On-Street End' AND member_casual = 'member' THEN 1 END) AS electric_dockless_end_member,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'electric_bike' AND end_station_name = 'Dockless / On-Street End' AND member_casual = 'member' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'electric_bike' AND end_station_name = 'Dockless / On-Street End' THEN 1 END), 0), 2), ' %') AS member_dockless_end_percentage,
  
  COUNT(CASE WHEN rideable_type = 'electric_bike' AND end_station_name = 'Dockless / On-Street End' AND member_casual = 'casual' THEN 1 END) AS electric_dockless_end_casual,
  CONCAT(ROUND((COUNT(CASE WHEN rideable_type = 'electric_bike' AND end_station_name = 'Dockless / On-Street End' AND member_casual = 'casual' THEN 1 END) * 100.0) / NULLIF(COUNT(CASE WHEN rideable_type = 'electric_bike' AND end_station_name = 'Dockless / On-Street End' THEN 1 END), 0), 2), ' %') AS casual_dockless_end_percentage

FROM Prepared_Data
GROUP BY ROLLUP(ride_month)
ORDER BY (month = 'ANNUAL TOTAL') ASC, month ASC;