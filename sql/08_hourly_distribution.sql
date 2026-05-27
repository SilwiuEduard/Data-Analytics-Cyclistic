-- Behavioral Analysis: Hourly Distribution (Members vs Casual Riders)
SELECT 
  EXTRACT(HOUR FROM CAST(started_at AS TIMESTAMP)) AS ride_hour,
  member_casual AS user_type,
  COUNT(ride_id) AS total_trips
FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_enhanced`
GROUP BY 
  ride_hour, 
  user_type
ORDER BY 
  ride_hour ASC, 
  user_type ASC;
