# A function to determine if a car is slower than all of the cars in front of it 
# (which would create a new group of cars **behind** it)
slower_than <- function(index, cars) {
  return(cars[index] < min(cars[1:index - 1]))
}

# Function to simulate traffic
traffic_simulation <- function(num_cars = 10, min_speed = 40, max_speed = 60, iters = 100, dist='unif') {
  results <- NULL
  for(i in 1:iters) {
    # Give cars a distribution of speeds
    if(dist == 'unif') {
      sim_cars <- runif(num_cars, min = min_speed, max = max_speed)  
    } else {
      speeds <- c(min_speed, max_speed)
      sim_cars <- rnorm(num_cars, mean = mean(speeds), sd = sd(speeds))
    }
    
    # Apply the slow_than function to all of the cars
    x <- lapply(2:num_cars, slower_than, cars = sim_cars)
    
    # Determine number of groups created
    groups <- length(x[x == TRUE]) + 1
    results <- c(results, groups)
  }
  return(results)
}