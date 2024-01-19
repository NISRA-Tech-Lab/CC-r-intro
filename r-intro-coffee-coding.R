# Intro to R syntax
# This section of the screen is script pane, we use this to run stored code.
# These can be saved and used in other places.
# The pane below is the console. Unlike scripts, it is temporary and is where R
# is waiting for you to tell it what to do. Results will be shown in the console.
# 
# Comments in R are preceded with a # 
# 
# Try typing each line of code below into the console and see what it returns
# Numbers are entered by typing them without quotes
5
# Expressions can be evaluated in R like below
5 + 5
# Text should always be entered in quotes
"Bumblebee"
# Press the up/down arrows on the keyboard to cycle through previous commands

# You can also run code from the script pane
# Highlight each (or all) of the lines of code above and press Ctrl+Enter to
# send the highlighted code to the console

# We can also store values in the environment
# Replace Brian with your name below and run the line to see what happens
my_name <- "Brian"

# Instead of returning your name in the console it has been stored as a value
# in the enviroment. You can see a list of everything that has been stored in
# the environment in the top right pane.
# 
# Any time you see the symbol <- it means something is being assigned to the environment
# Use the console to test what the value my_name resolves to.

# We can also store values in the environment and then use them in an expression 
x <- 6
x + 7

# TRUE or FALSE values can be stored without quotes
y <- TRUE

# Items of the same type can be placed in a vector using c()
# A string vector
names <- c("Brenda", "Joe", "Mike")
# a numeric vector
values <- c(1, 3, 5)

# Vectors can be combined into data frames - a df is essentially just a matrix of vectors
# After running this line double click on df in the environment to view the data
df <- data.frame(names, values)

# Individual columns from data frames can be called using a $ separator
df$names

# A new column can also be created in the data frame using the $ separator
# all of this so far is what we call BASE R code - we will cover other data
# manipulation methods later
df$value2 <- df$values*2

# if/else logic can be used to create certain outputs
# The code below will check the content of the value my_name and output one of two responses
if (my_name == "Brian") {
  "it's me"
} else {
  "not you"
}
# note that because a <- was not used, the code was just run and printed to console
# what would have happened and what would we get if we had preceded the code
# with test_fun <- ? 

# Note that we use a double equals sign == in logical commands
my_name == "Brian"
# be careful not to confuse with a single equals which is the same as using <- 
my_name = "Brian"

# We can also use other operators for logical statements, particularly when it comes to numeric values
x == 8
x < 7
x >= 3
x != 4

# We can create a for loop to repeat a process
# Here we will ask R to print the statement "My name is ___" for every value in the column names
# paste() is the R command to combine two strings of text
for (name in names) {
  print(paste("My name is", name))
}

# We can write custom functions in R that will perform a series of operations when
# called by their name
# This function will add six to the number x, half it and output a sentence
my_fn <- function(x) {
  res <- (x + 6) / 2
  paste("The result of the function is", res)
}

my_fn(8)
my_fn(19)

# Functions can be as short or as long as you want and are handy when having
# to perform repetitive operations

# Packages
# Since R is ran by an open source community it is always expanding and improving and there are
# many different packages that need installed to increase its functionality on top of BASE R
# 
# To install a new package we run the command install.packages()
# This package is part of the tidyverse, a set of packages created by RStudio
# to allow users to work in a tidy manner
# dplyr is the main data manipulation package - find out more here: https://www.tidyverse.org/
install.packages("dplyr")

# To use an already installed R package in an R project we call it with library()
library(dplyr)

# One of the functions of dplyr is that it allows us to chain commands using the pipe %>% operator
# dplyr also adds many functions that can be used to transform data. We will use two of those below
# mutate: add a new column
# select: reorder, and select columns
# arrange: sort data on a particular column

# Say we had a data frame comprised of three vectors
details <- data.frame(Age = c(101, 160, 97),
                      first_name = c("Obi-Wan", "Luke", "Darth"),
                      surname = c("Kenobi", "Skywalker", "Vader"))

# And our task was to combine (using paste()) the first and surnames into a single column, remove
# those columns and sort by IntNo. We could do it individual steps:

# Step 1 create the new column
new_details <- mutate(.data = details,
                      full_name = paste(first_name, surname))

# Step 2 select only the columns we want
new_details <- select(.data = new_details,
                      Age, full_name)

# Step 3 sort by IntNo
new_details <- arrange(.data = new_details,
                       Age)

# Or if we utilise the pipe %>% operator we can chain these three commands together

new_details_piped <- details %>%
  mutate(full_name = paste(first_name, surname)) %>%
  select(Age, full_name) %>%
  arrange(Age)

# Using the pipe operator means not having to declare which data frame we are using at each step
# The result of each step in the piped commands is passed to the next step
# Note how the resultant data frames are identical

# Charts
# Graphs can be quickly created from data frames using the plotly or ggplot2 libraries
install.packages("plotly")
install.packages("ggplot2")
install.packages("rmarkdown")

library(plotly)
library(ggplot2)
library(rmarkdown)

plot_ly(new_details_piped,
        x = ~full_name,
        y = ~Age,
        type = "bar")

# The graph will be shown in the viewer tab in the bottom right of RStudio. We can use this
# later in an output.

# data import
# Most times we won't be defining our data in the code, we will be importing
# from a csv or other static file
starwars <- read.csv("starwars.csv")




# change the below code to use the starwars data in readiness for use in the Rmd




# we can then perform various data manipulations with it using R

# Select and Filter
df1 %>%
  select(Fruit, Color) %>%
  filter(Color == "Yellow")

# Group by
# Example
df1 %>%
  group_by(Fruit)

#Grouping doesn't change how the data looks (apart from listing how it's grouped). The grouping is shown when a command like 'tally' is run"


# group_by and tally
df1 %>%
  filter(Color == "Yellow") %>%
  group_by(Fruit) %>%
  tally(sort = TRUE) %>%
  select(Fruit, n)

# Add percentage column
df1 %>%
  group_by(Fruit) %>%
  tally(sort = TRUE) %>%
  mutate('%_Distribution' =  100 *n/sum(n)) 

# Arrange
df1 %>% 
  select(Fruit, Price) %>%
  arrange(Price)

# Arrange in descending order
df1 %>% 
  select(Fruit, Price) %>%
  arrange(desc(Price))

# Calculated Fields- mutate is used to add a column. 
df1

df1 %>%
  mutate('Total' = rowSums(across(where(is.numeric))))

# Rename columns/variables
df1 %>%
  rename(Colour = Color)

# Filter
df1 %>%
  filter(Fruit == "Apple")

# lets also create a variable for use later in our output below
movie_name <- "Star Wars"

# we can write that file out to csv from R 
write.csv(df1, file="df2.csv", row.names = FALSE)
# we can also take the results of our code and create an html document from it
# don't worry about how this file works for now, that is for a later course
render(input = 'create-output-html-doc.Rmd')

# keyboard shortcuts
# assignment - Alt + -
# Pipe - Ctrl + Shift + M

# to finish this off we should be able to pull together all that we have created 
# into one file (xlsx/csv) or RMD (doesn't need to be explained, just used)