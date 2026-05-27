/* Financial Argument Analysis: Ride Duration Distribution

The primary incentive for a casual rider to convert to an annual membership is cost efficiency. 
If a Casual rider frequently takes very long trips (where single-ride or day-pass pricing becomes highly expensive), 
they represent the perfect target audience for conversion.

Trips are segmented into time brackets to analyze the percentage of Casual riders taking trips over 30 or 60 minutes.
*/

SELECT 
  member_casual AS user_type,
  CASE 
    WHEN ride_length_seconds < 900 THEN '1. Short (0-15 min)'
    WHEN ride_length_seconds BETWEEN 900 AND 1799 THEN '2. Medium (15-30 min)'
    WHEN ride_length_seconds BETWEEN 1800 AND 3599 THEN '3. Long (30-60 min)'
    ELSE '4. Very Long (60+ min)'
  END AS duration_category,
  COUNT(ride_id) AS total_trips
FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_enhanced`
GROUP BY 
  user_type, 
  duration_category
ORDER BY 
  user_type ASC, 
  duration_category ASC;