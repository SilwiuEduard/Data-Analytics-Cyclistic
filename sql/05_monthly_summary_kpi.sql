-- KPI Analysis: Monthly Summary Dashboard (Volume & Duration Trends)
WITH Monthly_Data AS (
  -- Step 1: Extract formatted month-year and exclude extraneous periods at the source
  SELECT 
    FORMAT_TIMESTAMP('%Y-%m', CAST(started_at AS TIMESTAMP)) AS calendar_month,
    ride_id,
    member_casual,
    ride_length_seconds
  FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_enhanced`
  WHERE FORMAT_TIMESTAMP('%Y-%m', CAST(started_at AS TIMESTAMP)) != '2025-04'
)

-- Step 2: Compute aggregated metrics and calculate percentage distributions
SELECT 
  IFNULL(calendar_month, 'ANNUAL TOTAL') AS month,
  
  -- Total trips volume per month
  COUNT(ride_id) AS total_trips,
  
  -- Member segment volumes and percentage shares
  COUNT(CASE WHEN member_casual = 'member' THEN 1 END) AS member_trips,
  CONCAT(ROUND((COUNT(CASE WHEN member_casual = 'member' THEN 1 END) * 100.0) / COUNT(ride_id), 2), ' %') AS member_percentage,
  
  -- Casual segment volumes and percentage shares
  COUNT(CASE WHEN member_casual = 'casual' THEN 1 END) AS casual_trips,
  CONCAT(ROUND((COUNT(CASE WHEN member_casual = 'casual' THEN 1 END) * 100.0) / COUNT(ride_id), 2), ' %') AS casual_percentage,
  
  -- Average ride lengths converted to minutes
  ROUND(AVG(CASE WHEN member_casual = 'member' THEN ride_length_seconds END) / 60, 2) AS avg_duration_member_minutes,
  ROUND(AVG(CASE WHEN member_casual = 'casual' THEN ride_length_seconds END) / 60, 2) AS avg_duration_casual_minutes

FROM Monthly_Data
GROUP BY ROLLUP(calendar_month)
ORDER BY (month = 'ANNUAL TOTAL') ASC, month ASC;