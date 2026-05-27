/*
===============================================================================
Script: 02_data_cleaning.sql
Description: Cleans the combined master dataset and applies business logic. 
             - Imputes missing station names/IDs based on rideable type.
             - Removes duplicate records using DISTINCT.
             - Excludes anomalous rides (duration < 60 seconds).
===============================================================================
*/

CREATE OR REPLACE TABLE `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_clean` AS

SELECT DISTINCT 
  -- Select all columns from the master table, excluding the ones being transformed below
  * EXCEPT(start_station_name, start_station_id, end_station_name, end_station_id),

  -- Business Rule 1: Handle NULL values for Start Stations
  -- Electric bikes can be unlocked anywhere (Dockless). Missing data for other types indicates a system error.
  CASE 
    WHEN start_station_name IS NULL OR start_station_name = '' THEN 
      CASE 
        WHEN rideable_type = 'electric_bike' THEN 'Dockless / On-Street Start'
        ELSE 'Unknown - System Error Start'
      END
    ELSE start_station_name
  END AS start_station_name,

  CASE 
    WHEN start_station_id IS NULL OR start_station_id = '' THEN 
      CASE 
        WHEN rideable_type = 'electric_bike' THEN 'DOCKLESS'
        ELSE 'ERROR_SYS'
      END
    ELSE start_station_id
  END AS start_station_id,

  -- Business Rule 2: Handle NULL values for End Stations
  -- Differentiates between dockless electric bikes, abandoned classic bikes, and system errors.
  CASE 
    WHEN end_station_name IS NULL OR end_station_name = '' THEN 
      CASE 
        WHEN rideable_type = 'electric_bike' THEN 'Dockless / On-Street End'
        WHEN rideable_type = 'classic_bike' THEN 'Abandoned / Auto-Closed'
        ELSE 'Unknown - System Error End'
      END
    ELSE end_station_name
  END AS end_station_name,

  CASE 
    WHEN end_station_id IS NULL OR end_station_id = '' THEN 
      CASE 
        WHEN rideable_type = 'electric_bike' THEN 'DOCKLESS'
        WHEN rideable_type = 'classic_bike' THEN 'ABANDONED'
        ELSE 'ERROR_SYS'
      END
    ELSE end_station_id
  END AS end_station_id

FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_master_2025_05_to_2026_04`

-- Business Rule 3: Filter out false starts and maintenance trips
-- Excludes rides with durations under 1 minute (60 seconds) as well as any negative durations
WHERE TIMESTAMP_DIFF(CAST(ended_at AS TIMESTAMP), CAST(started_at AS TIMESTAMP), SECOND) >= 60

-- Step 4: Sort results chronologically by start time
ORDER BY started_at ASC;