
data <- read.csv(file.choose(),skip=1)

#step 2

main_model <- lm(FullTimeTotalGoals ~ TotalShots, data = data)

summary(main_model)

confint(main_model, "TotalShots", level = 0.95)

#step 3

additional_model <- lm(FullTimeTotalGoals ~ TotalCorners, data = data)

summary(additional_model)

confint(additional_model, "TotalCorners", level = 0.95)

#step 4

par(mfrow = c(3, 1))

x_model <- model.frame(main_model)$TotalShots
y_model <- model.frame(main_model)$FullTimeTotalGoals
fitted_model <- predict(main_model)
residuals_model <- residuals(main_model)

# גרף 1: דיאגרמת פיזור של שערים מול בעיטות + קו הרגרסיה באדום
plot(x_model, y_model, 
     main = "Scatter Plot with Fitted Line",
     xlab = "Total Shots", ylab = "Total Goals", 
     pch = 20, col = "darkgray")
abline(main_model, col = "red", lwd = 2)

# גרף 2: גרף שאריות מול ערכים מנובאים
plot(fitted_model, residuals_model,
     main = "Residuals vs Fitted",
     xlab = "Fitted Values", ylab = "Residuals",
     pch = 20, col = "blue")
abline(h = 0, col = "red", lty = 2)

# גרף 3: גרף שאריות מול המשתנה המסביר (הבעיטות)
plot(x_model, residuals_model,
     main = "Residuals vs Total Shots",
     xlab = "Total Shots", ylab = "Residuals",
     pch = 20, col = "darkgreen")
abline(h = 0, col = "red", lty = 2)

par(mfrow = c(1, 1))


# --- שאלה 2: Data Cleaning and Summary Statistics ---

# 1+2. Data Cleaning
# נסנן רק את העמודות שאנחנו צריכים למודל כדי לא לאבד תצפיות בגלל משתנים אחרים
library(dplyr)
analysis_data <- data %>%
  select(FullTimeTotalGoals, TotalShots, TotalCorners, TotalRedCards) %>%
  # הסרת שורות עם ערכים חסרים (NA) במשתנים הספציפיים שלנו
  na.omit() %>%
  # הסרת ערכים בלתי אפשריים (שערים, בעיטות, קרנות או אדומים קטנים מאפס)
  filter(FullTimeTotalGoals >= 0, 
         TotalShots >= 0, 
         TotalCorners >= 0, 
         TotalRedCards >= 0)

# חישוב כמה תצפיות נמחקו
original_n <- nrow(data)
clean_n <- nrow(analysis_data)
removed_n <- original_n - clean_n
cat("Number of observations removed:", removed_n, "\n")
cat("Final number of observations (N):", clean_n, "\n\n")

# 3. Summary Statistics
# שימוש בפונקציה sapply כדי לחשב את כל המדדים לכל המשתנים
summary_stats <- data.frame(
  Mean = sapply(analysis_data, mean),
  SD = sapply(analysis_data, sd),
  Min = sapply(analysis_data, min),
  Max = sapply(analysis_data, max),
  N = rep(clean_n, ncol(analysis_data))
)

# הצגת הטבלה
print(summary_stats)



# --- שאלה 2.4: ויזואליזציה של ההתפלגויות ---

install.packages(c("ggplot2", "patchwork"))
library(ggplot2)
library(patchwork)

# פונקציית עזר ליצירת גרף התפלגות מעוצב
create_dist_plot <- function(data, var, title, x_label) {
  ggplot(data, aes_string(x = var)) +
    # היסטוגרמה (עם צבע מילוי בהיר וגבולות כהים)
    geom_histogram(aes(y = ..density..), 
                   binwidth = ifelse(var == "TotalRedCards", 1, 2), # התאמת רוחב הבין
                   fill = "skyblue", color = "black", alpha = 0.7) +
    # קו צפיפות (Density curve) בצבע בולט
    geom_density(color = "red", size = 1) +
    # עיצוב כללי
    labs(title = title, x = x_label, y = "Density") +
    theme_minimal() +
    theme(title = element_text(size = 12, face = "bold"))
}

# יצירת הגרפים הבודדים
p1 <- create_dist_plot(analysis_data, "FullTimeTotalGoals", "התפלגות סך השערים", "שערים למשחק")
p2 <- create_dist_plot(analysis_data, "TotalShots", "התפלגות סך הבעיטות", "בעיטות למשחק")
p3 <- create_dist_plot(analysis_data, "TotalCorners", "התפלגות סך הקרנות", "קרנות למשחק")
p4 <- create_dist_plot(analysis_data, "TotalRedCards", "התפלגות סך הכרטיסים האדומים", "כרטיסים אדומים למשחק")

# שילוב הגרפים לתמונה אחת (מטריצה של 2x2)
combined_plot <- (p1 | p2) / (p3 | p4)

# הוספת כותרת ראשית לתמונה המאוחדת
combined_plot + plot_annotation(
  title = 'ויזואליזציה של התפלגות המשתנים במודל',
  theme = theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5))
)


# --- שאלה 3: Multiple Linear Regression ---

# 1. הרצת מודל הרגרסיה המרובה עם המשתנה העיקרי ושני משתני הבקרה
mult_model <- lm(FullTimeTotalGoals ~ TotalShots + TotalCorners + TotalRedCards, data = analysis_data)

# 2. הצגת תוצאות המודל (מקדמים, שגיאות תקן, p-values, ו-R-squared)
summary(mult_model)

# 3. חישוב רווחי סמך של 95% לכל המקדמים במודל
confint(mult_model, level = 0.95)
