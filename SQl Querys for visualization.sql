USE [TCS stocks]

SELECT *
FROM TCS_corrected

-- Add a new column DayName to store the day of the date column

ALTER TABLE TCS_corrected ADD DayName Varchar(20);

UPDATE TCS_corrected
SET DayName = DATENAME(DW, Date)

-- Add a new column Year to store the year of the date column

ALTER TABLE TCS_corrected ADD Year int

UPDATE TCS_corrected
SET Year = YEAR(Date)

SELECT *
FROM TCS_corrected

-- 1.) looking at the Average_price, Average_Change and Average_volume of the stock

SELECT
    AVG([Price]) AS Average_Price,
    AVG(TRY_CAST(Change AS decimal(5,2))) AS Average_Change,
	AVG(cast(Volume as bigint)) as Averaage_volume
FROM
    TCS_corrected

-- 2.) looking at the Average_price, Average_Change and Average_volume of the stock per year

SELECT
	YEAR,
    AVG([Price]) AS Average_Price,
    AVG(TRY_CAST(Change AS decimal(5,2))) AS Average_Change,
	AVG(cast(Volume as bigint)) as Averaage_volume
FROM
    TCS_corrected
Group by
	Year
Order By 
	Year

-- 3.) Looking at the price of the stock per date

SELECT 
	date,
	price
from 
	TCS_corrected
order by
	Price Desc

-- 4.) Looking at the Average_Open and Avegae_low price of the stock per  year

Select year,
	AVG([Open]) as Average_Open,
	AVG(low) as Average_low
From
	TCS_corrected
Group by
	Year
Order by
	Year


-- 5.) Looking at the high price and low price of the stock per date

SELECT Date,
	High,
	Low
FROM 
	TCS_corrected
order by
	Date Desc

-- 6.) looking at the change of the stock per day in a week


SELECT DayName, SUM(TRY_CAST(Change AS decimal(5,2))) AS TotalChange
FROM 
	TCS_corrected
GROUP BY 
	DayName
