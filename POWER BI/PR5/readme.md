# ✈️ Flight Delays Analysis 2019–2023 | Power BI Dashboard

**Practical Report 5 | Red & White Skill Education**

An interactive 5-page Power BI report that analyses 3 million US domestic flights to understand cancellations, delays, airline performance and route/airport patterns between January 2019 and August 2023.

---

## 🔗 Project Links

| Resource | Link |
|---|---|
| 📊 Power BI File (`PR5_kenil.pbix`) | [Download from Google Drive](PASTE_POWER_BI_FILE_LINK_HERE) |
| 🎥 Demo Video | [Watch on Google Drive](PASTE_VIDEO_LINK_HERE) |

> Make sure both Drive links are set to **"Anyone with the link → Viewer"**.

---

## 🖼️ Dashboard Preview

### Overview
![Overview Page](screenshots/01_overview.png)

### Airline Performance
![Airline Performance Page](screenshots/02_airline_performance.png)

### Route & Airport Map
![Route and Airport Map Page](screenshots/03_route_airport_map.png)

### Drill-Through Detail
![Drill Through Detail Page](screenshots/04_drill_through_detail.png)

### Trends & Forecast
![Trends and Forecast Page](screenshots/05_trends_forecast.png)

### Custom Tooltip (Airport)
![Tooltip Airport](screenshots/06_tooltip_airport.png)

### Mobile Layout
![Mobile Layout](screenshots/07_mobile_layout.png)

---

## 📁 Dataset

| Property | Detail |
|---|---|
| File | `flights_sample_3m.csv` |
| Rows | 3,000,000 flights |
| Columns | 32 |
| Period | 01 Jan 2019 – 31 Aug 2023 |
| Airlines | 18 |
| Airports | 380 origin / destination airports |

**Column groups**
- **Flight info:** `FL_DATE`, `AIRLINE`, `AIRLINE_DOT`, `AIRLINE_CODE`, `DOT_CODE`, `FL_NUMBER`
- **Route:** `ORIGIN`, `ORIGIN_CITY`, `DEST`, `DEST_CITY`, `DISTANCE`
- **Times and delays:** `CRS_DEP_TIME`, `DEP_TIME`, `DEP_DELAY`, `CRS_ARR_TIME`, `ARR_TIME`, `ARR_DELAY`, `TAXI_OUT`, `TAXI_IN`, `WHEELS_OFF`, `WHEELS_ON`, `CRS_ELAPSED_TIME`, `ELAPSED_TIME`, `AIR_TIME`
- **Status:** `CANCELLED`, `CANCELLATION_CODE`, `DIVERTED`
- **Delay causes:** `DELAY_DUE_CARRIER`, `DELAY_DUE_WEATHER`, `DELAY_DUE_NAS`, `DELAY_DUE_SECURITY`, `DELAY_DUE_LATE_AIRCRAFT`

---

## 📄 Report Pages

| # | Page | What it shows |
|---|---|---|
| 1 | **Overview** | KPI cards, cancellation causes, flight outcome distribution, on-time gauge vs 80% target, dynamic airline comparison chart |
| 2 | **Airline Performance** | Top 10 airlines by cancellations and by average departure delay, cancellation-rate heatmap by year |
| 3 | **Route & Airport Map** | US state cancellation-rate map and departure-airport bubble map (flight volume and average delay) |
| 4 | **Drill-Through Detail** | Airline-specific KPIs, monthly cancellations, cancellation reasons, on-time trend and flight-level table |
| 5 | **Trends & Forecast** | Monthly volume and delay trends by year, plus a 6-month flight volume forecast and the delay-threshold parameter |
| 6 | **Tooltip_Airport** (hidden) | Custom tooltip: total flights, cancellation rate and top 5 destinations for the hovered airport |

---

## 🧮 DAX Measures

```DAX
Total Flight Records = COUNTROWS(flights_sample_3m)
```

```DAX
Cancelled Flights =
CALCULATE(
    COUNTROWS('flights_sample_3m'),
    'flights_sample_3m'[CANCELLED] = 1
)
```

```DAX
Cancellation Rate =
DIVIDE([Cancelled Flights], [Total Flight Records], 0)
```

```DAX
Average Departure Delay =
AVERAGEX(
    FILTER('flights_sample_3m', 'flights_sample_3m'[CANCELLED] = 0),
    'flights_sample_3m'[DEP_DELAY]
)
```

```DAX
Average Arrival Delay =
AVERAGEX(
    FILTER('flights_sample_3m', 'flights_sample_3m'[CANCELLED] = 0),
    'flights_sample_3m'[ARR_DELAY]
)
```

```DAX
On-Time Performance % =
AVERAGEX(
    FILTER(
        'flights_sample_3m',
        'flights_sample_3m'[CANCELLED] = 0 &&
        'flights_sample_3m'[DIVERTED] = 0
    ),
    IF('flights_sample_3m'[ARR_DELAY] <= 15, 1, 0)
)
```

```DAX
Flights_Above_Min_Delay =
CALCULATE(
    [Total Flight Records],
    FILTER(
        flights_sample_3m,
        flights_sample_3m[ARR_DELAY] >= [Min_Delay_Minutes Value]
    )
)
```

### Calculated column

```DAX
Delay_Category =
SWITCH(
    TRUE(),
    flights_sample_3m[CANCELLED] = 1, "Cancelled",
    flights_sample_3m[DIVERTED] = 1, "Diverted",
    flights_sample_3m[ARR_DELAY] > 60, "Major Delay (>60 min)",
    flights_sample_3m[ARR_DELAY] > 15, "Minor Delay (15-60 min)",
    flights_sample_3m[ARR_DELAY] <= 15, "On Time",
    "Other"
)
```

> A flight counts as **on time** if it arrives within 15 minutes of its scheduled time. Cancelled and diverted flights are excluded from the on-time rate.

---

## ⚙️ Parameters

| Parameter | Type | Purpose |
|---|---|---|
| `Metric_Selector` | Fields parameter | Lets the user switch the airline comparison chart between Total Flights, Cancelled Flights, Avg Departure Delay, Avg Arrival Delay and On-Time % |
| `Min_Delay_Minutes` | Numeric range (0–120, step 15, default 15) | Sets the minimum arrival delay used by `Flights_Above_Min_Delay`; moving the slider changes the card value |

---

## 🎛️ Interactive Features

- **Page navigation bar** on every page: Overview, Airlines, Map, Detail, Trends
- **Drill-through** from an airline to a detailed page (Back button styled in red `#CC0000`)
- **Drill-down** matrix: Airline → Year hierarchy
- **Custom report-page tooltip** on the airport bubble map
- **Show / Hide Filters** toggle using bookmarks (`Slicer_Visible`, `Slicer_Hidden`)
- **Conditional formatting**: icon sets for cancellation rate and on-time rate
- **Edited interactions** so the gauge stays a constant benchmark
- **Mobile layout** for phone viewing
- **Consistent theme** with red `#CC0000` accents across all pages

---

## 🔍 Key Insights

> Replace these with your own findings from the final report.

- Overall on-time performance is **XX%** against the 80% target.
- The overall cancellation rate is **X.X%** (about 2.6% of flights).
- **[Airline]** has the highest cancellation count, and **[Airline]** has the highest average departure delay.
- **[State]** has the highest cancellation rate on the state map.
- Flight volume and delays show a clear dip / peak in **[period]**.

---

## 🛠️ Tools Used

- Power BI Desktop
- DAX
- Power Query (CSV import and type changes)

---

## ▶️ How to Open the Project

1. Download `PR5_kenil.pbix` from the link above.
2. Open it in **Power BI Desktop**.
3. If the data refresh fails, go to **Transform data → Data source settings** and point `flights_sample_3m.csv` to its location on your computer.

---

## 👤 Author

**Kenil Sanghavi**
GitHub: [KenilSanghavi](https://github.com/KenilSanghavi)
