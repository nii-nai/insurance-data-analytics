-- Analyzing contributing factors of claim behaviour
-- BMI, Smoking, Age, Dependents, Salary

-- BMI needs data to be collected. Must recomend to Mgt

--Smoking status
SELECT ce.Smoker AS smoking_status,
       SUM(Claim_Amount_GHS) AS total_claim_amount,
       COUNT(Claim_ID) AS number_of_claims,
       AVG(Claim_Amount_GHS) AS avg_claim_amount
FROM insurance_dataset.claims AS cl
INNER JOIN insurance_dataset.covered_employees AS ce
ON cl.Employee_ID = ce.Employee_ID
GROUP BY smoking_status
ORDER BY total_claim_amount;


-- Claim type

SELECT cl.Claim_Type AS claim_type,
       SUM(Claim_Amount_GHS) AS total_claim_amount,
       COUNT(Claim_ID) AS number_of_claims,
       AVG(Claim_Amount_GHS) AS avg_claim_amount
FROM insurance_dataset.claims AS cl
GROUP BY Claim_Type
ORDER BY total_claim_amount;


-- Age vs Claim behaviour
SELECT 
      CASE WHEN ce.Age <= 25 THEN 'Young'
           WHEN ce.Age <= 50 THEN 'Middle Age'
                ELSE 'Old' END AS age_group,
      COUNT(cl.Claim_ID) AS total_claims,
      SUM(cl.Claim_Amount_GHS) AS claim_amount
FROM insurance_dataset.covered_employees AS ce
JOIN insurance_dataset.claims AS cl
     ON cl.Employee_ID = ce.Employee_ID
GROUP BY age_group
ORDER BY claim_amount DESC;

--Number of dependents vs claim behaviour
SELECT * FROM insurance_dataset.covered_employees;

SELECT
      ce.Dependents,
      COUNT(DISTINCT cl.Employee_ID) AS no_of_employees,
      COUNT(cl.Claim_ID) AS no_of_claims,
      SUM(cl.Claim_Amount_GHS) AS claim_amount
FROM insurance_dataset.covered_employees AS ce
INNER JOIN insurance_dataset.claims AS cl
     ON ce.Employee_ID = cl.Employee_ID
GROUP BY ce.Dependents
ORDER BY ce.Dependents, claim_amount;

-- Group salaries into levels
-- first find min and max salaries across grade levels
SELECT Grade_Level,
       MIN(Monthly_Salary_GHS) AS min_salary,
       MAX(Monthly_Salary_GHS) AS max_salary,
       AVG(Monthly_Salary_GHS) AS avg_salary
FROM `insurance_dataset.covered_employees`
GROUP BY Grade_Level
ORDER BY max_salary;

-- Grade_levels overlap with monthly_salary
-- ie. junior level could be earning higher than mid level and so on
-- Therefore need create agg based on salary ranges
SELECT 
    CASE 
        WHEN Monthly_Salary_GHS >= 3000 AND Monthly_Salary_GHS < 7500 THEN 'Junior'
        WHEN Monthly_Salary_GHS >= 7500 AND Monthly_Salary_GHS < 12500 THEN 'Mid'
        WHEN Monthly_Salary_GHS >= 12500 AND Monthly_Salary_GHS < 18000 THEN 'Senior'
        ELSE 'Executive'
    END AS Salary_Level,
    COUNT(ce.Employee_ID) AS Employee_Count,
    ROUND(AVG(cl.Claim_Amount_GHS), 2) AS Claim_Amount,
    ROUND(AVG(Monthly_Salary_GHS), 2) AS Average_Salary
FROM 
    insurance_dataset.covered_employees AS ce
INNER JOIN `insurance_dataset.claims` AS cl
      ON ce.Employee_ID = cl.Employee_ID
GROUP BY 
    CASE 
        WHEN Monthly_Salary_GHS >= 3000 AND Monthly_Salary_GHS < 7500 THEN 'Junior'
        WHEN Monthly_Salary_GHS >= 7500 AND Monthly_Salary_GHS < 12500 THEN 'Mid'
        WHEN Monthly_Salary_GHS >= 12500 AND Monthly_Salary_GHS < 18000 THEN 'Senior'
        ELSE 'Executive'
    END
;





-- Salary levels vs Claim behaviour

SELECT
      CASE WHEN ce.Monthly_Salary_GHS 
       AVG(ce.Monthly_Salary_GHS) AS avg_salary,
       COUNT(cl.Claim_ID) AS no_of_claims,
       SUM(cl.Claim_Amount_GHS) AS claim_amount,
       AVG(cl.Claim_Amount_GHS) AS avg_claim
FROM `insurance_dataset.covered_employees` AS ce
INNER JOIN `insurance_dataset.claims` AS cl
      ON ce.Employee_ID = cl.Employee_ID
GROUP BY ce.Monthly_Salary_GHS;


SELECT * FROM `insurance_dataset.covered_employees`;

SELECT * FROM `insurance_dataset.claims`;
