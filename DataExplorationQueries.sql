Select * from ProjectForGithub..CovidDeaths

--Main columns 
Select Location, date, total_cases, new_cases, total_deaths, population 
From ProjectForGithub..CovidDeaths
Order By 1,2

--Looking at Total cases vs Total deaths
Select Location, date, total_cases, total_deaths, (total_cases/total_deaths) as DeathPercentage
From ProjectForGithub..CovidDeaths
Order By 1,2

--Looking at Total cases vs Total population
Select Location, date, population, total_cases,  (total_cases/population) as PercentInfectedPopulation
From ProjectForGithub..CovidDeaths
Order By 1,2

--Looking at countries with Highest Infection Rate compared to Population
Select Location, population, MAX(total_cases),  MAX((total_cases/population))*100 as PercentInfectedPopulation
From ProjectForGithub..CovidDeaths
Group By Location, population
Order By PercentInfectedPopulation desc

--Showing countries with Highest Death Count
Select Location,  MAX(CAST(total_deaths as int)) as TotalDeathCounts
From ProjectForGithub..CovidDeaths
where continent is not null
Group By Location
Order By TotalDeathCounts desc

--Showing continents with Highest Death Count
Select continent,  MAX(CAST(total_deaths as int)) as TotalDeathCounts
From ProjectForGithub..CovidDeaths
where continent is not null
Group By continent
Order By TotalDeathCounts desc

--Datewise Cases,Deaths and Percentage of death
Select date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)), SUM(new_cases)/SUM(CAST(new_deaths as int)) as DeathPercentage
From ProjectForGithub..CovidDeaths
where continent is not null
Group By date
Order By 1,2

--Total cases from the entire table
Select SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)), SUM(new_cases)/SUM(CAST(new_deaths as int)) as DeathPercentage
From ProjectForGithub..CovidDeaths
where continent is not null
Order By 1,2

--Total Population vs Vaccinations
Select d.continent, d.location, d.date, d.population, v.new_vaccinations, 
SUM(CONVERT(int, v.new_vaccinations)) OVER (Partition by d.location Order by d.location, d.date)
from ProjectForGithub..CovidDeaths d
Join ProjectForGithub..CovidVaccinations v
ON d.location = v.location and
   d.date = v.date
where d.continent is not null
order by 1,2,3

