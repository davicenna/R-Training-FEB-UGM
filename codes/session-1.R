# R-Training-1 ####
# Prepared by Data Avicenna

# Basic Building Blocks ####

# Interactive calculator in R
5+7
x <- 5+7
x

# Multiplication
100*100

# Square root and division
sqrt(25) + (200/5)

# Exponentiation 
1000 * (1.05)^3

# Brief look at objects and functions in R
a <- 1             # a single value object
a <- c(1, 2, 3)    # vector with multiple elements

# Using the built-in sum function
# Calculates sum and stores in new object
sum_of_a <- sum(a)


# Vectors ####

# Numeric vector
y <- c(1, 2, 3, 4, 5)
y

# Character vector
hello <- c("Hello", "World")
hello

# Mixing types
mixed<- c(1, "text", TRUE)
mixed

# Vector operations (Example: vector multiplication)
# Creating a vector
prices <- c(10, 15, 20, 25)

# Operations apply to each element
prices * 2 # Double all prices

# Calculate total revenue if quantities sold are
quantities <- c(5, 3, 2, 1)
revenue <- prices * quantities
revenue

# Get the total
sum(revenue)

# Vectors of atomic objects
x <- c(1.1, 2.2, 3.3)
is.numeric(x)

x <- c(1L, 2L, 3L)
is.integer(x)

x <- c(1+0i, 2+4i, 3+6i)
is.complex(x)

x <- c(TRUE, FALSE, TRUE)
is.logical(x)

x <- c("I", "like", "R")
is.character(x)

# Use the following commands to identify the object type:
typeof()
mode()

# Logical operators in R
x <- 5; y <- 10
x < y       # TRUE
x == (2+3)  # TRUE
(x < 3) & (y < 20)  # TRUE (vector AND)
(x > 7) | (y == 10) # TRUE (vector OR)
is.logical(x < y)   # TRUE (returns logical value) 

# Factors: categorical vectors
# Creating a basic factor
education <- factor(c("High School", "Bachelor", "Master", 
                "Bachelor", "PhD", "High School"))

# Examining the factor
levels(education)

# Creating a factor with custom levels and order 
income_level <- factor(c("Medium", "Low", "High", "Medium", "Low"),
                       levels = c("Low", "Medium", "High"),
                       ordered = TRUE)

# Now we can use comparison operators
income_level[1] > income_level[2] # TRUE - Medium > Low


# Functions ####
c(1, 2, 3)
sum(1, 2, 3)

my_function <- function(x, y){
  # Function body goes here
  return(x + y)
}

x <- c(1, 2); y <- c(2, 3)
my_function <- function(x, y) {
# Function body goes here
return ((x+y)/2)
}
my_function(x, y)

# Function documentation
?sum_of_a # Opens help for the sum() function
?c # Opens help for the c()

# Summary of numeric vector
summary(1:10)
# Summary of factor
summary(factor(c("A", "B", "A")))

# More examples of functions
gdp_growth <- c(2.1, 2.5, 3.0, 2.7, 1.8)
mean(gdp_growth)
sd(gdp_growth)
median(gdp_growth)
summary(gdp_growth)


# Conditional Statements ####
# Basic if-statement
gdp_growth <- 2.5  # Annual GDP growth rate

if (gdp_growth > 0) {
  print("The economy is growing")
}

# if-else statement
gdp_growth <- -0.5  # Annual GDP growth rate

if (gdp_growth > 0) {
  print("The economy is growing")
} else {
  print("The economy is contracting")
}

# if-else if-else statements
gdp_growth <- 1.2  # Annual GDP growth rate

if (gdp_growth > 5) {
  print("Strong economic growth")
} else if (gdp_growth > 0) {
  print("Moderate economic growth")
} else if (gdp_growth > -1) {
  print("Economic slowdown")
} else {
  print("Economic recession")
}

# ifelse() Function
# Create vector of growth rates for different regions
regional_growth <- c(2.1, -0.5, 3.2, 0.1, -1.2)

# Classify each region
region_status <- ifelse(regional_growth > 0, 
                        "growing", 
                        "contracting")
region_status

