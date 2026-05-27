CREATE OR REPLACE TABLE `casestudy1-cyclistic-496910.case_study_1_cyclistic.cyclistic_master_2025_05_to_2026_04` AS

SELECT * FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.202505-divvy-tripdata`
UNION ALL
SELECT * FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.202506-divvy-tripdata`
UNION ALL
SELECT * FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.202507-divvy-tripdata`
UNION ALL
SELECT * FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.202508-divvy-tripdata`
UNION ALL
SELECT * FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.202509-divvy-tripdata`
UNION ALL
SELECT * FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.202510-divvy-tripdata`
UNION ALL
SELECT * FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.202511-divvy-tripdata`
UNION ALL
SELECT * FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.202512-divvy-tripdata`
UNION ALL
SELECT * FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.202601-divvy-tripdata`
UNION ALL
SELECT * FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.202602-divvy-tripdata`
UNION ALL
SELECT * FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.202603-divvy-tripdata`
UNION ALL
SELECT * FROM `casestudy1-cyclistic-496910.case_study_1_cyclistic.202604-divvy-tripdata`;