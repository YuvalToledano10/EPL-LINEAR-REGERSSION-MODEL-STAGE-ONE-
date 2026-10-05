## 👥 כותבי הפרויקט# ⚽ What Drives Goals in the Premier League? A Linear Regression Analysis

A statistical modeling project in **R** that uses multiple linear regression to measure how different match variables affect the number of goals scored in English Premier League (EPL) matches.

> Team project for the Statistical Models course, Ben-Gurion University of the Negev.

---

## 🎯 Research Question

Which match-level factors are associated with the number of goals scored, and how strong is each effect?

## 📊 Data

| | |
|---|---|
| **Source** | [e.g. football-data.co.uk / Kaggle — add source + link] |
| **Scope** | [e.g. EPL seasons 2018/19–2022/23, N matches] |
| **Target variable** | Goals scored per match |
| **Explanatory variables** | [e.g. shots, shots on target, possession, corners, fouls, home/away] |

## 🔬 Methodology

1. **Data preparation:** cleaning, handling missing values and building the analysis dataset.
2. **Exploratory analysis:** distributions of the variables and correlations with goals scored.
3. **Model building:** fitting a multiple linear regression model and selecting the final set of variables.
4. **Model evaluation:** checking regression assumptions (linearity, normality and homoscedasticity of residuals) and model fit.
5. **Interpretation:** translating the coefficients into football insights.

## 📈 Key Findings

- [Finding 1 — e.g. each additional shot on target is associated with +0.XX goals, p < 0.001]
- [Finding 2 — e.g. home advantage adds about 0.XX goals per match]
- [Finding 3 — e.g. possession was not a significant predictor once shots were controlled for]
- **Model fit:** R² = [0.XX], Adjusted R² = [0.XX]

<!-- Add 1–2 plots here, e.g.:
![Correlation matrix](figures/correlation_matrix.png)
![Residual diagnostics](figures/residuals.png)
-->

## 📁 Repository Structure

```
├── part_a_analysis.R    # Data preparation and exploratory analysis
├── part_b_model.R       # Regression model, diagnostics and results
├── report.pdf           # Full project report
└── README.md
```

## ▶️ How to Run

1. Install R (≥ 4.0) and the required packages:
   ```r
   install.packages(c("tidyverse", "car", "ggplot2"))  # adjust to the packages you used
   ```
2. Place the dataset in the project folder.
3. Run `part_a_analysis.R`, then `part_b_model.R`.

## 🛠 Tools

R · Linear regression · Statistical inference · Data visualization

## 👥 Contributors

- **Yuval Toledano** — [GitHub](https://github.com/YuvalToledano10)
- **Yuval Matyovis** — [GitHub](https://github.com/YuvalMatyovis) / Contributors
* **Yuval Toledano**  - (https://github.com/YuvalToledano10)
* **yuval matyovis** - (https://github.com/YuvalMatyovis)
