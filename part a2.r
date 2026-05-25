
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