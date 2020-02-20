#R
# This is the client logic for a Shiny web application using recmap
#
# https://CRAN.R-project.org/package=recmap


shinyUI(fluidPage(# Application title
  titlePanel(
    paste("https://CRAN.R-project.org/package=recmap",
          "version",
          packageVersion('recmap')
    )
  ),

  # Sidebar with a slider input
  sidebarLayout(
    sidebarPanel(
      htmlOutput("methodRadio"),
      br(),
      htmlOutput("II"),
      hr(),
      helpText('Genetic Algorithm (GA):'),
      numericInput("seed", "seed", 1),
      sliderInput("GApopulation", "population size factor", 1, 10, 1),
      numericInput("GAmaxiter", "maxiter", 10),
      helpText('the maximum number of iterations to run before the GA search is halted.'),
      hr(),
      numericInput("GArun", "run", 10),
      helpText('the number of consecutive generations without any improvement in the best fitness value before the GA is stopped.'),
      hr(),
      sliderInput("GApmutation", "probability of mutation in a parent chromosome", 0, 1, 0.2),
      #sliderInput("objective_weight", "topology ~ relative position", 0, 1, 0.5),

      checkboxInput("parallel", "parallel - An optional argument which allows to specify if the Genetic Algorithm should be run sequentially or in parallel.", FALSE),
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
        tabPanel("Summary",
                 list(
                   DT::dataTableOutput("summary")
                 )
        ),
        tabPanel("Session Info", verbatimTextOutput("sessionInfo"))
      ),
  
      p(
        'compute your own cartogram with',
        a('https://CRAN.R-project.org/package=recmap',
          href = 'https://CRAN.R-project.org/package=recmap'),
        '.'
      )
    )
  )))
