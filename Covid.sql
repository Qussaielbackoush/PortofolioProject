SELECT *
FROM `singular-backup-336021.Project1.CovidVaccinations`
ORDER BY 3,4


SELECT LOCATION, date, total_cases, new_cases, total_deaths, population
FROM `singular-backup-336021.Project1.CovidDeath`
ORDER BY 1,2

-- Looking at Total Cases VS Total Deaths
SELECT LOCATION, date, total_cases, total_deaths, ROUND((total_deaths/total_cases)*100,2) AS DeathPercantage 
FROM `singular-backup-336021.Project1.CovidDeath`
WHERE LOCATION ='United Kingdom'
ORDER BY 1,2

SELECT LOCATION, date, total_cases, total_deaths, ROUND((total_deaths/total_cases)*100,2) AS DeathPercantage 
FROM `singular-backup-336021.Project1.CovidDeath`
WHERE LOCATION ='Egypt'
ORDER BY 1,2

SELECT LOCATION, date, total_cases, total_deaths, ROUND((total_deaths/total_cases)*100,2) AS DeathPercantage 
FROM `singular-backup-336021.Project1.CovidDeath`
WHERE LOCATION ='Germany'
ORDER BY 1,2

--looking at Totalcases vs Population
SELECT LOCATION, date, total_cases,population, ROUND((total_cases/population)*100,2) AS CasePercantage 
FROM `singular-backup-336021.Project1.CovidDeath`
WHERE LOCATION ='Germany'
ORDER BY 1,2

SELECT LOCATION, date, total_cases,population, ROUND((total_cases/population)*100,2) AS CasePercantage 
FROM `singular-backup-336021.Project1.CovidDeath`
WHERE LOCATION ='Egypt'
ORDER BY 1,2 

--looking at the countries with the highest infection rate compared to population
SELECT LOCATION, max(total_cases) as Highestinfection, population, MAX(ROUND((total_cases/population)*100,2)) AS InfectionratePercantage 
FROM `singular-backup-336021.Project1.CovidDeath`
GROUP BY population, location
ORDER BY  InfectionratePercantage DESC 

--looking at the countries with the highest death rate compared to population
SELECT LOCATION, CAST(max(total_deaths) as int) as Highestdeathcount, MAX(ROUND((total_deaths/population)*100,2)) AS DeathratePercantage 
FROM `singular-backup-336021.Project1.CovidDeath`
WHERE continent IS NOT NULL
GROUP BY  location
ORDER BY  Highestdeathcount DESC 

-- Let's break it down by continent
SELECT continent, CAST(max(total_deaths) as int) as Highestdeathcount, MAX(ROUND((total_deaths/population)*100,2)) AS DeathratePercantage 
FROM `singular-backup-336021.Project1.CovidDeath`
WHERE continent IS NOT  NULL
GROUP BY  continent
ORDER BY  Highestdeathcount DESC 

SELECT continent, max(total_cases) as Highestinfectioncount, MAX(ROUND((total_cases/population)*100,2)) AS InfectionratePercantage 
FROM `singular-backup-336021.Project1.CovidDeath`
WHERE continent IS not NULL
GROUP BY continent
ORDER BY  InfectionratePercantage DESC 

--GLOBAL 
SELECT date, SUM(new_cases) as Totalcases, SUM(new_deaths) AS Totaldeaths, ROUND(SUM(new_deaths)/SUM(new_cases)*100,2) AS DeathPercantage 
FROM `singular-backup-336021.Project1.CovidDeath`
WHERE continent is not null
GROUP BY DATE
ORDER BY 1,2


SELECT SUM(new_cases) as Totalcases, SUM(new_deaths) AS Totaldeaths, ROUND(SUM(new_deaths)/SUM(new_cases)*100,2) AS DeathPercantage 
FROM `singular-backup-336021.Project1.CovidDeath`
WHERE continent is not null
--GROUP BY DATE
ORDER BY 1,2

-- Looking at Total Population VS Total Vaccination
SELECT * FROM `singular-backup-336021.Project1.CovidVaccinations` AS VAC
JOIN `singular-backup-336021.Project1.CovidDeath` AS DEA
 ON vac.location = DEA.location
 AND VAC.date = dea.date

--CTE 
WITH  POPVSVAC 
AS
(
SELECT dea.date, dea.population, dea.location, dea.continent,VAC.new_vaccinations,
SUM(VAC.new_vaccinations) OVER (PARTITION BY DEA.location ORDER BY DEA.location, DEA.date) AS Vaccadd
 FROM `singular-backup-336021.Project1.CovidVaccinations` AS VAC
JOIN `singular-backup-336021.Project1.CovidDeath` AS DEA
 ON vac.location = DEA.location
 AND VAC.date = dea.date
 WHERE dea.continent is not null
 --ORDER BY 3,1
)
SELECT *,ROUND(vaccadd/population *100,2) as POPvsVACPercentage
FROM POPVSVAC
WHERE LOCATION ='Canada'
--we got from this query the total vaccination in canada 



