# HR Workforce Analytics – Power BI Dashboard (PR4)

A 3-page Power BI report that analyses workforce size, attrition, hiring trends, compensation and training investment, built on an HR dataset with 5 source tables and a custom date table.

**Author:** Kenil · [GitHub](https://github.com/KenilSanghavi)

---

## Project Links

| Item | Link |
|------|------|
| Demo video + `.pbix` file (Google Drive) | PASTE_YOUR_DRIVE_LINK_HERE |
---

## Tools Used

- Power BI Desktop
- Power Query (M language)
- DAX (measures and calculated columns)

---
### Tables

| Table | Rows | Description |
|-------|------|-------------|
| EmployeeMaster | 50,000 | Main employee table: salary, department, status, joining and termination dates, gender, performance score |
| Engagement_Survey | 50,000 | Engagement, satisfaction and work-life balance scores per employee |
| performance | 50,000 | Yearly and quarterly employee rating |
| Training | 50,000 | Training program, type, outcome, duration (days) and cost |
| Recruitment | 50,000 | Applicant records and application status (standalone, no relationship) |
| DimDate | 2,557 days | Calendar table, 2018-01-01 to 2024-12-31 |
| _Measures | – | Table that holds all DAX measures |

### Relationships

| # | From (Many) | To (One) | Cardinality | Direction | Status |
|---|-------------|----------|-------------|-----------|--------|
| 1 | Engagement_Survey[Employee ID] | EmployeeMaster[Employee ID] | Many-to-One | Single | Active |
| 2 | performance[Employee ID] | EmployeeMaster[Employee ID] | Many-to-One | Single | Active |
| 3 | Training[Employee ID] | EmployeeMaster[Employee ID] | Many-to-One | Single | Active |
| 4 | EmployeeMaster[DateOfJoining] | DimDate[Date] | Many-to-One | Single | Active |
| 5 | EmployeeMaster[DateOfTermination] | DimDate[Date] | Many-to-One | Single | **Inactive** |

The termination-date relationship is inactive because only one relationship between two tables can be active. It is switched on inside `YTD_Attrition_Pct` with `USERELATIONSHIP()`.

### DimDate (Power Query)

Built in Power Query with M code from 2018-01-01 to 2024-12-31. Columns: `Date`, `Year`, `Quarter`, `Month_Num`, `Month_Name`, `Weekday`, `Year_Quarter`.

---

## Calculated Columns (EmployeeMaster)

| Column | Purpose | Logic |
|--------|---------|-------|
| IsActiveFlag | 1 if the employee is active, else 0 | `IF(EmployeeStatus = "Active", 1, 0)` |
| Tenure_years | Years of service | Years between joining date and today (active) or termination date (terminated) |
| Career_Level_Band | Tenure group | New Hire (<1), Junior (1–3), Mid-Level (4–6), Senior (7–10), Veteran (>10) |
| SalaryBand | Salary group | Band A (≥120,000), Band B (≥80,000), Band C (≥50,000), Band D (below 50,000) |
| Above_Avg_Salary_Flag | Compares salary with the company average | "Above Average Salary" or "Below/Equal Average Salary" |
| PerformanceLabel | Readable performance category | Maps `Performance Score` to a label |
| Full_Name | Full name | `FirstName & " " & LastName` |
| SalaryFormatted | Salary as text | `FORMAT(Salary, "$#,##0")` |
| DaysSinceHire | Days since joining | `DATEDIFF(DateOfJoining, TODAY(), DAY)` |
| HirePeriod | Year-month of joining | `FORMAT(DateOfJoining, "YYYY-MM")` |

---

## DAX Measures (27)

All measures are stored in the `_Measures` table.

### Headcount and workforce

```DAX
Total_Headcount = COUNTROWS(EmployeeMaster)
```
```DAX
Active_Headcount =
CALCULATE(COUNTROWS(EmployeeMaster), EmployeeMaster[IsActiveFlag] = 1)
```
```DAX
Terminated_Count =
CALCULATE(COUNTROWS(EmployeeMaster), EmployeeMaster[IsActiveFlag] = 0)
```
```DAX
Unique_Departments = DISTINCTCOUNT(EmployeeMaster[DepartmentType])
```
```DAX
Total_Headcount_All_Depts =
CALCULATE([Total_Headcount], ALL(EmployeeMaster[DepartmentType]))
```
```DAX
Pct_of_Total_Headcount =
DIVIDE([Total_Headcount], [Total_Headcount_All_Depts], 0)
```
```DAX
Tenure_8Plus_Count =
CALCULATE(
    COUNTROWS(EmployeeMaster),
    FILTER(EmployeeMaster, EmployeeMaster[Tenure_years] >= 8)
)
```
```DAX
Avg_Years_of_Service = AVERAGE(EmployeeMaster[Tenure_years])
```
```DAX
Gender_Diversity_Ratio =
DIVIDE(
    CALCULATE([Active_Headcount], EmployeeMaster[GenderCode] = "Female"),
    [Active_Headcount],
    0
)
```

### Attrition

```DAX
Attrition_Rate_% = DIVIDE([Terminated_Count], [Total_Headcount], 0)
```
```DAX
YTD_Attrition_Pct =
VAR YTD_Terminations =
    TOTALYTD(
        CALCULATE(
            COUNTROWS(EmployeeMaster),
            USERELATIONSHIP(DimDate[Date], EmployeeMaster[DateOfTermination])
        ),
        DimDate[Date]
    )
VAR CalculatedPct = DIVIDE(YTD_Terminations, [Total_Headcount], BLANK())
RETURN
    IF(ISBLANK(CalculatedPct), 0, CalculatedPct)
```

### Compensation

```DAX
Average_Salary = AVERAGE(EmployeeMaster[Salary])
```
```DAX
Total_Payroll_Cost = SUM(EmployeeMaster[Salary])
```
```DAX
Dept_Avg_Salary_Benchmark =
CALCULATE(
    AVERAGE(EmployeeMaster[Salary]),
    ALLEXCEPT(EmployeeMaster, EmployeeMaster[DepartmentType])
)
```
```DAX
Salary_Rank_Dept =
RANKX(ALL(EmployeeMaster[DepartmentType]), [Average_Salary], , DESC, Dense)
```

### Performance

```DAX
Avg_Employee_Rating = AVERAGE(EmployeeMaster[Performance Score])
```
```DAX
High_Performing_Active_Count =
CALCULATE(
    COUNTROWS(EmployeeMaster),
    EmployeeMaster[IsActiveFlag] = 1,
    EmployeeMaster[Performance Score] = "Exceeds"
)
```
```DAX
High_Performers_Pct =
VAR CalculatedPct = DIVIDE([High_Performing_Active_Count], [Active_Headcount], BLANK())
RETURN
    IF(ISBLANK(CalculatedPct), 0, CalculatedPct)
```
```DAX
Bench_Utilisation_% =
DIVIDE(
    CALCULATE(
        [Active_Headcount],
        EmployeeMaster[EmployeeStatus] = "Active",
        EmployeeMaster[Performance Score] = "Needs Improvement"
    ),
    [Active_Headcount],
    0
)
```

### Training

```DAX
Avg_Training_Duration = AVERAGEX(Training, Training[Training Duration(Days)])
```
```DAX
Total_Cost_By_Duration =
SUMX(Training, Training[Training Cost] * Training[Training Duration(Days)])
```
```DAX
Training_Rank_Dept =
RANKX(ALL(EmployeeMaster[DepartmentType]), [Total_Cost_By_Duration], , DESC, Dense)
```

### Time intelligence (hiring)

```DAX
YTD_New_Hires =
TOTALYTD(COUNTROWS(EmployeeMaster), DimDate[Date], "03-31")
```
```DAX
New_Hires_LY =
CALCULATE(COUNTROWS(EmployeeMaster), SAMEPERIODLASTYEAR('DimDate'[Date]))
```
```DAX
YoY_Hiring_Change_Pct =
VAR CurrentHires = COUNTROWS(EmployeeMaster)
VAR LastYearHires = [New_Hires_LY]
RETURN
    DIVIDE(CurrentHires - LastYearHires, LastYearHires, 0)
```
```DAX
New_Hires_YoY_% =
VAR CurrentHires = COUNTROWS(EmployeeMaster)
VAR LastYearHires = [New_Hires_LY]
RETURN
    DIVIDE(CurrentHires - LastYearHires, LastYearHires, 0)
```
```DAX
Hires_3Months_Ago =
CALCULATE(COUNTROWS(EmployeeMaster), DATEADD(DimDate[Date], -3, MONTH))
```

### Where each measure is used

| Measure | Used in |
|---------|---------|
| Total_Headcount | Total Employees card, Annual Hiring chart |
| Active_Headcount | Active Employees card, Active Headcount by Department, Career Level donut, Performance matrix, Ranking table |
| Attrition_Rate_% | Attrition Rate cards (pages 1 and 2), Attrition Rate by Department |
| Average_Salary | Average Salary card, Average Salary by Department (pages 1 and 3), Ranking table |
| High_Performers_Pct | High Performers % card, Ranking table |
| Avg_Years_of_Service | Average Tenure card |
| Total_Cost_By_Duration | Training Investment card, Training cost per Department |
| Gender_Diversity_Ratio | Female % card |
| Salary_Rank_Dept | Tooltip of salary bar charts, Ranking table |
| Terminated_Count | Terminated Count card |
| YTD_Attrition_Pct | Year to Date Attrition card |
| YoY_Hiring_Change_Pct | New Hires change pct card |
| YTD_New_Hires | Year-to-Date New Hires by Month line chart |
| New_Hires_LY | Annual Hiring vs Same Period Last Year, column chart on page 2 |
| Total_Payroll_Cost, Unique_Departments, Avg_Employee_Rating, Bench_Utilisation_%, Avg_Training_Duration, Total_Headcount_All_Depts, Pct_of_Total_Headcount, Dept_Avg_Salary_Benchmark, Tenure_8Plus_Count, Training_Rank_Dept, Hires_3Months_Ago, New_Hires_YoY_% | Available for analysis (not placed on a visual) |

---

## Report Pages and Visuals

Page headers are text boxes at the top of each page.

### Page 1 – Workforce Overview

Header: *HR Workforce Analytics — Workforce Overview*

| # | Visual | Title | Fields |
|---|--------|-------|--------|
| 1 | Card | Total Employees | Total_Headcount |
| 2 | Card | Active Employees | Active_Headcount |
| 3 | Card | Attrition Rate | Attrition_Rate_% |
| 4 | Card | Average Salary | Average_Salary |
| 5 | Card | High Performers % | High_Performers_Pct |
| 6 | Card | Average Tenure (yrs) | Avg_Years_of_Service |
| 7 | Card | Training Investment | Total_Cost_By_Duration |
| 8 | Card | Female % | Gender_Diversity_Ratio |
| 9 | Clustered bar chart | Active Headcount by Department | Axis: DepartmentType · Values: Active_Headcount |
| 10 | Clustered bar chart | Average Salary by Department | Axis: DepartmentType · Values: Average_Salary · Tooltip: Salary_Rank_Dept |
| 11 | Clustered column chart | Annual Hiring vs Same Period Last Year | Axis: DimDate[Year] · Values: Total_Headcount, New_Hires_LY |
| 12 | Donut chart | Workforce by Career Level Band | Legend: Career_Level_Band · Values: Active_Headcount |
| 13 | Matrix | Performance Distribution by Department | Rows: DepartmentType · Columns: PerformanceLabel · Values: Active_Headcount |
| 14 | Slicer | – | DimDate[Year] |
| 15 | Slicer | – | DepartmentType |
| 16 | Slicer | – | Career_Level_Band |

### Page 2 – Attrition Analysis

Header: *HR Analytics — Attrition Analysis · Employee Attrition & Hiring Trends*

| # | Visual | Title | Fields |
|---|--------|-------|--------|
| 1 | Card | Attrition Rate | Attrition_Rate_% |
| 2 | Card | Terminated Count | Terminated_Count |
| 3 | Card | Year to Date Attrition_Pct | YTD_Attrition_Pct |
| 4 | Card | New Hires change pct | YoY_Hiring_Change_Pct |
| 5 | Clustered column chart | – | Axis: DimDate[Year] · Values: New_Hires_LY |
| 6 | Line chart | Year-to-Date New Hires by Month | Axis: DimDate[Month_Name] · Values: YTD_New_Hires |
| 7 | Clustered bar chart | Attrition_Rate by Department | Axis: DepartmentType · Values: Attrition_Rate_% |
| 8 | Slicer | – | DimDate[Year] |
| 9 | Slicer | – | DepartmentType |

### Page 3 – Compensation

Header: *Compensation · Salary Bands · Training Investment*

| # | Visual | Title | Fields |
|---|--------|-------|--------|
| 1 | Clustered bar chart | Average Salary by Department | Axis: DepartmentType · Values: Average_Salary · Tooltip: Salary_Rank_Dept |
| 2 | Table | Department Salary & Performance Ranking | DepartmentType, Active_Headcount, Average_Salary, Salary_Rank_Dept, High_Performers_Pct |
| 3 | Donut chart | Above/Below Salary | Legend: Above_Avg_Salary_Flag · Values: Count Distinct of Employee ID |
| 4 | Clustered bar chart | Training cost per Department | Axis: DepartmentType · Values: Total_Cost_By_Duration |
| 5 | Slicer | – | Career_Level_Band |
| 6 | Slicer | – | SalaryBand |

<img width="1150" height="650" alt="image" src="https://github.com/user-attachments/assets/d6b0f7bd-7969-4592-8737-ecbee8792cbb" />
<img width="1150" height="657" alt="image" src="https://github.com/user-attachments/assets/84314316-3134-43b1-9d11-09e9cec0866c" />
<img width="1128" height="611" alt="image" src="https://github.com/user-attachments/assets/779103d4-32be-4c7f-9b06-d4a0b00fc65c" />


---

## Key Concepts Demonstrated

- Star-style model with a custom date table and one active plus one inactive date relationship
- Context modification with `CALCULATE`, `ALL`, `ALLEXCEPT` and `FILTER`
- Iterators: `SUMX`, `AVERAGEX`
- Ranking with `RANKX`
- Time intelligence: `TOTALYTD`, `SAMEPERIODLASTYEAR`, `DATEADD`
- `USERELATIONSHIP` to use an inactive relationship in a measure
- Variables (`VAR` / `RETURN`) and safe division with `DIVIDE`
- Calculated columns with `SWITCH`

---


## Repository Structure

```
├── README.md
├── images/
│   ├── page1.png
│   ├── page2.png
│   └── page3.png
└── (PR__kenil.pbix and video hosted on Google Drive)
```
