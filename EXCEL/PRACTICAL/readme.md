# 🚴 Bike Buyers Excel Dashboard

An interactive Excel dashboard built on a 1,000-record bike buyers dataset,
featuring advanced formulas, pivot tables, and conditional formatting.

---

## 📁 Project Structure

| Sheet | Description |
|-------|-------------|
| `Dataset` | Raw data with 1,000 customer records + formula columns |
| `Pivot Table` | Summary analysis by Gender, Commute Distance, and Age Group |
| `Dashboard` | Visual Bike Sales Dashboard |

---

## 📊 Dataset Overview

**Source:** Bike Buyers Dataset  
**Records:** 1,000 customers  
**Columns:** 14

| Column | Description |
|--------|-------------|
| ID | Unique customer identifier |
| Marital Status | M = Married, S = Single |
| Gender | M = Male, F = Female |
| Income | Annual income in USD |
| Children | Number of children |
| Education | Highest education level |
| Occupation | Job category |
| Home Owner | Yes / No |
| Cars | Number of cars owned |
| Commute Distance | Daily commute range |
| Region | Europe / Pacific / North America |
| Age | Customer age |
| Purchased Bike | Yes / No (target variable) |
| categorize_age | Young / Middle Age / Senior |

---

## 🔢 Advanced Formulas Used

### 1. VLOOKUP
Looks up a Customer ID and retrieves their details.

```excel
=VLOOKUP($A$7, Table2, 4, FALSE)
```
Used to fetch: Gender, Income, Education, Occupation, Region, Age, Purchased Bike

---

### 2. INDEX & MATCH
More flexible alternative to VLOOKUP — works in any direction.

```excel
=INDEX(Table2[Income], MATCH($A$7, Table2[ID], 0))
```
Used for: two-way dynamic lookup, retrieving any column by header name

---

### 3. Nested Functions

**Nested IF — Income Tier Classification:**
```excel
=IF(D2>=100000,"High", IF(D2>=50000,"Medium","Low"))
```

**IF + AND — Premium Customer Check:**
```excel
=IF(AND(Income>=80000, HomeOwner="Yes"), "Premium", "Standard")
```

**IF + OR — Age Group Flag:**
```excel
=IF(OR(categorize_age="Young", categorize_age="Senior"), "Edge Group", "Middle Age")
```

**COUNTIFS — Multi-condition Count:**
```excel
=COUNTIFS(Table2[Region],"Pacific", Table2[Purchased Bike],"Yes")
```

**AVERAGEIFS — Avg Income by Segment:**
```excel
=AVERAGEIFS(Table2[Income], Table2[categorize_age],"Middle Age",
            Table2[Region],"Europe", Table2[Purchased Bike],"Yes")
```

---

## 🎨 Conditional Formatting Applied

| Rule | Format |
|------|--------|
| Purchased Bike = "Yes" | 🟢 Green row highlight |
| Purchased Bike = "No" | 🔴 Red row highlight |
| Income category | 🔢 Icon Set (arrows) |

---

## 📈 Pivot Table Insights

**Average Income by Gender & Purchase:**
- Female buyers avg income: ~$55,774
- Male buyers avg income: ~$60,124

**Purchase Rate by Commute Distance:**
- 0-1 Miles: highest buyers (200 Yes)
- 10+ Miles: lowest buyers (33 Yes)

**Purchase Rate by Age Group:**
- Middle Age (31-54): most purchases (383 Yes)
- Young (0-30): fewest purchases (39 Yes)

---

## 🛠️ Tools Used

- Microsoft Excel
- Pivot Tables
- Advanced Formulas (VLOOKUP, INDEX/MATCH, IF, COUNTIFS, AVERAGEIFS)
- Conditional Formatting

---
