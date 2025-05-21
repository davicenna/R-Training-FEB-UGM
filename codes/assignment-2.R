# Assignment 2 ####
# Prepared by Data Avicenna

# Q1 ####
# Import data
library(readxl)
smoking_df <- read_excel("Smoking.xlsx")

# Create a variable for education level as a single coded variable
smoking_df <- mutate(smoking_df,
                     edu_level = case_when(
                       hsdrop == 1 ~ 1,
                       hsgrad == 1 ~ 2,
                       colsome == 1 ~ 3,
                       colgrad == 1 ~ 4,
                       TRUE ~ 5  # For higher degrees
                       ))

education_labels <- tibble(
  edu_level = c(1, 2, 3, 4),
  edu_desc = c("High School Dropout", "High School Graduate",
                  "Some College", "College Graduate")
)

smoking_with_edu <- smoking_df %>% left_join(education_labels, by = "edu_level")

smoking_with_edu$edu_desc <- factor(smoking_with_edu$edu_desc)

smoking_with_edu # Print data
View(smoking_with_edu) # View data

# Q2 ####
mutate(smoking_df, 
       male_smoker = case_when (smoker==1 & female==0 ~ 1, 
                                  TRUE ~ 0))
smoking_df
mean(male_smoker) * 100