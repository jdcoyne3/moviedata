library(shiny)
library(ggplot2)
library(RColorBrewer)
library(plotly)
source("app_server.R")

col_names <- colnames(data)
tables <- c("data_world")

# x_input <- selectInput(
#   inputId = "x_input",
#   label = "Chose an X value",
#   choices = col_names
# )
# Using a similar approach, create a variable `y_input` that stores a
# `selectInput()` for your variable to appear on the y axis of your chart.
# Add a `selectInput` for the `y` variable
y_input <- selectInput(
  inputId = "y_input",
  label = "Chose a Y value",
  choices = col_names
)

# Create a variable `color_input` as a `selectInput()` that allows users to
# select a color from a list of choices
color_input <- selectInput(
  inputId = "color_input",
  label = "Chose q color",
  choices = c("red", "blue", "green")
)

graph_choice<- selectInput(
  inputId = "graph_choice",
  label = "Chose a country",
  choices = tables,
)

# Create a variable `size_input` as a `sliderInput()` that allows users to
# select a point size to use in your `geom_point()`


# Create a variable `ui` that is a `fluidPage()` ui element. 
# It should contain:




# ui <- navbarPage(  # lay out the passed content fluidly
#    "My app",
#    first_page,
#    second_page,
#    plotOutput("scatter")
#    
# )

page_one <- tabPanel(
  "Introduction",
  
  # This content uses a sidebar layout
  fluidPage(
      h1("Introdcution"),
      p("In this project, we were given a data set about all kinds of carbon 
        emmsions and how they have changed over time, and how they differentiate
        from country to country. What I chose to focus on is progress, both as a 
        country as an entire planet. I chose, in my graph to measure the variables 
        over time, and then compare what the world is doing compared to the United
        States."),
      br(),
      h3("Data exploration"),
      p("I chose to explore certain parts of the data that were interesting to 
        me"),
      br(),
      br(),
      p("The first data element I found was the country with the maximum amount 
        of CO2 emiissions for the most recent year"),
     max_co2,
      br(),
      br(),
      p("I then found the country with the lowest CO2 emmissions per capita,
        in the most recent year"),
      co2_capita_min,
      br(),
      br(),
      p("The next data I wanted to find was the rate in which CO2 emissions 
        have grown over the past 2 years"),
      global_growth,
      br(),
      br(),
      p("The next data set was to find the highest increase in rate of CO2 
        emmisions from one year to the next"),
      co2_increase,
      br(),
      br(),
      p("My final discovery was to find the number of countries who have decreased
        their carbon emmisions in the most recent year. This list contained 54
        countries. The United States was not one of them.")
      
      
      
    
  )
)

second_page <- tabPanel(
  "Graph",
  
  # This content uses a sidebar layout
  fluidPage(
    y_input,
    plotlyOutput("scatter"),
    p("Blue = World, Red = United States")
  )
)

ui <- navbarPage(
  # "First Page",
  # x_input,
  # y_input,
  # color_input,
  # plotOutput("scatter")
  "CO2 Emmissions project",
  page_one,
  second_page
)

