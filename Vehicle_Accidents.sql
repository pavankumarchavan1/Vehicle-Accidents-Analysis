-- Exploratory Data Analysis of Vehicle Accidents database


-- 1. How many accidents have occurred in Urban areas v/s rural areas?

SELECT Area, COUNT(Area) AS Total_Accidents
FROM accident
GROUP BY Area;


-- 2. Which day of the week has the highest number of accidents?

SELECT Day, COUNT(Day) DayCount
FROM accident
GROUP BY Day
ORDER BY DayCount DESC;


-- 3. What is the average age of vehicles involved in accidents based on their type?

SELECT VehicleType, COUNT(AccidentIndex) AS Accidents_count, ROUND(AVG(AgeVehicle), 2) AS Average_age_of_vehicles
FROM vehicle
WHERE AgeVehicle <> 0
GROUP BY VehicleType
ORDER BY Accidents_count DESC, Average_age_of_vehicles DESC;


-- 4. Can we identify any trends in accidents based on the age of vehicles involved?

SELECT AgeGroup, COUNT(AccidentIndex) AS Accident_Count, ROUND(AVG(AgeVehicle), 2) AS AverageAge
FROM (
		SELECT AccidentIndex, AgeVehicle,
			CASE
				WHEN AgeVehicle BETWEEN 1 AND 5 THEN 'New'
				WHEN AgeVehicle BETWEEN 6 AND 10 THEN 'Reqular'
				ELSE 'Old'
			END AS AgeGroup
		FROM Vehicle
        WHERE AgeVehicle <> 0) AS Sub
GROUP BY AgeGroup
ORDER BY AverageAge DESC;


-- 5. Are there any specific weather conditions that contribute to severe accidents?

-- For all types of severity
SELECT WeatherConditions, Severity, COUNT(Severity) AS Severe_accidents
FROM accident
GROUP BY WeatherConditions, Severity
ORDER BY Severe_accidents DESC;


-- For specific severity

-- DECLARE @Severity VARCHAR(20)
-- SET @Severity = 'Fatal'

SELECT WeatherConditions, Severity, COUNT(Severity) AS Severe_accidents
FROM accident
GROUP BY WeatherConditions, Severity
ORDER BY Severe_accidents DESC;


-- 6. Do accidents often involve impacts on the left-hand side of vehicles?

SELECT LeftHand, COUNT(AccidentIndex)
FROM vehicle
GROUP BY LeftHand;


-- 7. Are there any relationships between journey purposes and the severity of accidents?

SELECT JourneyPurpose, Severity, COUNT(Severity) AS Severe_Accidents
FROM vehicle v
LEFT JOIN accident a
ON v.AccidentIndex = a.AccidentIndex
GROUP BY JourneyPurpose, Severity
ORDER BY Severe_Accidents DESC;


-- 8. Calculate the average age of vehicles involved in accidents, considering day light and point of impact.

SELECT v.PointImpact, a.LightConditions, ROUND(AVG(v.AgeVehicle), 2) AS Avg_age
FROM vehicle v
JOIN accident a
ON a.AccidentIndex = v.AccidentIndex
WHERE v.AgeVehicle <> 0
GROUP BY a.LightConditions, v.PointImpact
ORDER BY Avg_age DESC;
