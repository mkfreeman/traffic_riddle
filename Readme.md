# Traffic Riddle
This page is a simulation attempt to answer this riddle from [FiveThirtyEight](http://fivethirtyeight.com/features/how-many-cars-will-get-stuck-in-traffic/):

>There is a very long, straight highway with some number of cars (N) placed somewhere along it, randomly. The highway is only one lane, so the cars can’t pass each other. Each car is going in the same direction, and each driver has a distinct positive speed at which she prefers to travel. Each preferred speed is chosen at random. Each driver travels at her preferred speed unless she gets stuck behind a slower car, in which case she remains stuck behind the slower car. On average, how many groups of cars will eventually form? (A group is one or more cars travelling at the same speed.)

In the simulation, `N` cars are created with random speeds between the minimum and maximun values chosen.  Then, the number of groups is determined by calculating if any cars in front of car `i` have a slower speed (if not, car `i` creates a new group):

```
slower_than <- function(index, cars) {
  return(cars[index] < min(cars[1:index - 1]))
}
```
This process is repeated `I` times, given the number of simulations selected.  Note, if you select a large number of cars (`N`), and a large number of iterations (`I`), it will take a longer time for the simulation to complete.

Interactive graphics were created using [Plotly](https://plot.ly/r/), and compiled into an interface using the [Shiny framework](http://shiny.rstudio.com/).

The code is hosted [on GitHub](https://github.com/mkfreeman/traffic_riddle), and was created by [Michael Freeman](http://mfviz.com).

The Interactive Shiny Applicaiton is hosted [here](https://mfviz.shinyapps.io/traffic_riddle/).