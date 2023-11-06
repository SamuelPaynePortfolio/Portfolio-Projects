Select *
From GoogleCaseStudy1..SampleTrafficData

-- Rearranged columns for better flow.
Select Date, CONVERT(Varchar, Time, 108) as Time, Day_of_the_week, Cars, Bikes, Buses, Trucks, (Cars + Bikes + Buses + Trucks) as Total_Traffic, Traffic_Activity
From GoogleCaseStudy1..SampleTrafficData

-- Traffic Breakdown by Date
Select Date, sum(Cars) as Total_Cars, sum(Bikes) as Total_Bikes, sum(Buses) as Total_Buses, sum(Trucks) as Total_Trucks, sum((Cars + Bikes + Buses + Trucks)) as Total_Traffic
From GoogleCaseStudy1..SampleTrafficData
Group by Date 
order by 1

-- Traffic Breakdown by Time.
Select CONVERT(Varchar, Time, 108) as Time, sum(Cars) as Total_Cars, sum(Bikes) as Total_Bikes, sum(Buses) as Total_Buses, sum(Trucks) as Total_Trucks, sum((Cars + Bikes + Buses + Trucks)) as Total_Traffic
From GoogleCaseStudy1..SampleTrafficData
Group by Time
order by 1

-- Traffic Breakdown by Day of the Week. 
Select Day_of_the_week, sum(Cars) as Total_Cars, sum(Bikes) as Total_Bikes, sum(Buses) as Total_Buses, sum(Trucks) as Total_Trucks, sum((Cars + Bikes + Buses + Trucks)) as Total_Traffic
From GoogleCaseStudy1..SampleTrafficData
Group by Day_of_the_week
Order by 3,1

--Date vs  Low Traffic Activity
Select Date, count(Traffic_Activity) as Traffic_Activity
From GoogleCaseStudy1..SampleTrafficData
Where Traffic_Activity = 'Low'
Group by Date

--Date vs  Normal Traffic Activity
Select Date, count(Traffic_Activity) as Traffic_Activity
From GoogleCaseStudy1..SampleTrafficData
Where Traffic_Activity = 'Normal'
Group by Date

--Date vs  High Traffic Activity
Select Date, count(Traffic_Activity) as Traffic_Activity
From GoogleCaseStudy1..SampleTrafficData
Where Traffic_Activity = 'High'
Group by Date

--Date vs  Heavy Traffic Activity
Select Date, count(Traffic_Activity) as Traffic_Activity
From GoogleCaseStudy1..SampleTrafficData
Where Traffic_Activity = 'Heavy'
Group by Date

--Time vs  Low Traffic Activity
Select CONVERT(Varchar, Time, 108) as Time, count(Traffic_Activity) as Traffic_Activity
From GoogleCaseStudy1..SampleTrafficData
Where Traffic_Activity = 'Low'
Group by Time

--Time vs Normal Traffic Activity
Select CONVERT(Varchar, Time, 108) as Time, count(Traffic_Activity) as Traffic_Activity
From GoogleCaseStudy1..SampleTrafficData
Where Traffic_Activity = 'Normal'
Group by Time
Order by 1

--Time vs High Traffic Activity
Select CONVERT(Varchar, Time, 108) as Time, count(Traffic_Activity) as Traffic_Activity
From GoogleCaseStudy1..SampleTrafficData
Where Traffic_Activity = 'High'
Group by Time
Order by 1

--Time vs Heavy Traffic Activity
Select CONVERT(Varchar, Time, 108) as Time, count(Traffic_Activity) as Traffic_Activity
From GoogleCaseStudy1..SampleTrafficData
Where Traffic_Activity = 'Heavy'
Group by Time
Order by 1

-- Total Traffic Under 50 (Note): Ideal time range is 10:00pm-3:30am for trailer dropoff and pickup
Select Date, CONVERT(Varchar, Time, 108) as Time, Day_of_the_week, Cars, Bikes, Buses, Trucks, (Cars + Bikes + Buses + Trucks) as Total_Traffic, Traffic_Activity
From GoogleCaseStudy1..SampleTrafficData
Where [Total_Traffic_On_ Road]< '50'