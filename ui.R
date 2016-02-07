require(shiny)
require(plotly)
shinyUI(fluidPage(
  titlePanel('Traffic Simulation'),
  sidebarLayout(
    sidebarPanel(  
      sliderInput("min_num_cars", "Min. # of Cars", 
                  min = 10, max = 1000, value = 10, step = 10),
      sliderInput("max_num_cars", "Max. # of Cars", 
                  min = 10, max = 1000, value = 100, step = 10),
      sliderInput("steps", "Steps (observations b/w min and max)", 
                  min = 10, max = 100, value = 50, step = 10),
      sliderInput("iters", "Iterations of Simulation", 
                  min = 10, max = 100, value = 10, step= 10),
      sliderInput("min_speed", "Minimum Speed", 
                  min = 10, max = 150, value = 40, step= 5),
      sliderInput("max_speed", "Max Speed", 
                  min = 10, max = 150, value = 60, step= 5), 
      radioButtons("dist", label = h4("Distribution of speeds"),
                   choices = list("Uniform" = 'unif', "Normal (mean = mean(min, max), sd = sd(min, max)" = 'norm'), 
                   selected = 'unif')
    ),
    mainPanel(
      plotlyOutput("myChart")
    )
  )
))
