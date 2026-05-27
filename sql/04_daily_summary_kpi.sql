-- KPI Analysis: Summary Statistics Dashboard
SELECT 
  member_casual AS user_type,
  
  -- Format text labels based on European ISO standard (Starting with Monday)
  CASE day_of_week
    WHEN 1 THEN '1. Monday'
    WHEN 2 THEN '2. Tuesday'
    WHEN 3 THEN '3. Wednesday'
    WHEN 4 THEN '4. Thursday'
    WHEN 5 THEN '5. Friday'
    WHEN 6 THEN '6. Saturday'
    WHEN 7 THEN '7. Sunday'
  END AS day_of_week_label,
  
  COUNT(ride_id) AS total_trips,
  FORMAT_TIME('%H:%M:%S', TIME_ADD(TIME(0, 0, 0), INTERVAL CAST(ROUND(AVG(ride_length_seconds)) AS INT64) SECOND)) AS average_duration_HH_MM_SS,
  FORMAT_TIME('%H:%M:%S', TIME_ADD(TIME(0, 0, 0), INTERVAL MAX(ride_length_seconds) SECOND)) AS max_duration_HH_MM_SS

FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_enhanced`
GROUP BY 
  user_type,
  day_of_week,
  day_of_week_label
ORDER BY 
  user_type ASC, 
  day_of_week ASC;