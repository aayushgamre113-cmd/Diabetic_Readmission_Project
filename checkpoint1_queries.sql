-- Count of patients by readmission category
SELECT readmitted, COUNT(*) as count
FROM diabetic_data
GROUP BY readmitted
ORDER BY count DESC;

-- Overall 30-day readmission rate
SELECT 
    ROUND(100.0 * COUNT(CASE WHEN readmitted = '<30' THEN 1 END) / COUNT(*), 2) AS readmission_rate_pct
FROM diabetic_data;

-- Count of patients by age category--
SELECT
	age,
	COUNT(*) AS total_patients,
	COUNT(CASE WHEN readmitted = '<30' THEN 1 END) AS readmitted_30,
	ROUND(100.0 * COUNT(CASE WHEN readmitted = '<30' THEN 1 END) / COUNT(*), 2) AS readmisson_rate_pct
FROM diabetic_data
GROUP BY age
ORDER BY age;

-- Count of patients by gender category. Shows a unknown/invalid row implicating the data is not recorded properly--
SELECT
	gender,
	COUNT(*) AS total_patients,
	COUNT(CASE WHEN readmitted = '<30' THEN 1 END) AS readmitted_30,
	ROUND(100.0 * COUNT(CASE WHEN readmitted = '<30' THEN 1 END) / COUNT(*), 2) AS readmission_rate_pct
FROM diabetic_data
GROUP BY gender
ORDER BY readmission_rate_pct DESC;
-- Also DESC is use for the order, ascending or descending--

-- Count of inpatients and observing what it shows--
SELECT 
	number_inpatient,
	COUNT(*) AS total_patients,
	COUNT(CASE WHEN readmitted = '<30' THEN 1 END) AS readmitted_30,
	ROUND(100.0 * COUNT(CASE WHEN readmitted = '<30' THEN 1 END) / COUNT(*), 2) AS readmission_rate_pct
FROM diabetic_data
GROUP BY number_inpatient
ORDER BY number_inpatient;

-- CTE's (Common table expression) example --
WITH risk_flag AS (
    SELECT 
        encounter_id,
        number_inpatient,
        readmitted,
        CASE 
            WHEN number_inpatient >= 2 THEN 'High Prior Utilization'
            ELSE 'Low Prior Utilization'
        END AS utilization_risk
    FROM diabetic_data
)
SELECT 
    utilization_risk,
    COUNT(*) AS total_patients,
    COUNT(CASE WHEN readmitted = '<30' THEN 1 END) AS readmitted_30,
    ROUND(100.0 * COUNT(CASE WHEN readmitted = '<30' THEN 1 END) / COUNT(*), 2) AS readmission_rate_pct
FROM risk_flag
GROUP BY utilization_risk;

-- How Partition works, similar to group by but with a change that it shows all the data instead of summarising it --
SELECT 
    patient_nbr,
    encounter_id,
    readmitted,
    ROW_NUMBER() OVER (PARTITION BY patient_nbr ORDER BY encounter_id) AS visit_number
FROM diabetic_data
ORDER BY patient_nbr
LIMIT 20;

-- Using DESC to give the ranking a descending order --
SELECT 
    patient_nbr,
    encounter_id,
    readmitted,
    ROW_NUMBER() OVER (PARTITION BY patient_nbr ORDER BY encounter_id) AS visit_number
FROM diabetic_data
ORDER BY patient_nbr
LIMIT 20;