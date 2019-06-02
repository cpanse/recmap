#R


#' this function reproduces the original election cartogram from 2004 using 
#' the cartogram output from the 2003 implementation.
#'
#' @param plot default is TRUE
#'
#' @return the plot
.draw_recmap_us_state_ev <- function(plot=TRUE){
  
  
  # red-blue bi-poloar colormap 100; used in all CartoDraw / RecMap 
  # publications since 2001 for visualizing cartographic error / scaling factor 
  # and elelction data; exported from CartoView 
  
  cm <- c("#FF0000", "#FF0505", "#FF0A0A", "#FF1010", "#FF1515", "#FF1A1A", "#FF1F1F",
          "#FF2424", "#FF2A2A", "#FF2F2F", "#FF3434", "#FF3939", "#FF3E3E", "#FF4444",
          "#FF4949", "#FF4E4E", "#FF5353", "#FF5858", "#FF5E5E", "#FF6363", "#FF6868",
          "#FF6D6D", "#FF7272", "#FF7878", "#FF7D7D", "#FF8282", "#FF8787", "#FF8D8D",
          "#FF9292", "#FF9797", "#FF9C9C", "#FFA1A1", "#FFA7A7", "#FFACAC", "#FFB1B1",
          "#FFB6B6", "#FFBBBB", "#FFC1C1", "#FFC6C6", "#FFCBCB", "#FFD0D0", "#FFD5D5",
          "#FFDBDB", "#FFE0E0", "#FFE5E5", "#FFEAEA", "#FFEFEF", "#FFF5F5", "#FFFAFA",
          "#FFFFFF", "#FFFFFF", "#FAFAFF", "#F5F5FF", "#EFEFFF", "#EAEAFF", "#E5E5FF",
          "#E0E0FF", "#DBDBFF", "#D5D5FF", "#D0D0FF", "#CBCBFF", "#C6C6FF", "#C1C1FF",
          "#BBBBFF", "#B6B6FF", "#B1B1FF", "#ACACFF", "#A7A7FF", "#A1A1FF", "#9C9CFF",
          "#9797FF", "#9292FF", "#8D8DFF", "#8787FF", "#8282FF", "#7D7DFF", "#7878FF",
          "#7272FF", "#6D6DFF", "#6868FF", "#6363FF", "#5E5EFF", "#5858FF", "#5353FF",
          "#4E4EFF", "#4949FF", "#4444FF", "#3E3EFF", "#3939FF", "#3434FF", "#2F2FFF",
          "#2A2AFF", "#2424FF", "#1F1FFF", "#1A1AFF", "#1515FF", "#1010FF", "#0A0AFF",
          "#0505FF", "#0000FF")
  
  # does not look so impressive
  # cm <- rev(diverge_hcl(100))
  recmap_us_state_ev.file <- system.file("extdata", 
                                         "recmap_us_state_ev.polygon", 
                                         package = "recmap")
  
  recmap_us_state_ev <- read.table(recmap_us_state_ev.file, sep = '|', 
                                   col.names=c('x', 'y'))
  
  us_state_election_2004.file <- system.file("extdata", 
                                             "us_state_election_2004.csv", 
                                             package = "recmap")
  
  us_state_election_2004 <- read.table(us_state_election_2004.file, 
                                       sep = ',')
  if(plot){

    idx <- seq(1, nrow(recmap_us_state_ev), by=5)
    
    x.max <- apply(cbind(recmap_us_state_ev$x[idx], 
                         recmap_us_state_ev$x[idx+1], 
                         recmap_us_state_ev$x[idx+2],
                         recmap_us_state_ev$x[idx+3]), 1, max)
    x.min <- apply(cbind(recmap_us_state_ev$x[idx], 
                         recmap_us_state_ev$x[idx+1], 
                         recmap_us_state_ev$x[idx+2], 
                         recmap_us_state_ev$x[idx+3]), 1, min)
    
    y.max <- apply(cbind(recmap_us_state_ev$y[idx], 
                         recmap_us_state_ev$y[idx+1], 
                         recmap_us_state_ev$y[idx+2], 
                         recmap_us_state_ev$y[idx+3]), 1, max) 
    
    y.min <- apply(cbind(recmap_us_state_ev$y[idx],
                         recmap_us_state_ev$y[idx+1],
                         recmap_us_state_ev$y[idx+2],
                         recmap_us_state_ev$y[idx+3]), 1, min)
    
    
    dx <- 0.5 * (x.max - x.min)
    dy <- 0.5 * (y.max - y.min)
    
    
    M <- data.frame(x=x.min + dx, 
                    y=y.min + dy, 
                    dx=dx, dy=dy, 
                    z=(us_state_election_2004$V8/(us_state_election_2004$V8 + us_state_election_2004$V9)),
                    name=gsub(' ', '\n', as.character(us_state_election_2004$V3)))

    tcol <- rep('black', nrow(us_state_election_2004))
    tcol[8] <- 'white'
    
    plot.recmap(M,
                col.text = tcol,
                border=NULL,
                col=cm[round(length(cm) * (us_state_election_2004$V8/(us_state_election_2004$V8 + us_state_election_2004$V9)))+1])
  }else{
    M
  }
}


#' construct polygon mesh displayed in Figure 4a in 
#' \url{https://doi.org/10.1109/TVCG.2004.1260761}
#'
#' @param A defines the area of a region in the center
#'
#' @return a \link{SpatialPolygons} object 
#' @export
#'
#' @examples
#' triangle.map <- recmap:::.get_7triangles()
#' z <- c(rep(4, 4), rep(1, 3))
#' cols <- c(rep('white', 4), rep('grey',3))
#' 
#' op <- par(mfrow=c(1,2), mar=c(0, 0, 0, 0))
#' plot(triangle.map, col=cols)
#' 
#'  # requires libfft.so installed in linux 
#' if (require(getcartr) & require(Rcartogram)){
#'   cartogram <- quick.carto(triangle.map, z, res=64)
#'   plot(cartogram, col=cols)
#' }
.get_7triangles <- function(A=1){
  t<-list()
  
  tan30 <- tan(30 / 180 * pi)
  tan60 <- tan(60 / 180 * pi)
  sin30 <- sin(30 / 180 * pi)
  sin60 <- sin(60 / 180 * pi)
  cos30 <- cos(30 / 180 * pi)
  
  l <- sqrt(2 * A / sin60) 
  
  t[[1]] <-  Polygons(list(Polygon(cbind(c( 0.0, l, l/2), c( 0.0, 0.0, h <- tan60 * l / 2)))), 1)
  
  
  b <- h - (tan30 * l / 2)
  c <- -tan30 * A
  
  h2 <- - b /2 + sqrt((b/2)^2 -c) 
  
  y <- h + h2 
  
  x <- y / tan30
  
  h3 <- (y / sin30) - h  
  h4 <- sqrt((x - cos30 * h)^2 + (y - sin30 * h)^2)
  stopifnot (abs(h3 - h4) < 0.01)
  
  t[[2]] <- Polygons(list(Polygon(cbind(c( l / 2, x, l/2 - (x-l / 2)), c(h, y, y)))), 2)
  t[[3]] <- Polygons(list(Polygon(cbind(c(l / 2, l, x), c(-h3,0,y)))), 3)
  t[[4]] <- Polygons(list(Polygon(cbind(c(l / 2,  l / 2 - (x-l / 2), 0), c(-h3, y, 0)))), 4)
  t[[5]] <- Polygons(list(Polygon(cbind(c(0, l / 2 - (x-l / 2), l / 2), c(0, y, h)))), 5)
  t[[6]] <- Polygons(list(Polygon(cbind(c(l, x, l / 2), c(0, y, h)))), 6)
  t[[7]] <- Polygons(list(Polygon(cbind(c( 0.0, l, l / 2), c(0, 0, -h3)))), 7)
  
  triangle.map <- SpatialPolygons(t)

  triangle.map
}


checkerboard <- function(n = 8, ratio = 4){
  xy <- (t(combn(1:n, 2)))
  xy <- rbind(cbind(xy[,1], xy[,2]), cbind(xy[,2], xy[,1]), cbind(1:n, 1:n))
  
  
  z.bool <- (xor(xy[,1] %% 2 == 1 , xy[,2] %% 2 == 0))
  z <- rep(1, length(xy[,1]))
  
  z[which(z.bool)] <- z[which(z.bool)] * ratio
  z[which(!z.bool)] <- z[which(!z.bool)] 
  
  res <- data.frame(x = xy[, 1], 
                    y = xy[,2], 
                    dx = 0.5, 
                    dy = 0.5, 
                    z = z, 
                    name=paste(letters[1:n][xy[,1]], xy[,2], sep=''))
  

  
  res <- res[with(res, order(x, y)), ]
  row.names(res) <- 1:nrow(res); # paste(letters[1:n][xy[,1]], xy[,2], sep='')
  attr(res, 'Map.name') <- paste("checkerboard", n, "x", n)
  attr(res, 'Map.area') <- "1:4"
  class(res) = c('recmap', class(res))
  res
}

all.equal.recmap <- function(target, current, ...){
  isTRUE(all.equal(target$x, current$x, ...)) &
  isTRUE(all.equal(target$y, current$y, ...)) &
  isTRUE(all.equal(target$dx, current$dx, ...)) & 
  isTRUE(all.equal(target$dy, current$dy, ...)) &
  isTRUE(all.equal(target$z, current$z, ...)) &
  isTRUE(all.equal(target$name, current$name, ...))
}

is.recmap <- function(object){
  if(sum(c("x", "y", "dx", "dy", "z") %in% names(object)) != 5) {
    message("column names 'x', 'y', 'dx', 'dy', and 'z' are required.")
    return (FALSE)
  }
  
  if (!is.numeric(object$x)){
    message("x is not numeric.")
    return(FALSE)
  }
  
  if (!is.numeric(object$y)) {
    message("y is not numeric.")
    return(FALSE)
  }
  
  if (!is.numeric(object$dx)){
    message("dx is not numeric.")
    return(FALSE)
  }
  
  if (!is.numeric(object$dy)){
    message("dy is not numeric.")
    return(FALSE)
  }
  
  if (!is.numeric(object$z)){
    message("z is not numeric.")
    return(FALSE)
  }
  
  if (sum(object$dx < 0) != 0) {
    message('dx values have to be greater than 0.')
    return(FALSE)
  }
  
  if (sum(object$dy < 0) != 0){
    message('dy values have to be greater than 0.')
    return(FALSE)
  }
  
  if (sum(object$z <= 0) != 0){
    message('z values have to be greater equal than 0.')
    return(FALSE)
  }
  
  if (nrow(object) < 2) {
    message('requires at least two map regions.')
    return(FALSE)
  }
  
  
  return (TRUE)
}


recmap <- function(V, E = data.frame(u=integer(), v=integer())) {

  if (is.recmap(V)){
    res <- recmap_(V, E)
  
    class(res) = c('recmap', class(res))
    res
  }
}


as.SpatialPolygonsDataFrame <- function (x, ...) {
	    UseMethod("as.SpatialPolygonsDataFrame", x)
}

# requires https://CRAN.R-project.org/package=sp 
as.SpatialPolygonsDataFrame.recmap <- function(x, df = NULL, ...){
  if (is.recmap(x)){
  SpP <- SpatialPolygons(lapply(1:nrow(x), function(i){
    r <- x[i, ]
    Sr <- Polygon(cbind(c(r$x - r$dx, 
                          r$x - r$dx, 
                          r$x + r$dx, 
                          r$x + r$dx), 
                        c(r$y + r$dy, 
                          r$y - r$dy, 
                          r$y - r$dy, 
                          r$y + r$dy)))
    
    Polygons(list(Sr), r$name)
  }))
  
  if (is.null(df)){
    return(SpatialPolygonsDataFrame(SpP, 
                                    data.frame(z = x$z, 
                                               row.names = x$name)))}
  
  return(SpatialPolygonsDataFrame(SpP, df))
  }

message("as.SpatialPolygonsDataFrame.recmap failed.")

NULL
}


as.recmap <- function(X){
	UseMethod("as.recmap", X)
}

as.recmap.SpatialPolygonsDataFrame <- function(X){
  
  if (class(X) == "SpatialPolygonsDataFrame"){
    n <- length(X@polygons)
    
    df <- do.call('rbind', lapply(1:n, function(id){
      
      
      do.call('rbind', lapply(X@polygons[id], function(p){
        mbb <- bbox(p)
        
        x.min <- mbb['x','min']
        x.max <- mbb['x','max']
        y.min <- mbb['y','min']
        y.max <- mbb['y','max']
        
        dx <- 0.5 * (x.max - x.min)
        dy <- 0.5 * (y.max - y.min)
        
        data.frame(x = x.min + dx, y = y.min + dy, dx = dx, dy = dy, name=p@ID)
      }))
      
    }))
    
   df <- cbind(df, X@data) 

   if (is.recmap(df)){
   	if (is.null(attr(X, 'Map.name'))){
   		attr(df, 'Map.name')  <- ""
	}
   	if (is.null(attr(X, 'Map.area'))){
   		attr(df, 'Map.area')  <- ""
   	}
	df <- df[, c('x', 'y', 'dx', 'dy', 'z', 'name')]
	row.names(df) <- 1:nrow(df)
  	class(df) <- c('recmap', class(df))
   	return(df)
   } else if (!'z' %in% names(df)){
	   warning("Can not find 'z' column name in data.frame. Define 'z' and continue." )
   }
   return(df)

  }else{
    message('requires a "SpatialPolygonsDataFrame" class as argument.')
  }
    return (NULL)

}

.compute_area_error <- function(x){
  
  area <- 4 * x$dx * x$dy 
  sumZ <- sum(x$z)
  
  areaDesired <- x$z * sum(area) / sumZ
  
  error <- abs(areaDesired - area) / (areaDesired + area)
  
  sum(error * x$z) / sumZ
}

.compute_topology_error <- function(x){
  
  if (sum(x$topology.error == -1) > 0)
    return(Inf)
  
  sum(x$topology.error) 
}


.compute_relpos_error <- function(x){
  sum(x$relpos.error) / nrow(x)
}

summary.recmap <- function(object, ...) {

  x <- object

  if (!is.recmap(x)){ return (NULL) }

  if (is.recmap(x)){
    
    nRegions <- nrow(x)
    errorArea <- round(.compute_area_error(x), 2)
    errorTopology <- NA
    errorRelPos <- NA
    spaceFilling <- 100 * sum(4 * x$dx * x$dy) / ((max(x$x + x$dx) - min(x$x - x$dx)) * (max(x$y + x$dy) - min(x$y - x$dy)))
   
    if ("dfs.num" %in% names(x)){
      errorTopology <- .compute_topology_error(x)
      errorRelPos <-  round(.compute_relpos_error(x), 2)
    } 
    
    
    
    data.frame(row.names = c("number of map regions", 
                      "area error", 
                      "topology error", 
                      "relative position error",
		      "screen filling [in %]",
                      "xmin",
                      "xmax",
                      "ymin",
                      "ymax"), 
          values = c(nRegions, errorArea, errorTopology, errorRelPos,
	  	    spaceFilling,
                     min(x$x - x$dx),
                     max(x$x + x$dx),
                     min(x$y - x$dy),
                     max(x$y + x$dy)))
    
  }
  
}

plot.recmap <- function(x, col='#00000011', col.text = 'grey', border = 'darkgreen', ...){

  if (!is.recmap(x)){ return (NULL) }

  label.text <- TRUE
  S <- x
  
  plot(S$x, S$y, 
       xlim = c(min(S$x - S$dx), max(S$x + S$dx)), 
       ylim = c(min(S$y - S$dy), max(S$y + S$dy)), 
       type = 'n', 
       asp = 1,
       xlab = '',
       ylab = '',
       axes = FALSE, ...)
  
  rect(xleft = S$x - S$dx, 
       ybottom = S$y - S$dy,  
       xright = S$x + S$dx, 
       ytop = S$y + S$dy, 
       col = col, 
       border = border)
  
  if (sqrt(length(S$x)) < 10 & label.text){
    text(S$x, S$y, 
         S$name,
	       cex = S$dx / strwidth(S$name),
         col = col.text)
  }
}

.plot_recmap_error <- function(S){
  
  plot(sort(S$relpos.error),
       main="relpos.error",
       ylab=expression(paste("normalized angle [in ", pi,"]")))

  axis(4, c(0.25,0.5,0.75)*pi, c(0.25,0.5,0.75))
  abline(h=c(0.25,0.5,0.75)*pi, col="#55555555")
  
  plot(sort(S$relposnh.error),
       main="relposnh.error", 
       ylab=expression(paste("normalized angle [in ", pi,"]")))

  axis(4, c(0.25,0.5,0.75)*pi, c(0.25,0.5,0.75))
  abline(h=c(0.25,0.5,0.75)*pi, col="#55555555")
  
}


# define a fitness function
.recmap.fitness <- function(idxOrder, Map, ...){
  Cartogram <- recmap(Map[idxOrder, ])
  # a map region could not be placed; 
  # accept only feasible solutions!
  
  if (sum(Cartogram$topology.error == -1) > 0){return (0)}
  
  1 / sum(Cartogram$relpos.error)
}

recmapGRASP <-
  function(Map, 
           fitness = .recmap.fitness, 
           n.samples = nrow(Map) * 2,
           fitness.cutoff = 1.7, 
           iteration.max = 10){
    
    input <- Map
    solution.best <- NULL; iteration <- 0; f.max <- 0.0;
    
    # GRASP stopping criterion not satisfied
    while (f.max < fitness.cutoff && iteration < iteration.max){
      iteration <- iteration + 1
      
      # Construct Greedy Randomized Solution
      # res <- parallel::mclapply(1:n.samples, function(x){
      res <- lapply(1:n.samples, function(x){
        smp <- sample.int(nrow(input))
        list(solution = smp,
             fitness = fitness(smp, input))
      })
      
      f.mean <- mean(sapply(res, function(x){x$fitness}))
      
      idx <- order(sapply(res, function(x){x$fitness}),
                   decreasing = TRUE)[1]
      
      solution <- res[[idx]]
      
      f <- solution$fitness
      
      # UpdateSolution
      if (f > f.max){ f.max <- f; solution.best <- solution; }
      cat(paste(format(Sys.time(), "%s GRASP"), 
                round(f.max, 2), 
                round(f.mean, 2),
                iteration, "\n"))
    }
    
    r <- list(GRASP = solution.best, 
         Map = Map, 
         Cartogram = recmap(Map[solution.best$solution, ])
         )
    
    class(r) <- c(class(r), 'recmapGRASP')
    r
}


recmapGA <- function(Map, 
                      fitness = .recmap.fitness,
                      pmutation = 0.25, 
                      popSize = 10 * nrow(Map), 
                      maxiter = 10, 
                      run = maxiter,
                      monitor = if(interactive()) 
                      { gaMonitor } 
                     else FALSE,
                      parallel = FALSE, ...){
  start_time <- Sys.time()
  GA <- ga(type = "permutation", 
           fitness = fitness, 
           Map = Map,
           monitor = monitor,
           lower = 1, upper = nrow(Map) , 
           popSize = popSize, 
           maxiter = maxiter, 
           run = run, 
           parallel = parallel,
           pmutation = pmutation, 
	   ...)
  end_time <- Sys.time()
  diff_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
   if (is.null(attr(Map, 'Map.name'))){
   	attr(Map, 'Map.name')  <- ""
	}
   if (is.null(attr(Map, 'Map.area'))){
   	attr(Map, 'Map.area')  <- ""
   }
  res <- list(GA = GA, 
              Map = Map[GA@solution[1, ], ], 
              Cartogram = recmap(Map[GA@solution[1, ], ]),
	      Summary = data.frame(
      Map.name = attr(Map, 'Map.name'),
      Map.area = tolower(attr(Map, 'Map.area')),
      Map.number.regions = length(GA@solution[1,]),
      Map.error.area = round(.compute_area_error(Map), 2),
      GA.population.size = as.integer(GA@popSize),
      GA.number.generation = nrow(GA@summary),
      GA.pmutation = GA@pmutation,
      GA.fitness = round(GA@fitnessValue, 2),
      GA.parallel = parallel,
      GA.number.recmaps_a_second = round((as.integer(GA@popSize) * nrow(GA@summary) / diff_time), 1),
      Sys.compute.time = round(diff_time, 1),
      Sys.machine = Sys.info()['machine'],
      Sys.sysname = Sys.info()['sysname'])
    )
  
  
  class(res) = c('recmapGA', class(res))
  res
}


plot.recmapGA <- function(x, ...){
	plot(x$GA, main="GA")
	plot.recmap(x$Map, main="input map", ...)
	plot.recmap(x$Cartogram, main = "output cartogram", ...)
}

plot.recmapGRASP <- function(x, ...){
  plot.recmap(x$Map, main="input map", ...)
  plot.recmap(x$Cartogram, main = "output cartogram", ...)
}

summary.recmapGA <- function(object, ...){
  cat("summary of class recmapGA:\n")
  cat("summary of the GA:\n")
  print(summary.ga(object$GA))
  
  S <- summary.recmap(object$Map)
	names(S) <- "Map"
	S$Cartogram <- summary.recmap(object$Cartogram)$values
	print(S)
}
