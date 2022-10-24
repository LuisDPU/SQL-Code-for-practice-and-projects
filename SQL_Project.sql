
Select *
From PortfolioProject.dbo.CovidDeaths
Where continent is not null
Order by 3,4

--Select *
--From PortfolioProject.dbo.CovidDeaths
--Where weekly_hosp_admissions is not null and continent is not null
--Order by 3, 4

Select *
From PortfolioProject.dbo.CovidVaccinations
Where continent is not null
Order by 3,4

-- Select Data that we are going to be using. I want to organize by location and date or 1,2

Select location,date,total_cases,new_cases,total_deaths,population
From PortfolioProject.dbo.CovidDeaths
Where continent is not null
Order by location,date

Select new_vaccinations,positive_rate
From PortfolioProject.dbo.CovidVaccinations
Where continent is not null

-- Looking at Total Cases vs Total Deaths
-- Show the likelyhood of dying if you contract covid in your country
Select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
From PortfolioProject.dbo.CovidDeaths
--Where location LIKE '%United States%' and continent is not null
--Where location LIKE '%Venezuela%' and  continent is not null
Where continent is not null and date is not null and total_cases is not null and total_deaths is not null
Order by DeathPercentage desc


-- Looking Total Cases vs Population
-- Shows what percentage of population got covid

Select location,date,population,total_cases, (total_cases/population)*100 AS PercentagePopulation
From PortfolioProject.dbo.CovidDeaths
--Where location LIKE '%Venezuela%' and continent is not null and continent is not null and date is not null and population is not null and total_cases is not null
--Where location LIKE '%states%' and continent is not null and date is not null and population is not null and total_cases is not null
Where continent is not null and date is not null and population is not null and total_cases is not null
Order by location, date




-- Looking at Countries with Highest Infection Rate compared to Population
-- Graph 3 for data visualization
Select location,population,Max(total_cases) AS HighestInfectionCount, Max((total_cases/population)*100) AS PercentPopulation_Infected
From PortfolioProject.dbo.CovidDeaths
Where continent is not null and population is not null  and total_cases is not null
Group by Location, population
Order by HighestInfectionCount desc



-- Graph 4 for data visualization
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Where population is not null and date is not null and total_cases is not null
Group by Location, Population, date
order by PercentPopulationInfected desc

-- Showing Countries with Highest Death Count per Population 

Select location, Max(cast(Total_deaths as int)) AS TotalDeathCount
From PortfolioProject.dbo.CovidDeaths
Where continent is not null and total_deaths is not null
Group by Location, population
Order by TotalDeathCount desc



-- What is the total cases per country or location
--Graph 6
Select location, Sum(total_cases) as Total_cases_percountry
From PortfolioProject.dbo.CovidDeaths
Where continent is not null and total_cases is not null
Group by location, new_cases
Order by 2 desc




--Data integrity and cleaning
-- Change the nvarchar to float because this will give me an error that would give error Msg 245
ALTER TABLE PortfolioProject.dbo.CovidDeaths
ALTER COLUMN reproduction_rate FLOAT

--Shows the reproduction rate risk in each location by date, population
-- Use is not null and reduced 210,932 to 165,734
-- Graph 7 used for data visulization
Select location, date, population, total_deaths, reproduction_rate,
Case
	When reproduction_rate >= 1 Then 'spreading exponientally'
	When reproduction_rate <= 1 then 'outbreak is subsiding'
	Else 'Null'
End AS reproductionrate_indicator
From PortfolioProject.dbo.CovidDeaths
Where continent is not null  and reproduction_rate is not null and date is not null and  population is not null
--Group by location,date
Order by 1, 2  



-- Show the average reproduction rate by location and population
-- Graph 8 for data visualization 
Select location, population, avg(reproduction_rate) as  Avg_reprductionrate
From PortfolioProject.dbo.CovidDeaths
Where continent is not null and reproduction_rate is not null
Group by location, population
Order by 2 desc


-- Let's Break Things Down By Continent

-- Showing contintents with the highest death count per population

Select location, Max(cast(Total_deaths as int)) AS TotalDeathCount
From PortfolioProject.dbo.CovidDeaths
Where continent is null
Group by location
Order by TotalDeathCount desc


--Use for data visualization graph 2
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc


-- Global Number

Select date,Sum(new_Cases) as Total_cases, Sum(cast(new_deaths as int)) As Total_deaths, Sum(cast(new_deaths as int))/Sum(new_Cases)*100 AS DeathPercent-- (total_cases/population)*100 AS PercentagePopulation
From PortfolioProject.dbo.CovidDeaths
--Where location LIKE '%states%' 
Where continent is not null and new_cases is not null and new_deaths is not null
Group by date
Order by 1, 2



-- Showing the total cases vs Total Death as percentage
-- Graph 1 use for data visulization
Select Sum(new_Cases) as Total_cases, Sum(cast(new_deaths as int)) As Total_deaths, Sum(cast(new_deaths as int))/Sum(new_Cases)*100 AS DeathPercent-- (total_cases/population)*100 AS PercentagePopulation
From PortfolioProject.dbo.CovidDeaths
--Where location LIKE '%states%' 
 Where continent is not null and new_cases is not null and new_deaths is not null 
--Group by date
Order by 1, 2



-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum (Cast(vac.new_vaccinations AS bigint)) OVER (Partition by dea.location Order by dea.location,
dea.Date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject.dbo.CovidDeaths AS Dea
JOIN PortfolioProject.dbo.CovidVaccinations Vac
	ON dea.location = vac.location
	and Dea.date = Vac.date
-- Where dea.location LIKE '%United States%' and dea.continent is not null and dea.date is not null and dea.population is not null and vac.new_vaccinations is not null
Where dea.continent is not null and dea.date is not null and dea.population is not null and vac.new_vaccinations is not null
Order by 2,3


Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
-- Where dea.location LIKE '%United States%' and dea.continent is not null and dea.date is not null and dea.population is not null and vac.new_vaccinations is not null
Where dea.continent is not null and dea.date is not null and dea.population is not null and vac.new_vaccinations is not null
order by 2,3




-- Show the positive rate in each location  in relation with total_Cases and total_deaths
Select dea.location, dea.date, dea.total_cases,dea.total_deaths,vac.positive_rate 
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null and dea.date is not null and dea.total_cases is not null and dea.total_deaths is not null and vac.positive_rate is not null
Group by dea.location, dea.date, dea.total_cases, dea.total_deaths, vac.positive_rate
Order by vac.positive_rate desc



-- USE CTE

With PopvsVac ( Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
As
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null and dea.date is not null and dea.population is not null and vac.new_vaccinations is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar (255),
Location nvarchar (255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert Into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null and dea.date is not null and dea.population is not null and vac.new_vaccinations is not null

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated As
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null and dea.date is not null and dea.population is not null and vac.new_vaccinations is not null


