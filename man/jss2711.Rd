\name{jss2711}
\alias{jss2711}
\alias{SBB}
\alias{Switzerland}
\alias{UK}
\alias{cmp_GA_GRASP}
\alias{mbb_check}
\docType{data}
\title{
jss2711 data
}
\description{
jss2711 contains the input maps for the Figures 4, 6, 7, 11, 12, 13.
}
\format{
  A set of nested list of data frames.
}

\source{
\itemize{
\item{Figure 11 -- \code{Switzerland}:
\itemize{
  \item {input map rectangles derived from:
Swiss Federal Office of Topography \url{https://www.swisstopo.admin.ch} using Landscape Models / Boundaries GG25,
downloaded 2016-05-01;}
\item{statistical data: Bundesamt fur Statistik (BFS) \url{https://www.bfs.admin.ch},
Website Statistik Schweiz, downloaded file \code{je-d-21.03.01.xls} on 2016-05-26.}}
}
\item{Figure 12 -- \code{sbb}:
\url{https://data.sbb.ch/explore/?sort=explore.download_count&refine.modified=2016} 2016-05-12}
\item{Figure 13 -- \code{UK}:
Contains National Statistics data Crown copyright and database right 2016
Contains NRS data Crown copyright and database right 2016
Source:  NISRA : Website: \url{www.nisra.gov.uk} 
Contains OS data Crown copyright [and database right] (2016)}
}
}

\author{
Christian Panse, 2018
}

\references{
\url{https://arxiv.org/abs/1606.00464}
}

\examples{
options(warn = -1)

## Figure 4 
jss2711_figure4 <- function(nrep = 1, size = 2:20){
  recmap_debug_code <- '
  // [[Rcpp::plugins(cpp11)]]
  
  #include <Rcpp.h>
  #include <string>
  #include <recmap.h>
  
  using namespace Rcpp;

  // [[Rcpp::depends(recmap)]]
  // [[Rcpp::export]]
  int recmap_debug(DataFrame df, bool map_region_intersect_multiset = true) {
    // access the columns
    NumericVector x = df["x"];
    NumericVector y = df["y"];
    NumericVector dx = df["dx"];
    NumericVector dy = df["dy"];
    
    
    NumericVector z = df["z"];
    CharacterVector name = df["name"];
    
    NumericVector cartogram_x(x.size());
    NumericVector cartogram_y(x.size());
    NumericVector cartogram_dx(x.size());
    NumericVector cartogram_dy(x.size());
    
    NumericVector dfs_num(x.size());
    NumericVector topology_error(x.size());
    NumericVector relpos_error(x.size());
    NumericVector relpos_nh_error(x.size());
   
    crecmap::RecMap X;
    X.set_map_region_intersect_multiset(map_region_intersect_multiset);
    
    for (int i = 0; i < x.size(); i++) {
      std::string sname = Rcpp::as<std::string>(name[i]);
      X.push_region(x[i], y[i], dx[i], dy[i], z[i],  sname);
    }
    
    X.run(true);
    
    return(X.get_intersect_count());
  }
  '
  
  sourceCpp(code = recmap_debug_code, rebuild = TRUE, verbose = TRUE)
  
  do.call('rbind', lapply(size, function(size){
    set.seed(1);
    CB <- checkerboard(size); 

    do.call('rbind',lapply(rep(size, nrep), function(n){

      CB.smp <- CB[sample(nrow(CB), nrow(CB)), ]
      start_time <- Sys.time()
      ncall.multiset <- recmap_debug(CB.smp, map_region_intersect_multiset = TRUE)
      end_time <- Sys.time()
      diff_time.multiset <- as.numeric(difftime(end_time, start_time, units = "secs"))


      start_time <- Sys.time()
      ncall.list <- recmap_debug(CB.smp, map_region_intersect_multiset = FALSE)
      end_time <- Sys.time()
      diff_time.list <- as.numeric(difftime(end_time, start_time, units = "secs"))

      #do.call('rbind', list(data.frame(algorithm = "multiset", number = ncall.multiset, size = nrow(CB)),
      #  data.frame(algorithm = "list", number = ncall.list, size = nrow(CB))))
      #data.frame(algorithm = "multiset", number = ncall.multiset, size = nrow(CB))
      rv <- rbind(data.frame(number = ncall.multiset, algorithm="multiset", size = nrow(CB), time_in_secs = diff_time.multiset),
        data.frame(number = ncall.list, algorithm="list", size = nrow(CB), time_in_secs =  diff_time.list))

      rv$machine <- Sys.info()['machine']
      rv$sysname <- Sys.info()['sysname']
      rv
      }))
    }))
}

mbb_check <- jss2711_figure4()

boxplot(number  ~ sqrt(size),
  axes=FALSE,
  data = mbb_check,
  log='y', 
  cex = 0.75,
  subset = algorithm == "list", 
  col = "red", boxwex = 0.25); 
abline(v = sqrt(50), col = 'lightgray', lwd = 3)

boxplot(number  ~ sqrt(size), 
  data = mbb_check,log='y',
  subset = algorithm == "multiset",
  cex = 0.75,
  ylab = 'number of MBB intersection calls',
  xlab = 'number of map regions',
  boxwex = 0.25, add = TRUE, axes=FALSE); 
axis(2)
axis(1, c(5, sqrt(50), 10, 15, 20), c("5x5", "US", "10x10", "15x15", "20x20"))
box()

legend("bottomright", c("C++ STL list", "C++ STL multiset"),
      col=c('red', 'black'), pch = 16, cex = 1.0)




data(package = "recmap")
data(jss2711)

## Figure 6 - right
op <- par(mar = c(4, 4, 2, 2), mfrow = c(1, 1), bg = 'white')

plot(cmp_GA_GRASP$GA[, 1], cmp_GA_GRASP$GA[, 2], type = 'b',
     xlab = 'elapsed time [in seconds]',
     ylab = 'recmap.fitness', pch = 22, lwd = 2)

lines(cmp_GA_GRASP$GRASP[, 1], cmp_GA_GRASP$GRASP[, 2], col = 'red', type = 'b', pch = 23)
legend("bottomright", c("GA", "GRASP"), col = c('black', 'red'),
    pch=c(22, 23), cex=1.5)


## Figure 7
\dontrun{

res <- lapply(c(1, 1, 2, 2, 3, 3), function(seed){
  set.seed(seed); 
  res <- recmapGA(Map = checkerboard(4), pmutation = 0.25)
  res$seed <- seed
  res})
 
op <- par(mfcol=c(2,4), bg='azure', mar=c(5, 5, 0.5, 0.5))

x <- recmap(checkerboard(4))
p <- paste(' = (', paste(1:length(x$z), collapse=", "), ')', sep='')
plot(x, 
      sub=substitute(paste(Pi['forward'], p), list(p=p)), 
      col = c('white', 'white', 'white', 'black')[x$z])

x <- recmap(checkerboard(4)[rev(1:16),])
p <- paste(' = (', paste(rev(1:length(x$z)), collapse=", "), ')', sep='')
plot(x, 
      sub=substitute(paste(Pi[reverse], p), list(p=p)), 
      col = c('white', 'white', 'white', 'black')[x$z])


rv <- lapply(res, function(x){
  p <- paste(' = (', paste(x$GA@solution[1,], collapse=", "), ')', sep='')
  plot(x$Cartogram, 
       col = c('white', 'white', 'white', 'black')[x$Cartogram$z],
       sub=substitute(paste(Pi[seed], perm), list(perm=p, seed=x$seed)))
  }) 
}

# sanity check - reproducibility 

identical.recmap <- function(x, y, plot.diff = FALSE){
  target <- x
  current <- y 
  
  stopifnot(is.recmap(target))
  stopifnot(is.recmap(current))
  rv <- identical(x$x, y$x) && identical(x$y, y$y) && identical(x$dx, y$dx) && identical(x$dy, y$dy)
  if (plot.diff){
   rvtemp <- lapply(c('x', 'y', 'dx', 'dy'), function(cn){
        plot(sort(abs(target[, cn] - current[, cn])),
          ylab = 'absolute error',
          main = cn)
        abline(h = 0, col = 'grey')
      })
  }
  
  rv 
}

\dontrun{
op <- par(mfcol = c(4, 4), mar = c(4, 4, 4, 1)); 
identical.recmap(res[[1]]$Cartogram, res[[2]]$Cartogram, TRUE) 
identical.recmap(res[[3]]$Cartogram, res[[4]]$Cartogram, TRUE) 
identical.recmap(res[[5]]$Cartogram, res[[6]]$Cartogram, TRUE) 
identical.recmap(res[[1]]$Cartogram, res[[6]]$Cartogram, TRUE) 
}

## Figure 11
\dontrun{plot(recmap(Switzerland$map[Switzerland$solution,]))}

op <- par(mfrow=c(1, 1), mar=c(0,0,0,0)); 

C <- Switzerland$cartogram
class(C) <- c('recmap', 'data.frame')

plot(C)

idx <- rev(order(C$z))[1:50];

text(C$x[idx], C$y[idx], C$name[idx], col = 'red', 
  cex = C$dx[idx] / strwidth(as.character(C$name[idx])))

## Figure 12

fitness.SBB <- function(idxOrder, Map, ...){
  Cartogram <- recmap(Map[idxOrder, ])
  if (sum(Cartogram$topology.error == 100) > 1){return (0)}
  1 / sum(Cartogram$z / (sqrt(sum(Cartogram$z^2))) * Cartogram$relpos.error)
}

\dontrun{
SBB <- recmapGA(SBB$Map, 
  parallel=TRUE, 
  maxiter=1000, 
  run=1000, 
  seed = 1, 
  keepBest = TRUE,
  fitness=fitness.SBB)
}

SBB.Map <- SBB$Map

# make input map overlapping
S <- SBB$Map
S <- S[!is.na(S$x),]
S$dx <- 0.1; S$dy <- 0.1; S$z <- S$DTV
S$name <- S$Bahnhof_Haltestelle

op <- par(mfrow = c(2, 1), mar = c(0, 0, 0, 0))
plot.recmap(S)
idx <- rev(order(S$z))[1:10]
text(S$x[idx], S$y[idx], S$name[idx], col='red', cex=0.7)
idx <- rev(order(S$z))[11:30]
text(S$x[idx], S$y[idx], S$name[idx], col = 'red', cex = 0.5)

Cartogram.recomp <- recmap(S[sol <- SBB$GA@solution[1, ], ])
plot(Cartogram.recomp)

idx <- rev(order(Cartogram.recomp$z))[1:40]
text(Cartogram.recomp$x[idx],Cartogram.recomp$y[idx],
	Cartogram.recomp$name[idx],
	col = 'red',
	cex = 1.25 * Cartogram.recomp$dx[idx] / strwidth(Cartogram.recomp$name[idx]))

# sanity check - reproducibility cross plattform
op <- par(mfrow = c(2, 2), mar = c(5, 5, 5, 5))
identical.recmap(Cartogram.recomp, SBB$Cartogram, TRUE)


## Figure 13

DF <- data.frame(Pct_Leave = UK$Map$Pct_Leave, row.names = UK$Map$name)
spplot(as.SpatialPolygonsDataFrame(UK$Map, DF), 
  main="Input England/Wales/Scottland")

UK.recmap <- recmap(UK$Map)
spplot(as.SpatialPolygonsDataFrame(UK.recmap , DF))

# sanity check - reproducibility cross plattform
op <- par(mfrow=c(2,2), mar=c(5,5,5,5))
identical.recmap(UK.recmap, UK$Cartogram, TRUE)

}
\keyword{datasets}
