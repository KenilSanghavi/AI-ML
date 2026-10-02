# 🎓 Student Performance & Behavior Analytics Dashboard

An interactive **Power BI** report that analyzes student academic performance, attendance and classroom behavior across classes, sections, subjects and terms.

---

## 📸 Dashboard Preview

<img width="1143" height="642" alt="image" src="https://github.com/user-attachments/assets/2c9779e2-7c6c-45ec-b40c-bb85bbb8384c" />
<img width="1152" height="668" alt="image" src="https://github.com/user-attachments/assets/42638773-b009-4701-a333-a23530cfbb34" />
<img width="1097" height="632" alt="image" src="https://github.com/user-attachments/assets/66955a3b-207a-4f7f-b067-9020e9fbb251" />
<img width="488" height="358" alt="image" src="https://github.com/user-attachments/assets/c8d91e72-9630-47c7-876c-68f8f1308f0d" />


---

## 📌 Project Overview

School data is spread across four separate files. This project combines them into one data model and builds an interactive dashboard that helps answer:

- How are students performing in each subject and class?
- How does performance change from Term 1 to Term 3?
- How regular is student attendance?
- Which behavior types are most common?
- How is an individual student doing overall?

---

## 🗂️ Dataset

| File | Rows | Description |
|------|------|-------------|
| `students.csv` | 1,000 | StudentID, Name, Gender, Class (1–12), Section (A–C) |
| `Scores.csv` | 30,000 | StudentID, Subject, Exam Type, Score, Max Score, Term |
| `attendance.csv` | 100,000 | StudentID, Date, Status (Present/Absent), Reason |
| `behaviour.csv` | 6,500 | StudentID, Date, Behavior Type, Notes |

**Subjects:** Math, Science, English, History, Geography
**Exam types:** Unit Test, Mid Term, Final Exam
**Behavior types:** Disruptive, Late, Helpful, Participative, Absent without notice

---

## 🧹 Data Cleaning & Modeling

- Loaded all four datasets in Power Query.
- Corrected data types (dates parsed with the English (US) locale, scores as whole numbers).
- Renamed columns for clean, readable names.
- Replaced blank `Reason` values (present days) with `Not Applicable`.
- No other missing values were found.
- Built a **star-style model**: `students` is the dimension table and has a one-to-many relationship (on `StudentID`) to `Scores`, `attendance` and `behaviour`.


---

## 🧮 DAX Measures

```DAX
% Score = DIVIDE ( SUM ( Scores[Score] ), SUM ( Scores[Max Score] ) )

Avg Score per Subject = AVERAGE ( Scores[Score] )

Attendance % =
DIVIDE (
    CALCULATE ( COUNTROWS ( attendance ), attendance[Status] = "Present" ),
    COUNTROWS ( attendance )
)

Behavior Count = COUNTROWS ( behaviour )

Total Students = DISTINCTCOUNT ( students[StudentID] )

Performance Category =
SWITCH (
    TRUE (),
    [% Score] >= 0.6, "High",
    [% Score] >= 0.4, "Medium",
    "Low"
)

Student Header =
"Student Profile: " & SELECTEDVALUE ( students[Name], "All Students" )
```

---

## 📊 Report Pages & Visuals

### 1. Dashboard (Academic and Behavioral views)
- **KPI cards:** Total Students, Average Attendance, Average Score
- **Bar chart:** Average score by Subject and Class
- **Line chart:** Performance trend by Term
- **Student table:** Scores with conditional formatting (🟢 green for > 80%, 🔴 red for < 40%)
- **Donut chart:** Behavior types distribution
- **Slicers:** Class, Section, Subject, Term

### 2. Student Profile (Drillthrough)
Right-click any student in the table → **Drill through** to see that student's score, attendance, subject-wise performance, term trend and a dynamic header.

### 3. Tooltip Page
A custom tooltip with a mini term trend chart and key metrics that appears when hovering over the charts.

---

## 🖱️ Interactivity

- **Slicers** for Class, Section, Subject and Term
- **Drillthrough** to an individual student profile
- **Custom tooltips** with mini charts and metrics
- **Bookmark navigation** to switch between the Academic and Behavioral views

---



## 🔍 Key Insights

- Overall average score is about **50 / 100**, so most students fall in the *Medium* category.
- Average attendance is about **90%**.
- Behavior records are spread almost evenly across all five types, with no single behavior dominating.
- *(Add 2–3 insights of your own after checking the slicers, for example the best and weakest subject and the term trend.)*

---

## 🛠️ Tools Used

- Power BI Desktop
- Power Query
- DAX

---

## 📁 Repository Structure

```
├── FINAL_PROJECT_kenil.pbix
├── README.md
├── data/
│   ├── students.csv
│   ├── Scores.csv
│   ├── attendance.csv
│   └── behaviour.csv
└── images/
    ├── 01-dashboard-academic.png
    ├── 02-dashboard-behavioral.png
    ├── 03-student-profile.png
    ├── 04-tooltip.png
```

---

## ▶️ How to Open

1. Download `FINAL_PROJECT_kenil.pbix`.
2. Open it in **Power BI Desktop**.
3. If prompted, update the data source paths to the files in the `data/` folder.

---

## 👤 Author

**Kenil Sanghavi**
GitHub: [KenilSanghavi](https://github.com/KenilSanghavi)
