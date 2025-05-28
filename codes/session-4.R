# install.packages("AER")
# Load necessary libraries
library(AER)  # For datasets
library(ggplot2)  # For visualization

# Load the CASchools dataset
data(CASchools)

# Create student-teacher ratio and test score variables
CASchools$STR <- CASchools$students/CASchools$teachers
CASchools$score <- (CASchools$read + CASchools$math)/2

# Fit a simple linear regression model
SLR <- lm(score ~ STR, data = CASchools)

# View a summary of the model
summary(SLR)

# Basic scatter plot with regression line
plot(CASchools$STR, CASchools$score,
     main = "Test Score vs. Student-Teacher Ratio",
     xlab = "Student-Teacher Ratio (STR)",
     ylab = "Test Score",
     pch = 20, col = "steelblue")

# Add the regression line
abline(SLR, col = "red", lwd = 2)

# Alternative using ggplot2
ggplot(CASchools, aes(x = STR, y = score)) +
  geom_point(color = "steelblue") +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(title = "Test Score vs. Student-Teacher Ratio",
       x = "Student-Teacher Ratio (STR)",
       y = "Test Score")

# Store the model summary
model_summary <- summary(SLR)

# Coefficients
model_summary$coefficients

# Extracting specific values
beta_0 <- coef(SLR)[1]  # Intercept
beta_1 <- coef(SLR)[2]  # Slope
std_errors <- coef(summary(SLR))[, 2]  # Standard errors
t_values <- coef(summary(SLR))[, 3]  # t-values
p_values <- coef(summary(SLR))[, 4]  # p-values

# Model fit statistics
r_squared <- model_summary$r.squared
adj_r_squared <- model_summary$adj.r.squared
residual_se <- model_summary$sigma


# Multiple regression with STR and english
MLR <- lm(score ~ STR + english, data = CASchools)

# Summary of the model
summary(MLR)

# Compare with simple regression
summary(SLR)

# Add more variables to the model
model_expanded <- lm(score ~ STR + english + lunch, data = CASchools)

summary(model_expanded)

# Create a dummy variable for high STR
CASchools$high_STR <- ifelse(CASchools$STR > median(CASchools$STR), 1, 0)

# Regression with dummy variable
model_dummy <- lm(score ~ high_STR, data = CASchools)
summary(model_dummy)

# install.packages("stargazer")
# Using stargazer for publication-quality tables
library(stargazer)
models <- list(SLR, MLR, model_expanded)

stargazer(models, 
          title = "Test Score Regression Results",
          column.labels = c("Simple", "With English", "Full Model"),
          covariate.labels = c("Student-Teacher Ratio", 
                               "% English Learners", "% Free Lunch"),
          dep.var.labels = "Test Score",
          type = "html",
          out = "table.html",           # Open in browser, copy to Word
          digits = 3,
          star.cutoffs = c(0.05, 0.01, 0.001))

# LaTeX output (for academic papers)
stargazer(models, 
          title = "Regression Results",
          column.labels = c("Model 1", "Model 2", "Model 3"),
          covariate.labels = c("Student-Teacher Ratio", "% English Learners",
                               "% Free Lunch"),
          dep.var.labels = "Test Score",
          type = "latex")


