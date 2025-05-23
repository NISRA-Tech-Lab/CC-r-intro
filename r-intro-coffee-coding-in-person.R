# Intro to R and RStudio

# NOTE - you should have run renv setup with renv::restore() before starting


# Console and Scripting ----
# This section of the screen is script pane, we use this to run stored code.
# These can be saved and used in other places.
# The pane below is the console. Unlike scripts, it is temporary and is a space ready for
# you to enter a command and query R
# Results from console or script are both shown in the console.

# This script is contained within a Project, denoted by the .Rproj file in the folder
# Projects are useful for containing all of your code/input data/functions in one place

# Comments in R are preceded with a # - Ctrl + Shift + C to comment/uncomment lines


# Data Types ----
# Code can be sent to the console for evaluation either line by line with
# Ctrl + Enter or by selecting a chunk and using Ctrl + Enter
# A Run button above does the same thing

# Numbers are entered without quotes
5
# Text should always be entered in quotes, single or double
"Bumblebee"

# Anything unassigned that is sent to the Console only exists there, it is
# not stored

# Expressions can be evaluated in the console like below
5 + 5
paste0("Bumble","Bee")

# Press the up/down arrows on the keyboard to cycle through previous commands
# when in the Console

# We can also store persistent named values in the environment
# Replace Kyle with your name below and run the line to see what happens
my_name <- "Kyle"

# Instead of returning your name in the console it has been stored as a value
# in the enviroment. You can see a list of everything that has been stored in
# the environment in the top right pane.
# 
# Any time you see the symbol <- it means something is being assigned to the environment
# Use the console to test what the value my_name resolves to.

# We can also store values in the environment and then use them in an expression 
x <- 6
x + 7

# TRUE or FALSE values can be stored without quotes (can also be expressed as T/F)
y <- TRUE


# Data structures in R ----

# Vectors
# Contains items of the same type - created using c()
# A string vector
names <- c("Brenda", "Joe", "Mike")
# a numeric vector
values <- c(1, 3, 5)

# Lists
# Like vectors but can contain multiple different types of data
# can be nested to create data hierarcy
list_example <- list(1, "a", TRUE, 100L)

# Factors
# Factors are used to represent categorical data. 
# They can be ordered or unordered and contain levels
sex_factor <- factor(c("male", "female", "female", "male"))
# R will assign 1 to the level "female" and 2 to the level "male" 
# (because f comes before m, even though the first element in this vector is "male")
# You can check this by using the function levels(), 
# and check the number of levels using nlevels():
levels(sex_factor)
nlevels(sex_factor)

# Dataframes
# Vectors can be combined into data frames - a df is essentially just a combination
# of vectors
# After running this line double click on df in the environment to view the data
df <- data.frame(names, values)

# Individual columns from data frames can be called using a $ separator
df$names

# We can return the number of rows in a dataframe with:
print(paste0("There are ", nrow(df), " rows in the dataframe named df"))

# A new column can also be created in the data frame using the $ separator
# all of this so far is what we call BASE R code - we will cover other data
# manipulation methods later
df$value2 <- df$values*2

# If/Else and Logic in R ----
# can be used to create certain outputs
# The code below will check the content of the value my_name and output one of two responses
if (my_name == "Kyle") {
  "it's me"
} else {
  "not you"
}

# Note that we use a double equals sign == in logical commands
my_name == "Brian"
# be careful not to confuse with a single equals which is the same as using <- 
my_name = "Brian"

# We can also use other operators for logical statements, particularly when
# it comes to numeric values
x == 8
x < 7
x >= 3
x != 4

# Loops ----
# We can create a for loop to repeat a process
# Here we will ask R to print the statement "My name is ___" for every value in 
# the column names
# paste() is the R command to combine two strings of text
for (name in names) {
  print(paste("My name is", name))
}

# Functions ----
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

# Packages ----
# Since R is run by an open source community it is always expanding and improving and 
# there are many different packages that can be installed to increase its functionality
# on top of BASE R

# we have already run the following line of code to install the packages we need

# dplyr and pipes ----
# To use an already installed R package in an R project we call it with library()
library(dplyr)
library(tidyr)

# dplyr adds many functions that can be used to transform data. We will use three
# of those below.
# We are also going to use the pipe %>% operator as it allows us to
# chain commands together and create a pipe

# mutate: add a new column
# select: reorder, and select columns
# arrange: sort data on a particular column

# Say we had a data frame comprised of three vectors
character_details <- data.frame(Age = c(101, 160, 97, 45, 134, 26, 163, 13, 16),
                      first_name = c("Obi-Wan", "Luke", "Darth", "Han", "Jar Jar", "R2", "Roos", "IG", "R4"),
                      surname = c("Kenobi", "Skywalker", "Vader", "Solo", "Binks", "D2", "Tarpals", "88", "P17"))

# And our task was to combine (using paste()) the first and surnames into a single column,
# remove those columns, sort by Age and remove any ages over 150

# We could do it individual steps:

# Step 1 create the new column
new_character_details <- mutate(.data = character_details,
                      full_name = paste(first_name, surname))

# Step 2 select only the columns we want
new_character_details <- select(.data = new_character_details,
                      Age, full_name)

# Step 3 sort by Age
new_character_details <- arrange(.data = new_character_details,
                       Age)

# Step 4 filter to only include ages under 150
new_character_details <- filter(.data = new_character_details,
                                 Age < 150)


# Or, using the pipe %>% operator we can chain these four commands together

new_character_details_piped <- character_details %>%
  mutate(full_name = paste(first_name, surname)) %>%
  select(Age, full_name) %>%
  arrange(Age) %>% 
  filter(Age < 150)

# Using the pipe operator means not having to declare which data frame 
# we are using at each step
# The result of each step in the piped commands is passed to the next step
# Note how the resultant data frames are identical

# Pivot ----
# a dataframe can be pivoted wider or longer with pivot_wider() and pivot_longer()
character_details_long <- character_details %>% 
  select(-Age) %>%
  pivot_longer(cols = c(first_name, surname), 
               names_to = "name type", 
               values_to = "name value")
# Join ----
# if we wanted to join another variable (height) onto the end of our original dataset we can use dplyr join statements
extra_info_for_merge <- data.frame(first_name = c("Obi-Wan", "Luke", "Darth", "Han", "Jar Jar", "R2", "Roos", "IG", "R4"),
                                   surname = c("Kenobi", "Skywalker", "Vader", "Solo", "Binks", "D2", "Tarpals", "88", "P17"),
                                   height_m = c(1.82, 1.75, 2.30, 1.86, 2.40, 1.20, 2.12, 0.78, 1.74))

character_details_merged <- character_details %>% 
  left_join(extra_info_for_merge, by = c("first_name", "surname"))

# Grouping and summarising ----
# if we want to sum and condense a dataset by a given variable we can do
# that as follows - with a group_by() on the variable we want to group with
# and a summarise to tell R to sum or calculate by that grouping

# to do this on character_details_merged we need to add some extra variables first

character_details_grouped <- cbind(character_details_merged, 
                                   species = c("Human", "Human", "Human", "Human", "Gungan", "Droid", 
                                               "Gungan", "Droid", "Droid"))

character_details_grouped <- character_details_grouped %>% 
  group_by(species) %>% 
  summarise(avg_age = mean(Age), max_age = max(Age), min_age = min(Age))

# Charts ----
# Graphs can be quickly created from data frames using the plotly or ggplot2 libraries
# We are going to look a ggplot2 today - plotly is just interactive version
library(ggplot2)

print(ggplot_plot <- ggplot(new_character_details_piped, aes(x = full_name, y = Age, fill = factor(Age))) +
  geom_col() +
  theme_minimal() +
  theme(legend.position = "none"))
# view in Plots tab

# The graphs will be shown in the viewer/plot tab in the bottom right of RStudio.


# data import ---
# Most times we won't be defining our data in the code, we will be importing
# from a csv or other static file
starwars <- read.csv("starwars.csv")

# YOUR TURN ----
# we want process the starwars dataframe applying the below conditions: 

## contains every variable except birth_year, sex and homeworld
  # hint - you can specify a range of columns with first_column:last_column
  # hint - you can negate a selection i.e. specify those NOT to be selected
  # with !c(columns_to_drop)

## is filtered to only include gender of "masculine" and
## is in the top 5 species by count - this second part has been done for you

## has the three variables using the american spelling of colour renamed
  # hint - to open the help for the rename function type ?rename into the console

starwars <- xxxx %>%
  select(xxxx) %>%
  filter(xxxx == "xxxx" &
         species %in% c("Human","Droid","Gungan","Wookiee","Zabrak")) %>% 
  rename(xxxx = hair_color,
         skin_colour = xxxx,
         xxxx = eye_color)

# using the code we learned earlier we can create a plot to summarise some
# of the information in the edited starwars dataframe

print(ggplot_height_species <- ggplot(starwars, aes(x = species, y = height, colour = species)) +
        geom_point(size = 2.5)) +
        theme_minimal() +
        theme(legend.position = "none")

# we can write that file out to csv from R 
write.csv(starwars, file="starwars_edited.csv", row.names = FALSE)

# Keyboard shortcuts ----
# assignment - Alt + -
# Pipe - Ctrl + Shift + M
# Comment/Uncomment block - Ctrl + Shift + C