
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel(paste("US county population data using recmap version", packageVersion('recmap'))),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      
      selectInput('state', 'state', row.names(state.x77)),
      sliderInput("scaleX", "scaleX", 0, 1, 0.5),
      sliderInput("scaleY", "scaleY", 0, 1, 0.5),
     # selectInput('area', 'area', colnames(state.x77)),
    #  selectInput('color', 'color', colnames(state.x77)),
      p('Metaheuristic (GA):'),
      sliderInput("GApopulation", "GApopulation", 1, 10, 1),
      numericInput("GAmaxiter", "GAmaxiter", 10),
      numericInput("GArun", "GArun", 10),
      sliderInput("GApmutation", "GApmutation", 0, 1, 0.2)
    ),
    # Show a plot of the generated distribution
    mainPanel(
     
      p('please wait some seconds until the cartogram is computed.'),
      plotOutput("mapPlot"),
      plotOutput("cartogramPlot", hover = hoverOpts(id = "plot_hover", delayType = "throttle")),
      #h4("Mouse over Information"),
      tableOutput("plot_hoverinfo"),
      p('compute your own cartogram with', a('recmap.', 
                href='https://CRAN.R-project.org/package=recmap')),
      p('the colors are the default R heat.colors (red is low; white is high)'),
      img(src='heat.png', align = "left", width=200)
      
    )
  )
))
