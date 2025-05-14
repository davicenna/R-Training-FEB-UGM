# R-Training-2 ####
# Prepared by Data Avicenna

# Matrices ####

# Method 1: From a vector with matrix() function
vec <- 1:12
mat1 <- matrix(vec, nrow = 4, ncol = 3)
mat1

# Method 2: By binding vectors together
x <- c(1, 2, 3, 4)
y <- c(5, 6, 7, 8)
z <- c(9, 10, 11, 12)

# Column binding
mat2 <- cbind(x, y, z)
mat2

# Row binding
mat3 <- rbind(x, y, z)
mat3

# Method 3: Changing dimensions of a vector
vec2 <- 1:9
dim(vec2) <- c(3, 3)  # Converts vector to a 3x3 matrix
vec2

# Matrix Options
# Data is filled by column by default
matrix(1:6, nrow = 2, ncol = 3)

# Fill by row instead
matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)

# Create a matrix with specific values
matrix(0, nrow = 3, ncol = 4)  # Matrix of zeros

# Accessing elements, rows, or columns in a matrix:
mat <- matrix(1:9, nrow = 3, ncol = 3)
mat

# Entire second row
mat[2, ]

# Entire third column
mat[, 3]  

# Individual element at row 2, column 3
mat[2, 3]


# Matric Operations
A <- matrix(1:4, nrow = 2)
B <- matrix(5:8, nrow = 2)

# Element-wise operations
A + B       # Addition
A * B       # Element-wise multiplication

# Matrix multiplication
A %*% B # True matrix multiplication

# Transpose
t(A)

# Matrix diagonal
diag(A)     

# Create diagonal matrix
diag(1, 3)    # 3x3 identity matrix

# Matrix inversion (requires square matrix)
C <- matrix(c(3, 1, 2, 4), nrow = 2)
solve(C)      # Inverse of matrix C


# Matrix Functions
mat <- matrix(1:9, nrow = 3)

# Dimensions
dim(mat)      # [1] 3 3
nrow(mat)     # [1] 3
ncol(mat)     # [1] 3

# Row and column names
rownames(mat) <- c("row1", "row2", "row3")
colnames(mat) <- c("col1", "col2", "col3")

# Apply functions to rows or columns
rowSums(mat)  # [1] 12 15 18
colMeans(mat) # [1] 2 5 8

# Apply any function to rows or columns
apply(mat, 1, sum)    # Apply sum to rows (margin = 1)
apply(mat, 2, min)    # Apply min to columns (margin = 2)


# Data Frames ####

# Creating a basic data frame
economic_data <- data.frame(
  country = c("Indonesia", "Malaysia", "Thailand",
              "Vietnam"),
  gdp_billion = c(1119, 364, 505, 261),
  population_million = c(270, 32, 70, 97),
  inflation_rate = c(3.2, 2.8, 1.7, 4.1)
)
# View the data frame
economic_data
View(economic_data)
# Check the structure
str(economic_data)
# Access a column using $ notation
economic_data$country
# Access a column using bracket notation
economic_data[, "gdp_billion"]
# Access a row
economic_data[2, ]
# Access a specific element
economic_data[3, "inflation_rate"]
# Multiple rows or columns
economic_data[1:2, c("country", "gdp_billion")]

# Manipulating Data Frames
# Add a new column
economic_data$gdp_per_capita <- 
  economic_data$gdp_billion * 1e9 / 
  (economic_data$population_million * 1e6)

# Modify values
economic_data$inflation_rate[1] <- 3.5  # Update Indonesia's inflation rate

# Add a new row
new_country <- data.frame(
  country = "Philippines",
  gdp_billion = 331,
  population_million = 110,
  inflation_rate = 4.5,
  gdp_per_capita = 331 * 1e9 / (110 * 1e6)
)

economic_data <- rbind(economic_data, new_country)

# Data Frame Operations
# Sorting a data frame
sorted_by_gdp <- 
  economic_data[order(economic_data$gdp_billion, 
                      decreasing = TRUE), ]

# Filtering rows based on conditions
high_inflation <-
  economic_data[economic_data$inflation_rate > 3, ]

# Select subset of columns
gdp_data <- economic_data[, c("country",
                              "gdp_billion", "gdp_per_capita")]

# Summary statistics
summary(economic_data)

# Number of rows and columns
dim(economic_data)  
nrow(economic_data) 
ncol(economic_data) 

# Built-in Data Sets in R
# List all available datasets
data()

# Load a dataset into your environment
data(mtcars)  # Motor Trend Car Road Tests
head(mtcars)


# Importing Data ####

# Set working directory
setwd("")

# Using base R
smoking_df <- read.csv("Smoking.csv")

# Common parameters
smoking_df <- read.csv("Smoking.csv", 
                       header = TRUE, # First row contains headers
                       sep = ";", # Delimiter (semi-colon)
                       )
# Check number of observations and variables
dim(smoking_df) 

# Using readr package from tidyverse
# install.packages("tidyverse")
# install.packages("readr")
library(tidyverse) # Or alternatively, library(readr)
smoking_df <- read_delim("Smoking.csv")

# Using readxl package
# install.packages("readxl")
library(readxl)

# Basic import
smoking_df_xl <- read_excel("smoking.xlsx")

# We can also specify the sheet if there are multiple sheets
smoking_df_xl <- read_excel("smoking.xlsx", sheet = 1)

# Compare dimensions of our imported data
dim(smoking_df)     # From CSV
dim(smoking_df_xl)  # From Excel
# Should be the same: [1] 10000    10

# Using haven package
# install.packages("haven")
library(haven)

# Import Stata file
smoking_df_dta <- read_dta("Smoking.dta")


# The Tidyverse ####

# Install the complete tidyverse (one-time setup)
# install.packages("tidyverse")

# Or install individual packages as needed
# install.packages("dplyr")
# install.packages("tidyr")

# Load the entire tidyverse
library(tidyverse)

# Or load individual packages
library(dplyr)
library(tidyr)

# Tibble ####
# Let's use our smoking dataset for all examples
# Convert to a tibble for better printing
smoking_df <- as_tibble(smoking_df)
smoking_df # Print data frame

# Filter() ####
# 1. filter() - subset rows based on values

# Find only smokers
smokers <- filter(smoking_df, smoker == 1)
dim(smokers)  # Should have fewer rows than the original dataset

# Find smokers who are subject to workplace smoking bans
banned_smokers <- filter(smoking_df, smoker == 1 & smkban == 1)

# Find female smokers with at least some college education
female_educated_smokers <- filter(smoking_df, 
                                  smoker == 1,
                                  female == 1,
                                  colsome == 1 | colgrad == 1)

# Select() ####
# 2. select() - select columns

# Select only demographic variables
demographics <- select(smoking_df, age, female, black, hispanic)
head(demographics)

# Select variables related to education
education <- select(smoking_df, hsdrop, hsgrad, colsome, colgrad)
head(education)

# You can also exclude columns with -
no_race <- select(smoking_df, -black, -hispanic)
head(no_race)

# Select columns that match a pattern
education_vars <- select(smoking_df, starts_with("hs"), starts_with("col"))
head(education_vars)

# Arrange() ####
# 3. arrange() - reorder rows

# Sort by age (youngest first)
youngest_first <- arrange(smoking_df, age)
head(youngest_first)

# Sort by age (oldest first)
oldest_first <- arrange(smoking_df, desc(age)) # desc = descending
head(oldest_first)

# Sort by multiple columns: education level then age
educated_by_age <- arrange(smoking_df, 
                           desc(colgrad), 
                           desc(colsome), 
                           desc(hsgrad), 
                           age)
View(educated_by_age)

# Mutate() ####
# 4. mutate() - create new variables

# Create an age category variable
smoking_with_age_cat <- mutate(smoking_df,
                               age_category = case_when(
                                 age < 30 ~ "Young",
                                 age < 50 ~ "Middle",
                                 TRUE ~ "Senior" # default case, for all other individuals not previously identified
                               ))
# Convert string variables of the catagories as factors
smoking_with_age_cat$age_category <- factor(smoking_with_age_cat$age_category)
class(smoking_with_age_cat$age_category)
# Check the generated age categories
levels(smoking_with_age_cat$age_category)
# View all observations of 2 variables
View(smoking_with_age_cat[, c("smoker", "age_category")])

# Summarize()
# 5. summarize() - reduce multiple values to a single summary

# Overall smoking rate
smoking_rate <- summarize(smoking_df,
                          pct_smokers = (sum(smoker==1)/n()) * 100,
                          count = n())
smoking_rate

# Often used with group_by() for group summaries
by_gender <- group_by(smoking_df, female)
gender_summary <- summarize(by_gender,
                            pct_smokers = (sum(smoker==1)/n()) * 100,
                            avg_age = mean(age),
                            pct_banned = (sum(smkban==1)/n()) * 100,
                            count = n())
gender_summary

# The Pipe operator %>% ####
# Without pipes
banned_smokers_age <- filter(smoking_df, smkban == 1, smoker == 1)
banned_smokers_age <- select(banned_smokers_age, age)
banned_smokers_age <- summarize(banned_smokers_age, 
                                mean(age))
banned_smokers_age

# With pipes
banned_smokers_age <- smoking_df %>%
  filter(smkban == 1, smoker == 1) %>%
  select(age) %>%
  summarize(mean(age))

banned_smokers_age

# The pipe takes the output from one function and passes it 
# as the first argument to the next function

# Complex analysis with pipes %>%
# Smoking rates by gender and education level
smoking_by_demo <- smoking_df %>%
  # Group by gender and education level
  group_by(female, colgrad) %>%
  # Calculate summary statistics for each group
  summarize(
    avg_age = mean(age),
    smoking_rate = mean(smoker) * 100,
    ban_rate = mean(smkban) * 100,
    count = n()
  ) %>%
  # Sort by smoking rate
  arrange(desc(smoking_rate))

# View results
smoking_by_demo

# Data Reshaping with tidyr ####
# First, create a summary by gender and education
education_summary <- smoking_df %>%
  group_by(female, hsdrop, hsgrad, colsome, colgrad) %>%
  summarize(
    smoking_rate = mean(smoker) * 100,
    count = n()
  ) %>%
  ungroup() # optional


# Convert from multiple education columns to a single column
edu_long <- education_summary %>%
  pivot_longer(
    cols = c(hsdrop, hsgrad, colsome, colgrad), # columns to collapse
    names_to = "education_level",    # new column with the level name
    values_to = "is_level"     # new column that holds the 0/1 values
  ) %>%
  filter(is_level == 1) %>%  # Keep only the actual education level
  select(-is_level)          # Remove the indicator column

# Merging Data with dplyr ####
# Create a small dataset with education descriptions
education_labels <- tibble(
  education_level = c("hsdrop", "hsgrad", "colsome", "colgrad", "higher"),
  description = c("High School Dropout", "High School Graduate", 
                  "Some College", "College Graduate", 
                  "Post-Graduate Degree"),
  years_edu = c(10, 12, 14, 16, 18)
)

# Merge our long education data with the labels
edu_labeled <- edu_long %>%
  left_join(education_labels, by = "education_level")

# Now we have both the smoking rates and the education descriptions
edu_labeled
