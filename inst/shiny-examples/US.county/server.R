
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

library("maps")
library("noncensus")
data("counties")

get_county_mbb <- function(state='colorado', scaleX = 0.5, scaleY = 0.5){
  MBB <- lapply(map('county', state, plot = FALSE)$names,
                function(x){
                  r <- map('county', x, plot = FALSE)
                  dx <- scaleX * (r$range[2] - r$range[1])
                  dy <- scaleY * (r$range[4] - r$range[3])
                  x <- r$range[1] + dx
                  y <- r$range[3] + dy
                  data.frame(polyname=r$name, x=x, y=y, dx=dx, dy=dy)
                }
  )
  MBB <- do.call('rbind', MBB)
  MBB <- merge(MBB, county.fips, by='polyname')
  MBB$fips <- as.integer(MBB$fips)
  
  P <- data.frame(fips = paste(counties$state_fips,
                               counties$county_fips, sep=''),
                  z = counties$population,      
                  name = counties$county_name)
  P$fips <- as.integer(levels(P$fips))[P$fips]
  
  M <- merge(MBB, P, by='fips')
  class(M) <- c('recmap', 'data.frame')
  M
}


shinyServer(function(input, output) {
  
  output$plot_hoverinfo <- renderText({
    cat("Hover (throttled):\n")
    res <- Cartogram()
    x <- input$plot_hover$x
    y <- input$plot_hover$y
    cat(x)
    cat(res$name)
    query <- ((res$x - res$dx) < x) & (x < (res$x + res$dx)) & ((res$y - res$dy) < y) & (y < (res$y + res$dy))
    rv <- "no object identified."
    if (sum(query)==1){
      rv <- paste(res$name[query])
    }
    
    paste("state name:", rv)
  })
  
  Map <-  reactive({
    get_county_mbb(state=input$state, scaleX = input$scaleX, scaleY = input$scaleY)
  })
  
  Cartogram <- reactive({
    M <- Map()
    set.seed(1)
    res<-recmapGA(M, 
                  maxiter=input$GAmaxiter, 
                  popSize = input$GApopulation, 
                  pmutation = input$GApmutation, 
                  run = input$GArun)
    res$Cartogram
  })
  
  output$mapPlot <- renderPlot({
    op<-par(mfrow=c(1, 1), mar=c(0,0,0,0))
    plot(Map(), col.text='darkred')
  })
  
  output$cartogramPlot <- renderPlot({
    res <- Cartogram()
    op<-par(mfrow=c(1, 1), mar=c(0,0,0,0))
    plot(res, col.text='darkred')
  })

})
