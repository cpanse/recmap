

# This is the client logic for a Shiny web application using U.S. county data
#
# https://CRAN.R-project.org/package=recmap

library(shiny)

shinyUI(fluidPage(# Application title
  titlePanel(
    paste(
      "U.S. county population data using recmap version",
      packageVersion('recmap')
    )
  ),
  
  # Sidebar with a slider input
  sidebarLayout(
    sidebarPanel(
      selectInput('state', 'U.S. state', row.names(state.x77), "Louisiana"),
      p('overlap to compose pseudo dual:'),
      sliderInput("scaleX", "scaleX", 0, 1, 0.6),
      sliderInput("scaleY", "scaleY", 0, 1, 0.63),
      
      hr(),
      p('Settings Genetic Algorithm (GA):'),
      sliderInput("GApopulation", "GApopulation", 1, 10, 1),
      numericInput("GAmaxiter", "GAmaxiter", 10),
      numericInput("GArun", "GArun", 10),
      sliderInput("GApmutation", "GApmutation", 0, 1, 0.2),
      #sliderInput("objective_weight", "topology ~ relative position", 0, 1, 0.5),
      
      checkboxInput("parallel", "GAparallel", FALSE),
      hr(),
      downloadButton('foo')
    ),
    
    mainPanel(
      p(
        'overlapping rectangles define the topology of the pseudo dual graph.'
      ),
      plotOutput("mapPlot"),
      tableOutput("plot_hoverinfo"),
      p('please wait some seconds until the cartogram is computed.'),
      plotOutput(
        "cartogramPlot",
        hover = hoverOpts(
          id = "plot_hover",
          delayType = "throttle",
          delay = 500
        )
      ),
      
      plotOutput("gaPlot"),
      
      p(
        'compute your own cartogram with',
        a('https://CRAN.R-project.org/package=recmap',
          href = 'https://CRAN.R-project.org/package=recmap'),
        '.'
      )
      
      
    )
  )))
