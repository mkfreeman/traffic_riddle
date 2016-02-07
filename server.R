require(plotly)
source('traffic_sim.R')
shinyServer(function(input, output) {
  # Render a histogram of the distribution of groups observed
  output$myChart <-renderPlotly({
    # Run simulation with input parameter
    by_car_avg <- NULL
    size <- seq(input$min_num_cars, input$max_num_cars, length.out = input$steps)
    for(num in size) {
      sim_results <- traffic_simulation(
        num_cars = num,
        iters = input$iters,
        min_speed = input$min_speed,
        max_speed = input$max_speed, 
        dist = input$dist
      )
      by_car_avg <- c(by_car_avg, mean(sim_results))
    }
    
    # Plot results
    plot_ly(x =size, 
            y = by_car_avg, 
            type='scatter', 
            mode="markers", 
            text = paste0("<b>Number of cars: </b>", round(size), '<br>', '<b>Number of Groups: </b>', round(by_car_avg, 1)),
            hoverinfo = 'text',
            marker=list(size=15, opacity = .6)) %>% 
        
    layout(xaxis = list (title="# of cars"), 
           yaxis = list(title="Avgerage # of groups", zeroline=FALSE), 
           title = 'Average # Of Groups by # of Cars'
    )
  })
})

