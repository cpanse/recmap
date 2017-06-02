
# This is the client logic for a Shiny web application using state.x77 data
#
# https://CRAN.R-project.org/package=recmap

library(shiny)


shinyUI(fluidPage(

  # Application title
  titlePanel(paste("state.x77 data using recmap version", packageVersion('recmap'))),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput('area', 'area', colnames(state.x77)),
      selectInput('color', 'color', colnames(state.x77)),
      htmlOutput("colormap"),
      hr(),
      p('Metaheuristic (GA):'),
      sliderInput("GApopulation", "GApopulation", 1, 10, 1),
      numericInput("GAmaxiter", "GAmaxiter", 10),
      numericInput("GArun", "GArun", 10),
      sliderInput("GApmutation", "GApmutation", 0, 1, 0.2),
      hr(),
      downloadButton('pdfx77')
    ),
    # Show a plot of the generated distribution
    mainPanel(
     
      p('please wait some seconds until the cartogram is computed.'),
      plotOutput("cartogramPlot", hover = hoverOpts(id = "plot_hover", delayType = "throttle")),
      #h4("Mouse over Information"),
      tableOutput("plot_hoverinfo"),
      p('on the colormap below; left is the lowes statistical value; right side is highest.'),
      plotOutput("colormapPlot", height = 25),
      hr(),
      p('compute your own cartogram with', a('https://CRAN.R-project.org/package=recmap', 
                                             href='https://CRAN.R-project.org/package=recmap'), '.')
    )
  )
))
