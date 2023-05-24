--NFL Regular Season Data Exploration

--Skills used: Joins, CTE's Temp Tables, Windows Functions, Aggregate Funtions, Creating Views, Converting Data Types


Select *
From NFLRegularSeasonDataProject..NFLRegSeasonOffenseStats
Order by 3


-- Select Data that we are going to be starting with

Select Team, Conference, Year, Wins, Losses,Ties, Passing_Attempts, Passing_Completions, Passing_Yards, Passing_TDs, Interceptions_Thrown
From NFLRegularSeasonDataProject..NFLRegSeasonOffenseStats
Order by 2

-- Competion Percentage vs Yards Per Carry
-- Comparing effectiveness of team on various offensive plays

Select Team, Conference, Year, (Passing_Completions/Passing_Attempts)*100 as Completion_Percentage, (Rushing_Yards/[Rushing _Attempts]) as Yards_Per_Carry
From NFLRegularSeasonDataProject..NFLRegSeasonOffenseStats
Order by 2

-- Team Passer Rating vs Team Record
-- Comparing NFL team's passing attack with the team's regular season record

Select Team, Conference, Year, Wins, Losses,Ties, (((((Passing_Completions/Passing_Attempts)-0.3)*5)+(((Passing_Yards/Passing_Attempts)-3)*0.25)+((Passing_TDs/Passing_Attempts)*20)+(2.375-(Interceptions_Thrown/Passing_Attempts)*25))/6)*100 as Passer_Rating
From NFLRegularSeasonDataProject..NFLRegSeasonOffenseStats
Order by 2

-- Conference Offensive Stats
-- Comparing the total numbers of passing TDs, rushing TDs, field goals, and extra points scored during the 2004-2022 regular seasons

Select Conference, SUM(Passing_TDs) as Total_Passing_TDs, SUM(Rushing_TDs) as Total_Rushing_TDs, SUM(Two_Point_Conversions) as Total_Two_Point_Conversions, SUM(Field_Goals_Made) as Total_Field_Goals_Made, SUM(Extra_Points_Made) as Total_Extra_Points_Made
From NFLRegularSeasonDataProject..NFLRegSeasonOffenseStats
Group by Conference
Order by 1,2

-- Wins vs Losses vs Ties

Select Team, SUM(Wins) as Total_Wins, SUM(Losses) as Total_Losses, SUM(Ties) as Total_Ties
From NFLRegularSeasonDataProject..NFLRegSeasonOffenseStats
Group by Team
Order by Total_Wins desc

-- Recieving TDs vs Interceptions on Defense
-- Compares NFL's offensive and defensive regular season stats

Select dea.Team, dea.Conference, dea.Year, dea.Receiving_TDs, vac.Interceptions
, SUM(CONVERT(int,vac.interceptions)) OVER (Partition by dea.Team Order By dea.Team, dea.Year) as RollingDefensiveInterceptions
From NFLRegularSeasonDataProject..NFLRegSeasonOffenseStats dea
Join NFLRegularSeasonDataProject..NFLRegSeasonDefenseStats vac
		On dea.Team = vac.Team
		and dea.Year = vac.Year
Order by 2

-- CTE on previous query

With RecvsINT (Team, Conference, Year, Receiving_TDs, Interceptions, RollingDefensiveInterceptions)
as
(
Select dea.Team, dea.Conference, dea.Year, dea.Receiving_TDs, vac.Interceptions
, SUM(CONVERT(int,vac.interceptions)) OVER (Partition by dea.Team Order By dea.Team, dea.Year) as RollingDefensiveInterceptions
From NFLRegularSeasonDataProject..NFLRegSeasonOffenseStats dea
Join NFLRegularSeasonDataProject..NFLRegSeasonDefenseStats vac
		On dea.Team = vac.Team
		and dea.Year = vac.Year
--Order by 2
)
Select*, (Interceptions/16) as Avg_Defensive_Interceptions_Per_Game
From RecvsINT

-- Temp Table

Drop Table if exists #NFLTeamStats
Create Table #NFLTeamStats
(
Team nvarchar(255),
Conference nvarchar (255),
Year datetime,
Receiving_TDs numeric,
Interceptions numeric,
RollingDefensiveInterceptions numeric
)

Insert into #NFLTeamStats
Select dea.Team, dea.Conference, dea.Year, dea.Receiving_TDs, vac.Interceptions
, SUM(CONVERT(int,vac.interceptions)) OVER (Partition by dea.Team Order By dea.Team, dea.Year) as RollingDefensiveInterceptions
From NFLRegularSeasonDataProject..NFLRegSeasonOffenseStats dea
Join NFLRegularSeasonDataProject..NFLRegSeasonDefenseStats vac
		On dea.Team = vac.Team
		and dea.Year = vac.Year
--Order by 2

Select*, (Interceptions/16) as Avg_Defensive_Interceptions_Per_Game
From #NFLTeamStats




-- Creating views

Create View NFLTeamStats as
Select dea.Team, dea.Conference, dea.Year, dea.Receiving_TDs, vac.Interceptions
, SUM(CONVERT(int,vac.interceptions)) OVER (Partition by dea.Team Order By dea.Team, dea.Year) as RollingDefensiveInterceptions
From NFLRegularSeasonDataProject..NFLRegSeasonOffenseStats dea
Join NFLRegularSeasonDataProject..NFLRegSeasonDefenseStats vac
		On dea.Team = vac.Team
		and dea.Year = vac.Year


