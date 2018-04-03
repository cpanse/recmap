

# This is the client logic for a Shiny web application using U.S. county data
#
# https://CRAN.R-project.org/package=recmap

# library(shinythemes)

shinyUI(fluidPage(# Application title
#  theme = shinytheme("darkly"),
  titlePanel(
    paste("https://CRAN.R-project.org/package=recmap",
          "version",
          packageVersion('recmap')
    )
  ),
  
  # Sidebar with a slider input
  sidebarLayout(
    sidebarPanel(
      radioButtons("datatype", "Type of data:",
                   c("checkerboard" = "checkerboard",
                     "US county" = "UScounty",
                     "US state" = "USstate")),
      br(),
      htmlOutput("II"),
      hr(),
      helpText('Settings Genetic Algorithm (GA):'),
      numericInput("seed", "seed", 1),
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
      tabsetPanel(
        tabPanel("recmap",
                 list(
                   helpText(
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
                   ))),
        tabPanel("GA",
                 list(
                   plotOutput("gaPlot"),
                   DT::dataTableOutput("gaSolution")
                 )
        ),
        tabPanel("summary",
                 list(
                   DT::dataTableOutput("summary")
                 )
        )
      ),
        
      p(
        'compute your own cartogram with',
        a('https://CRAN.R-project.org/package=recmap',
          href = 'https://CRAN.R-project.org/package=recmap'),
        '.'
      )
      
      
    )
  )))
