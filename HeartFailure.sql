SELECT *
 FROM `singular-backup-336021.HeartDisease.HeartFailure` 

--Lets See The Correlation Between Heart Failure and The Age
WITH T
AS 
(
SELECT 
CASE 
 WHEN AGE Between 20 AND 30 THEN 'Youth(20-30)'
 WHEN AGE BETWEEN 30 AND 50 THEN 'MiddleAge(30-45)'
 WHEN AGE BETWEEN 50 AND 70 THEN 'Old(45-60)'
 WHEN AGE BETWEEN 70 AND 80 THEN 'LateOld(60-80)'
 END AS AgeDescription
FROM `singular-backup-336021.HeartDisease.HeartFailure`
--WHERE HeartDisease = 1
)
SELECT *, COUNT(AgeDescription) AS COUNT,ROUND( COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
FROM T
GROUP BY 1
ORDER BY Count DESC 

 --We get from this query that heart failure increases by aging and the decrease again after 60s.

 --Lets see if Gender affects heart or not

 SELECT sex,count(*) AS TotalCount ,ROUND( COUNT(*) * 100 /SUM(COUNT(*)) OVER (),0) AS PERC
 FROM 
 `singular-backup-336021.HeartDisease.HeartFailure`
 GROUP BY Sex 
 ORDER BY 2

-- Males are almost 4 times subjected to heart failure compared to females.

--Types of chest pain
SELECT ChestPainType,COUNT(ChestPainType) AS Numberofcases, ROUND(COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
FROM `singular-backup-336021.HeartDisease.HeartFailure`
GROUP BY 1
ORDER BY 3 DESC
 
--ASY (asymptomatic) chest pain is most likely related to heart disease 
--Its almost 5.8,2.7,2.3 to typical angina,atypical angina and non anginal pain respectively

--Lets See If Blood Pressure(BP) is assoicated with heart failure or not

SELECT 
CASE
WHEN RestingBP Between 0 AND 120 THEN 'Normal'
WHEN RestingBP Between 120 AND 129 THEN 'Elevated' 
WHEN RestingBP Between 129 AND 140 THEN 'HypertensionI'
WHEN RestingBP BETWEEN 140 AND 200 THEN 'HypertensionII'
END AS BP
,COUNT(RestingBP)AS NumCases,ROUND( COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
 FROM `singular-backup-336021.HeartDisease.HeartFailure`
 GROUP BY 1
 ORDER BY 3 DESC 

 -- We can say that Hypertension is asscoiated with Heart Failure but it will not differ much than the normal.

-- Blood sugar effect
SELECT COUNT(FastingBS) AS Cases,ROUND(COUNT(*) *100 /SUM(COUNT(*)) over(),2) as PERC,
CASE
WHEN FastingBS = 1 THEN 'Y'
WHEN FastingBS = 0 THEN 'N'
END AS BS
 FROM `singular-backup-336021.HeartDisease.HeartFailure`
-- WHERE HeartDisease = 1
 GROUP BY 3

 --Most of the cases are not Asscoiated with Blood sugar.

--Cholesterols effect
SELECT 
CASE
WHEN  Cholesterol <=200 Then 'Normal'
WHEN  Cholesterol Between 200 AND 239 Then 'Borderline'
WHEN Cholesterol >=240 THEN 'High'
END AS Cholesterol
,COUNT(Cholesterol)AS NumCases,ROUND( COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
 FROM `singular-backup-336021.HeartDisease.HeartFailure`
 --WHERE HeartDisease = 1
 GROUP BY 1
 ORDER BY 3 DESC

--Higher cholesterol levels lead to a higher risk of having heart disease.
-- However, the ratio between each cholesterol level is not significantly different.

--Max Heart Rate Relation to Heart Failure
SELECT 
CASE
WHEN  MaxHR <=95 Then 'Normal'
WHEN  MaxHR Between 96 AND 125 Then 'Above Normal'
WHEN  MaxHR Between 126 AND 155 Then 'Slightly High'
WHEN  MaxHR Between 156 AND 185 Then ' High'
WHEN MaxHR >=185 THEN 'Extreme'
END AS MaxHR
,COUNT(MaxHR)AS NumCases,ROUND( COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
 FROM `singular-backup-336021.HeartDisease.HeartFailure`
 
 GROUP BY 1
 ORDER BY 3 DESC

 -- Max HR gets higher, the case of heart disease is getting lower; 
 --the chance is higher if maxHR is <=95 than >=185.

 --Are Exercises stimulates Angina?
 SELECT COUNT(ExerciseAngina) AS Cases, ExerciseAngina,ROUND(COUNT(*) *100/ SUM(COUNT(*)) OVER(),2) AS PERC 
  FROM `singular-backup-336021.HeartDisease.HeartFailure`
  WHERE HeartDisease = 1
  GROUP BY 2
  ORDER BY 1 DESC

--Exercises Stimulates Angina Only If the Patient has Already Heart Disease 

--Comparison Between if the patient has Heart Disease vs no previous heart disease(history)
In All Attributes
--AGE (Heart disease)
--Lets See The Correlation Between Heart Failure and The Age
WITH T
AS 
(
SELECT 
CASE 
 WHEN AGE Between 20 AND 30 THEN 'Youth(20-30)'
 WHEN AGE BETWEEN 30 AND 50 THEN 'MiddleAge(30-45)'
 WHEN AGE BETWEEN 50 AND 70 THEN 'Old(45-60)'
 WHEN AGE BETWEEN 70 AND 80 THEN 'LateOld(60-80)'
 END AS AgeDescription
FROM `singular-backup-336021.HeartDisease.HeartFailure`
WHERE HeartDisease = 1
)
SELECT *, COUNT(AgeDescription) AS COUNT,ROUND( COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
FROM T
GROUP BY 1
ORDER BY Count DESC
--Old adults with previous heart disease are subjected more to heart failure

--(no Heart disease)

WITH T
AS 
(
SELECT 
CASE 
 WHEN AGE Between 20 AND 30 THEN 'Youth(20-30)'
 WHEN AGE BETWEEN 30 AND 50 THEN 'MiddleAge(30-45)'
 WHEN AGE BETWEEN 50 AND 70 THEN 'Old(45-60)'
 WHEN AGE BETWEEN 70 AND 80 THEN 'LateOld(60-80)'
 END AS AgeDescription
FROM `singular-backup-336021.HeartDisease.HeartFailure`
WHERE HeartDisease = 0
)
SELECT *, COUNT(AgeDescription) AS COUNT,ROUND( COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
FROM T
GROUP BY 1
ORDER BY Count DESC
--There is slightly difference between middle age and old 

--Gender
SELECT sex,count(*) AS TotalCount ,ROUND( COUNT(*) * 100 /SUM(COUNT(*)) OVER (),0) AS PERC
 FROM 
 `singular-backup-336021.HeartDisease.HeartFailure`
 WHERE HeartDisease = 1
 GROUP BY Sex 
 ORDER BY 2
(no Heart disease)
SELECT sex,count(*) AS TotalCount ,ROUND( COUNT(*) * 100 /SUM(COUNT(*)) OVER (),0) AS PERC
 FROM 
 `singular-backup-336021.HeartDisease.HeartFailure`
 WHERE HeartDisease = 0
 GROUP BY Sex 
 ORDER BY 2
--Same results

--Types of chest pain
SELECT ChestPainType,COUNT(ChestPainType) AS Numberofcases, ROUND(COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
FROM `singular-backup-336021.HeartDisease.HeartFailure`
WHERE HeartDisease = 1
GROUP BY 1
ORDER BY 3 DESC
--Most Common Types ASY,NAP,ATA and TA
--(No Heart disease)
SELECT ChestPainType,COUNT(ChestPainType) AS Numberofcases, ROUND(COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
FROM `singular-backup-336021.HeartDisease.HeartFailure`
WHERE HeartDisease = 0
GROUP BY 1
ORDER BY 3 DESC
---Most Common Types ATA,NAP,ASY and TA
--BP(heart Disease)
SELECT 
CASE
WHEN RestingBP Between 0 AND 120 THEN 'Normal'
WHEN RestingBP Between 120 AND 129 THEN 'Elevated' 
WHEN RestingBP Between 129 AND 140 THEN 'HypertensionI'
WHEN RestingBP BETWEEN 140 AND 200 THEN 'HypertensionII'
END AS BP
,COUNT(RestingBP)AS NumCases,ROUND( COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
 FROM `singular-backup-336021.HeartDisease.HeartFailure`
 WHERE HeartDisease = 1
 GROUP BY 1
 ORDER BY 3 DESC 
 --Most Common Hyper TensionI,II 
--(No Heart Disease)
SELECT 
CASE
WHEN RestingBP Between 0 AND 120 THEN 'Normal'
WHEN RestingBP Between 120 AND 129 THEN 'Elevated' 
WHEN RestingBP Between 129 AND 140 THEN 'HypertensionI'
WHEN RestingBP BETWEEN 140 AND 200 THEN 'HypertensionII'
END AS BP
,COUNT(RestingBP)AS NumCases,ROUND( COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
 FROM `singular-backup-336021.HeartDisease.HeartFailure`
 WHERE HeartDisease = 0
 GROUP BY 1
 ORDER BY 3 DESC
 --Same results as overall cases
 -- Blood sugar effect(heart disease)
SELECT COUNT(FastingBS) AS Cases,ROUND(COUNT(*) *100 /SUM(COUNT(*)) over(),2) as PERC,
CASE
WHEN FastingBS = 1 THEN 'Y'
WHEN FastingBS = 0 THEN 'N'
END AS BS
 FROM `singular-backup-336021.HeartDisease.HeartFailure`
 WHERE HeartDisease = 1
 GROUP BY 3
 --It has no effect on heartfailure
 --(No Heart Disease)
SELECT COUNT(FastingBS) AS Cases,ROUND(COUNT(*) *100 /SUM(COUNT(*)) over(),2) as PERC,
CASE
WHEN FastingBS = 1 THEN 'Y'
WHEN FastingBS = 0 THEN 'N'
END AS BS
 FROM `singular-backup-336021.HeartDisease.HeartFailure`
WHERE HeartDisease = 0
 GROUP BY 3

--Cholesterols (with heart disease)
SELECT 
CASE
WHEN  Cholesterol <=200 Then 'Normal'
WHEN  Cholesterol Between 200 AND 239 Then 'Borderline'
WHEN Cholesterol >=240 THEN 'High'
END AS Cholesterol
,COUNT(Cholesterol)AS NumCases,ROUND( COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
 FROM `singular-backup-336021.HeartDisease.HeartFailure`
 WHERE HeartDisease = 1
 GROUP BY 1
 ORDER BY 3 DESC
--No effect
--no heart disease
SELECT 
CASE
WHEN  Cholesterol <=200 Then 'Normal'
WHEN  Cholesterol Between 200 AND 239 Then 'Borderline'
WHEN Cholesterol >=240 THEN 'High'
END AS Cholesterol
,COUNT(Cholesterol)AS NumCases,ROUND( COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
 FROM `singular-backup-336021.HeartDisease.HeartFailure`
 WHERE HeartDisease = 0
 GROUP BY 1
 ORDER BY 3 DESC
--It has an effect if the patient has high level of cholesterol
--MAX HR Heart Disease
SELECT 
CASE
WHEN  MaxHR <=95 Then 'Normal'
WHEN  MaxHR Between 96 AND 125 Then 'Above Normal'
WHEN  MaxHR Between 126 AND 155 Then 'Slightly High'
WHEN  MaxHR Between 156 AND 185 Then ' High'
WHEN MaxHR >=185 THEN 'Extreme'
END AS MaxHR
,COUNT(MaxHR)AS NumCases,ROUND( COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
 FROM `singular-backup-336021.HeartDisease.HeartFailure`
 WHERE HeartDisease = 1
 GROUP BY 1
 ORDER BY 3 DESC
 --Most Of cases are above normal,slightly high,high,normal then extreme
 --(No heart Disease)
SELECT 
CASE
WHEN  MaxHR <=95 Then 'Normal'
WHEN  MaxHR Between 96 AND 125 Then 'Above Normal'
WHEN  MaxHR Between 126 AND 155 Then 'Slightly High'
WHEN  MaxHR Between 156 AND 185 Then ' High'
WHEN MaxHR >=185 THEN 'Extreme'
END AS MaxHR
,COUNT(MaxHR)AS NumCases,ROUND( COUNT(*) *100 /SUM(COUNT(*)) OVER(),2) AS PERC
 FROM `singular-backup-336021.HeartDisease.HeartFailure`
 WHERE HeartDisease = 0
 GROUP BY 1
 ORDER BY 3 DESC
--Most Of cases are slightly high,high,above normal, extreme then normal
 
 
