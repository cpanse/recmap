

# This is the server logic for a Shiny web application using U.S. county data
#
# https://CRAN.R-project.org/package=recmap

library(colorspace)
library(maps)
library(shiny)
library(recmap)
library(noncensus)

data(counties)

.get_county_mbb <-
  function(state = 'colorado',
           scaleX = 0.5,
           scaleY = 0.5) {
    MBB <- lapply(map('county', state, plot = FALSE)$names,
                  function(x) {
                    r <- map('county', x, plot = FALSE)
                    dx <- scaleX * (r$range[2] - r$range[1])
                    dy <- scaleY * (r$range[4] - r$range[3])
                    x <- r$range[1] + dx
                    y <- r$range[3] + dy
                    data.frame(
                      polyname = r$name,
                      x = x,
                      y = y,
                      dx = dx,
                      dy = dy
                    )
                  })
    MBB <- do.call('rbind', MBB)
    MBB <- merge(MBB, county.fips, by = 'polyname')
    MBB$fips <- as.integer(MBB$fips)
    
    P <- data.frame(
      fips = paste(counties$state_fips,
                   counties$county_fips, sep = ''),
      z = counties$population,
      name = counties$county_name
    )
    P$fips <- as.integer(levels(P$fips))[P$fips]
    
    M <- merge(MBB, P, by = 'fips')
    class(M) <- c('recmap', 'data.frame')
    M
  }

shinyServer(function(input, output, session) {
  output$plot_hoverinfo <- renderText({
    res <- Cartogram()$Cartogram
    x <- input$plot_hover$x
    y <- input$plot_hover$y
    
    query <-
      ((res$x - res$dx) < x) &
      (x < (res$x + res$dx)) &
      ((res$y - res$dy) < y) & (y < (res$y + res$dy))
    rv <- "no object identified."
    if (sum(query) == 1) {
      rv <- paste(res$name[query])
    }
    
    paste("state name:", rv)
  })
  
  Map <-  reactive({
    progress <- shiny::Progress$new(session = session)
    progress$set(message = "get input map")
    on.exit(progress$close())
    res <-
      .get_county_mbb(
        state = input$state,
        scaleX = input$scaleX,
        scaleY = input$scaleY
      )
    res$name <- gsub(" ", "\n", res$name)
    res
  })
  
  wfitness <- function(idxOrder, Map,  ...) {
    Cartogram <- recmap(Map[idxOrder,])
    if (sum(Cartogram$topology.error == 100) > 0) {
      return(0)
    }
    
    1 / (c(input$objective_weight, 1 - input$objective_weight) %*% c(S['topology error',] / nrow(Cartogram) ^
                                                                       2, S['relative position error',]))
  }
  
  Cartogram <- reactive({
    progress <- shiny::Progress$new(session = session, min = 0, max = 1)
    progress$set(message = "recmapGA init")
    on.exit(progress$close())
    options(warn = -1)
    M <- Map()
    
    set.seed(1)
    
    time.elapsed <- rep(proc.time()[3], input$GAmaxiter)
    
    res <- recmapGA(
      M,
      maxiter = input$GAmaxiter,
      popSize = input$GApopulation * nrow(M),
      pmutation = input$GApmutation,
      run = input$GArun,
      parallel = input$parallel,
      monitor = function(object, digits = getOption("digits"), ...)
      {
        fitness <- na.exclude(object@fitness)
        sumryStat <- c(mean(fitness), max(fitness))
        
        time.elapsed[object@iter] <- ( proc.time()[3] - time.elapsed[object@iter] ) / object@iter
        progress$set(
          message = "GA",
          detail = paste(
            "iteration",
            object@iter, "/", input$GAmaxiter,
            "fittest = ",
            round(sumryStat[2], 5),
            "\n elapsed time / generation", round(time.elapsed[object@iter], 2), "in secs"
          ),
          value = object@iter / input$GAmaxiter
        )
      }
    )
    res
  })
  
  output$mapPlot <- renderPlot({
    op <- par(mfrow = c(1, 1), mar = c(0, 0, 0, 0))
    
    m <- Map()
    plot(m, col.text = 'darkred')
    
    x <- input$plot_hover$x
    y <- input$plot_hover$y
    
    res <- Cartogram()$Cartogram
    query <-
      ((res$x - res$dx) < x) &
      (x < (res$x + res$dx)) &
      ((res$y - res$dy) < y) & (y < (res$y + res$dy))
    rv <- "no object identified."
    if (sum(query) == 1) {
      rv <- paste(res$name[query])
      idx <- which(m$name == rv)
      rect(m$x[idx] - m$dx[idx],
           m$y[idx] - m$dy[idx] ,
           m$x[idx] + m$dx[idx],
           m$y[idx] + m$dy[idx],
           col = rgb(0.8, 0.1, 0.1, 0.3))
    }
  })
  
  
  output$cartogramPlot <- renderPlot({
    res <- Cartogram()$Cartogram
    #print(res)
    op <- par(mfrow = c(1, 1), mar = c(0, 0, 0, 0))
    plot(res, col.text = 'darkred')
    # legend("topleft", paste("weight", input$objective_weight))
  })
  
  output$gaPlot <- renderPlot({
    plot(Cartogram()$GA)
  })
  
  output$foo = downloadHandler(
    filename = paste("recmap.pdf", sep = ''),
    content = function(file) {
      pdf(file, 12, 12)
      res <- Cartogram()
      plot.recmap(
        res$Cartogram,
        col.text = 'darkred',
        sub = paste(
          'U.S. state',
          input$state,
          '- rectangular cartogram generated by using https://CRAN.R-project.org/package=recmap version',
          packageVersion('recmap')
        )
      )
      dev.off()
      #plotInput()
      #dev.copy2pdf(file = file, width=12, height=8, out.type="pdf")
    }
  )
  
})
