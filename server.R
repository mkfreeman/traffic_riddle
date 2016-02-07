require(plotly)
require(markdown)
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
           yaxis = list(title=paste0("Avg. # of groups (in ",input$iters, " sims.)") , zeroline=FALSE), 
           title = 'Average # Of Groups by # of Cars'
    )
  })
  
  # Render a histogram of the distribution of groups observed
  output$histogram <-renderPlotly({
    
    # Run simulation with input parameters
    results <- traffic_simulation(
      num_cars = input$hist_num_cars,
      iters = input$hist_iters,
      min_speed = input$hist_min_speed,
      max_speed = input$hist_max_speed, 
      dist = input$hist_dist
    )
    
    # Use plotly to graph results
    plot_ly(x = results,
            type="histogram", 
            opacity = .6
    ) %>% 
      
      layout(xaxis = list (title="# of groups created"), 
             yaxis = list(title="# of simulations"), 
             bargap = .2,
             title = paste0('# of groups in ', input$hist_iters, ' simulations: ', input$hist_num_cars, ' cars ', '(avg. = ', round(mean(results), 2), ')'))
  })
  
})

