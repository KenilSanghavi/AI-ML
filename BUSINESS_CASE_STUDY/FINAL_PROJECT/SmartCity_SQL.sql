CREATE TABLE smartcityenergy (
    MeterID            VARCHAR(10),
    Zone               VARCHAR(20),
    ConsumerType       VARCHAR(20),
    Date               DATE,
    EnergyConsumed_kWh DECIMAL(10,2),
    PeakUsage_kWh      DECIMAL(10,2),
    OutageMinutes      INT,
    MeterStatus        VARCHAR(10),
    TariffRate         DECIMAL(6,2)
);
-- Q1. Total and average daily energy consumption by zone
SELECT Zone,
       ROUND(SUM(EnergyConsumed_kWh),2) AS Total_kWh,
       ROUND(AVG(EnergyConsumed_kWh),2) AS Avg_Daily_kWh
FROM smartcityenergy
GROUP BY Zone
ORDER BY Total_kWh DESC;

-- Q2. Top 5 highest energy-consuming consumers (meters) within each consumer type
SELECT ConsumerType, MeterID, Zone, Total_kWh, Rank_In_Type
FROM (
    SELECT ConsumerType, MeterID, Zone,
           ROUND(SUM(EnergyConsumed_kWh),2) AS Total_kWh,
           ROW_NUMBER() OVER (PARTITION BY ConsumerType ORDER BY SUM(EnergyConsumed_kWh) DESC) AS Rank_In_Type
    FROM smartcityenergy
    GROUP BY ConsumerType, MeterID, Zone
) t
WHERE Rank_In_Type <= 5
ORDER BY ConsumerType, Rank_In_Type;

-- Q3. Monthly consumption trend across zones
SELECT DATE_FORMAT(Date,'%Y-%m') AS Month,
       Zone,
       ROUND(SUM(EnergyConsumed_kWh),2) AS Total_kWh
FROM smartcityenergy
GROUP BY DATE_FORMAT(Date,'%Y-%m'), Zone
ORDER BY Month, Zone;

-- Q4. Average cost per zone (EnergyConsumed x TariffRate)
SELECT Zone,
       ROUND(AVG(EnergyConsumed_kWh * TariffRate),2) AS Avg_Cost_Per_Reading,
       ROUND(SUM(EnergyConsumed_kWh * TariffRate),2) AS Total_Cost
FROM smartcityenergy
GROUP BY Zone
ORDER BY Avg_Cost_Per_Reading DESC;

-- Q5. Meters with the highest number of faults or outages (top 10)
SELECT MeterID, Zone, ConsumerType,
       SUM(MeterStatus = 'Faulty')     AS Fault_Count,
       SUM(OutageMinutes > 0)          AS Outage_Events,
       SUM(OutageMinutes)              AS Total_Outage_Minutes,
       SUM(MeterStatus = 'Faulty') + SUM(OutageMinutes > 0) AS Total_Issues
FROM smartcityenergy
GROUP BY MeterID, Zone, ConsumerType
ORDER BY Total_Issues DESC
LIMIT 10;

-- Q6. Zones with lowest energy efficiency (high usage + frequent outages)
-- Rank 1 = highest usage and most outages, so the smallest rank sum = lowest efficiency
SELECT Zone, Avg_kWh, Avg_Outage_Min, Outage_Frequency_Pct,
       RANK() OVER (ORDER BY Avg_kWh DESC) AS Usage_Rank,
       RANK() OVER (ORDER BY Avg_Outage_Min DESC) AS Outage_Rank,
       RANK() OVER (ORDER BY Avg_kWh DESC) + RANK() OVER (ORDER BY Avg_Outage_Min DESC) AS Rank_Sum
FROM (
    SELECT Zone,
           ROUND(AVG(EnergyConsumed_kWh),2) AS Avg_kWh,
           ROUND(AVG(OutageMinutes),2) AS Avg_Outage_Min,
           ROUND(100*AVG(OutageMinutes > 0),2) AS Outage_Frequency_Pct
    FROM smartcityenergy
    GROUP BY Zone
) z
ORDER BY Rank_Sum ASC;

-- Q7. Peak usage patterns: weekdays vs weekends
SELECT CASE WHEN DAYOFWEEK(Date) IN (1,7) THEN 'Weekend' ELSE 'Weekday' END AS DayType,
       ConsumerType,
       ROUND(AVG(PeakUsage_kWh),2)       AS Avg_Peak_kWh,
       ROUND(AVG(EnergyConsumed_kWh),2)  AS Avg_Daily_kWh
FROM smartcityenergy
GROUP BY DayType, ConsumerType
ORDER BY ConsumerType, DayType;