-- Count of patients by readmission category
SELECT readmitted, COUNT(*) as count
FROM diabetic_data
GROUP BY readmitted
ORDER BY count DESC;

-- Overall 30-day readmission rate
SELECT 
    ROUND(100.0 * COUNT(CASE WHEN readmitted = '<30' THEN 1 END) / COUNT(*), 2) AS readmission_rate_pct
FROM diabetic_data;

SELECT
	age,
	COUNT(*) AS total_patients,
	COUNT(CASE WHEN readmitted = '<30' THEN 1 END) AS readmitted_30,
	ROUND(100.0 * COUNT(CASE WHEN readmitted = '<30' THEN 1 END) / COUNT(*), 2) AS readmisson_rate_pct
FROM diabetic_data
GROUP BY age
ORDER BY age;

SELECT
	gender,
	COUNT(*) AS total_patients,
	COUNT(CASE WHEN readmitted = '<30' THEN 1 END) AS readmitted_30,
	ROUND(100.0 * COUNT(CASE WHEN readmitted = '<30' THEN 1 END) / COUNT(*), 2) AS readmission_rate_pct
FROM diabetic_data
GROUP BY gender
ORDER BY readmission_rate_pct DESC;