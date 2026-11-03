# ⚡ WattWatch: Analyzing Urban Energy Consumption for Smarter Cities

A data-driven urban analytics case study that uses **SQL (MySQL)** for analysis and **Power BI** for an interactive dashboard, to find energy hotspots, wastage and unreliable power supply across the zones of a smart city.

---

## 📌 Project Overview

A municipal data team wants to understand how energy is used across a smart city. This project:

- Analyses smart-meter readings with SQL
- Exports the query results as CSV files
- Presents the insights in a soft dark Power BI dashboard
- Summarises actionable findings for city planners

**Tools used:** MySQL · Power BI Desktop · DAX · CSV

---

## 🗃️ Dataset

**File:** `SmartCityEnergy.csv`, generated with an AI tool: 1,000 smart meters, daily readings for 2024 (366,000 rows), 5 city zones.

| Column | Description |
|---|---|
| MeterID | Unique identifier for each smart meter |
| Zone | City zone (Central, North, South, East, West) |
| ConsumerType | Residential / Commercial / Industrial |
| Date | Reading date |
| EnergyConsumed_kWh | Total kilowatt-hours consumed |
| PeakUsage_kWh | Maximum kWh drawn in a single hour |
| OutageMinutes | Power outage duration in minutes |
| MeterStatus | Active / Faulty |
| TariffRate | Price per kWh at the time of billing |

> The data is synthetic. It was built to contain realistic patterns, so the results show how the analysis works and are not real city figures.

---

## 🛠️ Setup

### 1. Create table
```sql
create table smartcityenergy (
    MeterID varchar(10),
    Zone varchar(20),
    ConsumerType varchar(20),
    Date date,
    EnergyConsumed_kWh decimal(10,2),
    PeakUsage_kWh decimal(10,2),
    OutageMinutes int,
    MeterStatus varchar(10),
    TariffRate decimal(6,2)
);
```

### 2. Load the CSV
```sql
set global local_infile = 1;

load data local infile 'path/to/SmartCityEnergy.csv'
into table smartcityenergy
fields terminated by ','
lines terminated by '\n'
ignore 1 rows
(MeterID, Zone, ConsumerType, @d, EnergyConsumed_kWh, PeakUsage_kWh, OutageMinutes, MeterStatus, TariffRate)
set Date = str_to_date(@d, '%m/%d/%Y');
```
Adjust the date format to match your file, and connect with `mysql --local-infile=1 -u root -p`.

### 3. Check the load
```sql
select count(*) from smartcityenergy;          -- 366000
select min(Date), max(Date) from smartcityenergy;
```

---

## 🔍 Part 1: SQL Analysis

All queries are in `SmartCity_SQL.sql`, with outputs in `final_results/`.

| # | Question | Output |
|---|---|---|
| Q1 | Total and average energy consumption by zone | `Q1.csv` |
| Q2 | Top 5 highest energy-consuming consumers | `Q2.csv` |
| Q3 | Monthly consumption trend across zones | `Q3.csv` |
| Q4 | Average cost per zone (EnergyConsumed × TariffRate) | `Q4.csv` |
| Q5 | Meters with the highest number of faults or outages | `Q5.csv` |
| Q6 | Zones with lowest efficiency (high usage + frequent outages) | `Q6.csv` |
| Q7 | Peak usage patterns, weekdays vs weekends | `Q7.csv` |

Example (Q1):
```sql
select Zone, sum(EnergyConsumed_kWh) as total_kwh, avg(EnergyConsumed_kWh) as avg_kwh
from smartcityenergy
group by Zone;
```

---

## 📊 Part 2: Power BI Dashboard

**File:** `WattWatchDashboard.pbix`, with a soft dark theme.

### Visuals
| Visual | Purpose |
|---|---|
| KPI cards (4) | Total Consumption, Avg Peak Usage, Total Outage Minutes, Total Estimated Cost |
| Map | Energy use by zone (geo heatmap) |
| Line chart | Monthly kWh trend by zone |
| Bar chart | Energy usage by consumer type |
| Table | Meter health watchlist (top 10 by faulty %), with conditional formatting |
| Slicers | Zone, Consumer Type, Date Range |

### DAX measures
```
Total Consumption = SUM(SmartCityEnergy[EnergyConsumed_kWh])
Avg Peak Usage = AVERAGE(SmartCityEnergy[PeakUsage_kWh])
Total Outage Minutes = SUM(SmartCityEnergy[OutageMinutes])
Total Estimated Cost = SUMX(SmartCityEnergy, SmartCityEnergy[EnergyConsumed_kWh] * SmartCityEnergy[TariffRate])
Faulty % = DIVIDE(CALCULATE(COUNTROWS(SmartCityEnergy), SmartCityEnergy[MeterStatus] = "Faulty"), COUNTROWS(SmartCityEnergy))
```

### Data model
- `SmartCityEnergy[Zone]` → `ZoneLocations[Zone]` (many to one)
- `Calendar[Date]` → `SmartCityEnergy[Date]` (a generated Calendar table with Month and MonthNo columns)

## 💡 Key Insights

1. **Central is the energy hotspot.** About 29% of total consumption (6.26M kWh) and the highest average daily use (73.4 kWh), well above every other zone.
2. **Central is also the least efficient zone.** It ranks first for both usage and outage minutes (558,617), and has the highest estimated cost.
3. **Industrial consumers use the most power.** They account for about 52% of all consumption (11.3M kWh), and the top 5 energy-consuming meters are all industrial.
4. **Consumption peaks in summer.** July is the highest month (about 2.06M kWh) and February the lowest (about 1.55M kWh).
5. **Weekdays have higher peaks.** Average peak usage is 5.63 kWh on weekdays against 3.65 kWh on weekends.

   
### Recommendations
- Prioritise grid upgrades and demand management in Central.
- Offer time-of-use tariffs and efficiency audits to industrial customers.
- Plan maintenance outside the May to August peak.
- Inspect and replace the most fault-prone meters.

---

## ▶️ How to Reproduce

1. Load `SmartCityEnergy.csv` into MySQL
2. Run the queries in `SmartCity_SQL.sql` and export each result as CSV.
3. Open `WattWatchDashboard.pbix` in Power BI Desktop. If the data source path breaks, go to Home > Transform data > Data source settings and point it to your local CSV files.
4. Use the slicers to explore by zone, consumer type and date range.

---

## 📸 Dashboard Preview

Add a screenshot of your dashboard here:

```
<img width="1167" height="805" alt="image" src="https://github.com/user-attachments/assets/b53e5449-259e-4102-9a27-473e751727ba" />

```

---

## 👤 Author

**Kenil**, Computer Science student
Project: WattWatch, final case study (SQL + Power BI)
