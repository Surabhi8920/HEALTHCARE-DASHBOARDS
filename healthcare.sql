create database healthcare;
use healthcare;




SELECT COUNT(*) FROM Patients;
SELECT COUNT(*) FROM Visits;
SELECT COUNT(*) FROM Treatments;
SELECT COUNT(*) FROM LabResult;
SELECT COUNT(*) FROM doctor;

SELECT * FROM Patients WHERE FirstName IS NULL OR LastName IS NULL;
SELECT * FROM Visits WHERE `Visit Type` IS NULL OR `Visit Date` IS NULL;
SELECT * FROM Treatments WHERE `Treatment Name` IS NULL OR `Status` IS NULL;
SELECT * FROM LabResult WHERE `Test Name` IS NULL OR Result IS NULL;

SELECT v.`Visit ID`, v.`Patient ID`, p.`Patient ID`
FROM Visits v
LEFT JOIN Patients p ON v.`Patient ID` = p.`Patient ID`
WHERE p.`Patient ID` IS NULL;

# Duplicate Records Check
 ##Patients with same ID more than 1 time
SELECT `Patient ID`, COUNT(*)
FROM Patients
GROUP BY `Patient ID`
HAVING COUNT(*) > 1;

-- Visits with same ID more than 1 time
SELECT `Visit ID`, COUNT(*)
FROM Visits
GROUP BY `Visit ID`
HAVING COUNT(*) > 1;

##Treatment Cost Total and Average Age
 #Dashboard Aggregation Check
 SELECT SUM(`Treatment Cost`) FROM Treatments;
SELECT ROUND(SUM(`Treatment Cost`), 2)
FROM Treatments;

SELECT Round(AVG(Age),2)  FROM Patients; 



###Full detailed table: patient + visit + doctor + treatment + lab result
SELECT 
    p.`Patient ID`, 
    p.FirstName, 
    p.LastName, 
    p.Age, 
    p.Gender, 
    p.City, 
    p.State, 
    p.Country,
    p.InsuranceProvider, 
    p.MedicalHistory, 
    p.Ethnicity, 
    p.MaritalStatus,
    v.`Visit ID`, 
    v.`Visit Date`, 
    v.`Visit Type`, 
    v.`Visit Status`, 
    v.`Reason For Visit`,
    d.`Doctor ID`, 
    t.`Treatment ID`, 
    t.`Treatment Type`, 
    t.`Treatment Name`, 
    t.`Status`, 
    t.`Treatment Cost`,
    l.`Lab Result ID`, 
    l.`Test Name`, 
    l.`Test Date`, 
    l.`Result`, 
    l.`Normal Range`, 
    l.`Units`
FROM 
    Patients p
JOIN 
    Visits v ON p.`Patient ID` = v.`Patient ID`
JOIN 
    Doctor d ON v.`Doctor ID` = d.`Doctor ID`
LEFT JOIN 
    Treatments t ON v.`Visit ID` = t.`Visit ID`
LEFT JOIN 
    LabResult l ON v.`Visit ID` = l.`Visit ID`
ORDER BY 
    v.`Visit Date` DESC;



##Patient Distribution Across USA (City Wise)
SELECT `City`, COUNT(DISTINCT `Patient ID`) AS Total_Patients
FROM Patients
GROUP BY `City`
ORDER BY Total_Patients DESC;

##Top Insurance Provider
SELECT InsuranceProvider, COUNT(*) AS Patients_Count
FROM Patients
GROUP BY InsuranceProvider
ORDER BY Patients_Count DESC
LIMIT 3;

###Age Group Distribution
#########(Based on Age range like Senior, Young Adult, etc.)
SELECT 
    CASE 
        WHEN `Age` >= 60 THEN 'Seniors'
        WHEN `Age` BETWEEN 36 AND 59 THEN 'Middle-aged Adults'
        WHEN `Age` BETWEEN 19 AND 35 THEN 'Young Adults'
        WHEN `Age` BETWEEN 13 AND 18 THEN 'Older Adolescents'
        ELSE 'Children & Adolescents'
    END AS Age_Group,
    COUNT(*) AS Total_Patients
FROM Patients
GROUP BY Age_Group;

##Most Ordered Lab Tests
SELECT 
    `Test Name`,
    COUNT(*) AS Total_Orders
FROM Labresult
GROUP BY `Test Name`
ORDER BY Total_Orders DESC
LIMIT 5;

SELECT `test name`, COUNT(*) AS total_tests
FROM labresult
WHERE result IN ('Normal', 'Abnormal')
GROUP BY `test name`;







