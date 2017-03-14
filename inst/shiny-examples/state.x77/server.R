
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#



library(shiny)
library(recmap)
library(GA)
library(parallel)
library(doParallel)


shinyServer(function(input, output) {
  
  output$plot_hoverinfo <- renderText({
    # cat("Hover (throttled):\n")
    res <- cartogram()$cartogram
    x <- input$plot_hover$x
    y <- input$plot_hover$y
    query <- ((res$x - res$dx) < x) & (x < (res$x + res$dx)) & ((res$y - res$dy) < y) & (y < (res$y + res$dy))
    
    
    # init
    rv <- "no object identified."
    
    if (sum(query)==1){
      rv <- paste(res$name[query])
    }
    
    paste("state name:", rv)
  })
  
  
  cartogram <- reactive({
    
    usa <- data.frame(x = state.center$x, 
                      y = state.center$y, 
                      # make the rectangles overlapping by correcting lines of longitude distance
                      dx = sqrt(state.area) / 2 / (0.8 * 60 * cos(state.center$y*pi/180)), 
                      dy = sqrt(state.area) / 2 / (0.8 * 60), 
                      z = sqrt(state.area),
                      name = state.name)
    
    usa$z <- state.x77[, input$area]
    
    M <- usa[!usa$name %in% c("Hawaii", "Alaska"), ]
    
    recmapFitness <- function(idxOrder, Map, ...){
      Cartogram <- recmap(Map[idxOrder, ])
      #1 / sum(Cartogram$z / (sqrt(sum(Cartogram$z^2))) * Cartogram$relpos.error)
      1 / sum(Cartogram$relpos.error)
    }
    
    set.seed(1)
    
    recmapGA <- ga(type = "permutation", 
                   min = 1, max = nrow(M),
                   fitness = recmapFitness, 
                   Map = M,
                   popSize = input$GApopulation * nrow(M), 
                   maxiter = input$GAmaxiter,
                   pmutation = input$GApmutation,
                   parallel=TRUE,
                   run = input$GArun)
    
    C <- recmap(M[recmapGA@solution[1, ], ])
    #C$z2 <- S[recmapGA@solution[1, ]]
    list(cartogram=C, solution=recmapGA@solution[1, ])
  })
  
  output$distPlot <- renderPlot({
    res <- cartogram()
    
    cm <- heat.colors(100)
    
    S <- state.x77[which(rownames(state.x77) %in% res$cartogram$name), input$color]
    S <- S[res$solution]
    S <- round((length(cm) - 1) * (S - min(S)) / (max(S)  - min(S))) + 1
    plot.recmap(res$cartogram, col=cm[S], col.text = 'black')
    legend("topleft", c(input$area, input$color))
  })

})
