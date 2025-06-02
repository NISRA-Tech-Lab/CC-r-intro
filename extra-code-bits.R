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