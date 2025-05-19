# R-Training-3: Data Visualisation with R ####
# Prepared by Data Avicenna

# Base R Plotting ####

# Load a sample dataset
# library(datasets)
data(mtcars)
data(iris)

head(iris)
head(mtcars)

# Simple plots using plot()
plot(iris$Species) # Categorical variable
plot(iris$Petal.Length) # Quantitative variable
plot(iris$Species, iris$Petal.Width) # Cat x quant
plot(iris$Petal.Length, iris$Petal.Width) # Quant pair (scatterplot)
plot(iris) # Scatterplot of all variables

# Simple scatter plot with options
plot(mtcars$wt, mtcars$mpg, 
     main = "Car Weight vs. Mileage",   # Title of the plot
     xlab = "Weight (1000 lbs)",        # Label for horizontal axis
     ylab = "Miles Per Gallon",         # Label for vertical axis
     pch = 1,                           # Type of plot points
     col = "blue")                      # Colors of points

# Histogram
hist(mtcars$mpg, 
     breaks = 10,
     col = "skyblue", 
     main = "Distribution of MPG", 
     xlab = "Miles Per Gallon")

# Box plot
boxplot(mpg ~ cyl, data = mtcars,
        col = "lightgreen",
        main = "MPG by Number of Cylinders",
        xlab = "Cylinders",
        ylab = "Miles Per Gallon")

# Create a table of frequencies
cylinders <- table(mtcars$cyl)
cylinders

# Bar plot
barplot(cylinders,
        main = "Number of Cars by Cylinder Count",
        xlab = "Number of Cylinders",
        ylab = "Frequency",
        col = "salmon")

# Line plots in Base R
# Create some time series data
time <- 1:20
values <- rnorm(20) # Generates 20 random numbers from a standard normal dist (mean = 0, SD = 1)

# Line plot
plot(time, values, 
     type = "l", 
     col = "purple", 
     lwd = 2,
     main = "Time Series Example", 
     xlab = "Time", 
     ylab = "Value")

# Add points to the line
points(time, values, pch = 19, col = "darkblue")

# Create a 2x2 grid of plots
par(mfrow = c(2, 2))

# Plot 1: Scatter plot
plot(mtcars$wt, mtcars$mpg, main = "Weight vs MPG", pch = 1)

# Plot 2: Histogram
hist(mtcars$mpg, main = "MPG Distribution")

# Plot 3: Box plot
boxplot(mtcars$mpg, main = "MPG Box Plot")

# Plot 4: Bar plot
barplot(table(mtcars$cyl), main = "Cylinders")

# Reset to 1x1 layout
par(mfrow = c(1, 1))

# Descriptive Statistics ####

setwd("/Users/dataavicenna/Library/CloudStorage/OneDrive-Personal/Training/R-Training-2025/datasets")
library(readxl)
smoking_df <- read_excel("smoking.xlsx")

# install.packages("modelsummary")
library(modelsummary)
datasummary_skim(smoking_df)

# Cross Tabulations
datasummary_crosstab(female ~ smoker, data = smoking_df)

male_smokers <- filter(smoking_df, female==0) %>%
  summarize(
    mean(smoker)*100
  )
male_smokers

# ggplot2 ####
ggplot(data = mtcars,
       mapping = aes(x = wt, y = mpg)) +
  geom_point() 
  
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point(color = "blue") + # 1: scatter plot
  geom_smooth(method = "lm", se = FALSE, color = "red") + # 2: regression line
  labs(title = "MPG vs Weight", x = "Weight", y = "Miles per Gallon") # 3: labels


# install.packages("palmerpenguins")
library(palmerpenguins)
# color dots according to number of species

ggplot(penguins, aes(x = bill_length_mm, 
                     y = bill_depth_mm,
                     colour = species)) +
  geom_point()

ggplot(penguins, aes(x = bill_length_mm, 
                     y = bill_depth_mm, 
                     color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# bar charts
ggplot(penguins, aes(year)) +
  geom_bar()

penguins %>%
  count(year)

ggplot(penguins, aes(year)) +
  geom_bar(aes(fill = species))

ggplot(penguins, aes(year, fill = species)) +
  geom_bar(position = "stack")

ggplot(penguins, aes(year, fill = species)) +
  geom_bar(position = "dodge")

ggplot(penguins, aes(year, fill = species)) +
  geom_bar(position = "fill")
  
# facet wrap
# create base plot
bill_plot <- ggplot(penguins, aes(bill_length_mm, bill_depth_mm)) +
  geom_point()

bill_plot +
  facet_wrap(~species)

# facet grid
bill_plot +
  facet_wrap(island~species)

# Plots for publication ####
bill_plot <- ggplot(penguins, aes(bill_length_mm, bill_depth_mm)) +
  geom_point(aes(color = species))

bill_plot <- bill_plot + 
  labs(
    title = "Correlation between bill length and bill depth",
    subtitle = "Species seem to matter",
    y = "Bill depth (mm)",
    x = "Bill length (mm)",
    color = "Species",
    caption = "Source: palmerpenguins"
  ) 

bill_plot

# Saving figures

# create new folder for plots
fs::dir_create("figures")

# save as pdf (vector graphic)
ggsave("figures/plot.pdf", bill_plot)

# save as png (raster graphic)
ggsave("figures/plot.png", bill_plot)
