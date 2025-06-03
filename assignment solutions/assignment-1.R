# Assignment 1 ####
# Prepared by Data Avicenna

# Q1
A <- 0:1000
mean(A)
sd(A)
median(A)

# Q2
# a)
gdp_growth <- c(2.1, 2.5, 3.0, 2.7, 1.8)

# b)
greater_2.5 <- gdp_growth > 2.5 
greater_2.5 # In the vector, the third and fourth elements are greater than 2.5

less_equal_2.0 <- gdp_growth <= 2.0
less_equal_2.0 # Only the fifth element is less than or equal to 2.0
  
equal_2.7 <- gdp_growth == 2.7
equal_2.7 # Only the fourth element is equal to 2.7

# c) The sum() function represents how many TRUE values in each logical vectors
sum(greater_2.5)
sum(less_equal_2.0)
sum(equal_2.7)

# d)
between_2_and_3 <-  gdp_growth >= 2 & gdp_growth <= 3 
between_2_and_3 # The first until fourth elements are between 2 and 3
