library(dplyr)
library(ggplot2)
library(shiny)
library(plotly)
library(stringr)

data = read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

#get to know more about the data
num_rows <- nrow(data)
num_cols <- ncol(data)
data_current <- data %>%
  filter(year == max(year)) 
data_world <- data %>%
  filter(country == "World")
data_us <- data %>%
  filter(country == "United States")
data_canada <- data %>%
  filter(country == "Canada")
data_china <- data %>%
  filter(country == "China")

#find max amount of CO2
max_co2 <- data %>%
 filter(year == max(year)) %>%
 filter(country != "World") %>%
 filter(iso_code != "") %>%
 filter(co2 == max(co2)) %>%
 select(country, co2)
 

#find lowest co2 per capita 
co2_capita_min <- data %>%
  filter(!is.na(co2_per_gdp)) %>%
  filter(year == max(year)) %>%
  filter(co2_per_gdp == min(co2_per_gdp)) %>%
  select(country)

#find increase in global co2 over 10 years
global_growth <- data %>%
  filter(country == "World") %>%
  filter(year %in% c(2009, 2018)) %>%
  mutate(co2_2008 = min(co2))  %>%
  filter(year == 2018) %>%
  mutate(co2_growth = co2 - co2_2008) %>%
  select(country, co2_growth)

#find a list of countries who decreased co2 emissions
declining_co2 <- data_current %>%
  filter(co2_growth_prct < 0) %>%
  select(country)

#highest co2 increase in history 
co2_increase <- data %>%
  filter(!is.na(co2_growth_prct)) %>%
  filter(iso_code != "") %>%
  filter(iso_code != "EST") %>%
  filter(co2_growth_prct == max(co2_growth_prct)) %>%
  select(country, year)


#Creating the plots
server <- function(input, output){
  
  colors <- c("data_us" = "blue", "data_world" = "red")
  
  output$scatter <- renderPlotly({
  plot <- ggplot(NULL) + 
    geom_point(data = data_world, mapping = aes_string(x = "year", y = input$y_input), color = "blue") + 
    geom_point(data = data_us, mapping = aes_string(x = "year", y = input$y_input), color = "red") +
    labs(title = "US vs World CO2 consumption Over Time", x = "Year", legend = "Key")
  ggplotly(plot)
    
  })
}





