/*
===============================================================================
Script: 03_data_enrichment.sql
Description: Feature engineering and data enrichment process.
             This script creates an enhanced table by adding critical time-based 
             metrics required for the upcoming statistical analysis:
             - Formatted ride length (HH:MM:SS) for descriptive reporting.
             - Raw ride length in seconds to enable mathematical calculations.
             - Custom day of the week mapping aligned with standard calendar views.
===============================================================================
*/

CREATE OR REPLACE TABLE `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_enhanced` AS

SELECT 
  *,
  -- Feature Engineering: Calculate ride duration formatted as HH:MM:SS for presentation layers
  FORMAT_TIME('%H:%M:%S', TIME_ADD(TIME(0, 0, 0), INTERVAL TIMESTAMP_DIFF(CAST(ended_at AS TIMESTAMP), CAST(started_at AS TIMESTAMP), SECOND) SECOND)) AS ride_length,
  
  -- Technical Metric: Store raw duration in seconds to facilitate statistical aggregates (e.g., AVG, MEDIAN)
  TIMESTAMP_DIFF(CAST(ended_at AS TIMESTAMP), CAST(started_at AS TIMESTAMP), SECOND) AS ride_length_seconds,
  
  -- Feature Engineering: Extract day of the week, adjusted to European standard (1 = Monday, 7 = Sunday)
  MOD(EXTRACT(DAYOFWEEK FROM CAST(started_at AS TIMESTAMP)) + 5, 7) + 1 AS day_of_week

FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_clean`;