-- Spatial Analysis: Top 15 Most Popular Start and End Stations for Casual Riders
WITH Top_Starts AS (
  SELECT 
    start_station_name AS station_name,
    COUNT(ride_id) AS casual_start_count,
    ROW_NUMBER() OVER (ORDER BY COUNT(ride_id) DESC) AS start_rank
  FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_enhanced`
  WHERE 
    member_casual = 'casual' 
    AND start_station_name NOT IN ('Dockless / On-Street Start', 'Unknown - System Error Start')
  GROUP BY start_station_name
  QUALIFY start_rank <= 15
),

Top_Ends AS (
  SELECT 
    end_station_name AS station_name,
    COUNT(ride_id) AS casual_end_count,
    ROW_NUMBER() OVER (ORDER BY COUNT(ride_id) DESC) AS end_rank
  FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_enhanced`
  WHERE 
    member_casual = 'casual' 
    AND end_station_name NOT IN ('Dockless / On-Street End', 'Unknown - System Error End')
  GROUP BY end_station_name
  QUALIFY end_rank <= 15
)

SELECT 
  s.start_rank AS rank_position,
  s.station_name AS top_15_start_station,
  s.casual_start_count AS start_trips_count,
  e.station_name AS top_15_end_station,
  e.casual_end_count AS end_trips_count
FROM Top_Starts s
FULL OUTER JOIN Top_Ends e 
  ON s.start_rank = e.end_rank
ORDER BY rank_position ASC;