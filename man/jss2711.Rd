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
jss2711 contains the replication materials (input and output) for the 
\doi{10.18637/jss.v086.c01} manuscript's
Figures 4, 5, 6, 7, 11, 12, and 13.
}

\format{
  A set of nested \code{list} of \code{data.frames}.
}

\source{
  \itemize{
    \item{Figure 4 -- \code{mbb_check} contains a \code{data.frame} with some
    \code{recmap} implemention benchmarks. Generated on
    \itemize{
    \item {MacBook Pro (15-inch, 2017).}
    \item {Processor: 2.9 GHz Intel Core i7}
    \item {Memory: 16 GB 2133 MHz LPDDR3}
    }
  }

  \item{Figure 5 -- \code{cmp_GA_GRASP} contains a \code{list} of results using 
a \code{\link[recmap:recmapGA]{GRASP}} and \code{\link[GA:ga]{GA}} metaheuristic.
Generated on a MacBook Pro (Retina, 13-inch, Mid 2014).}

  \item{Figure 11 -- \code{Switzerland}:
    \itemize{
      \item {input map rectangles derived from:
    Swiss Federal Office of Topography \url{https://www.swisstopo.admin.ch} using Landscape Models / Boundaries GG25,
    downloaded 2016-05-01; Perfomed on a Intel(R) Xeon(R) CPU E5-2698 v3 @ 2.30GHz/ Debian8}
      \item{statistical data: Bundesamt fur Statistik (BFS) \url{https://www.bfs.admin.ch},
    Website Statistik Schweiz, downloaded file \code{je-d-21.03.01.xls} on 2016-05-26.}, 
      \item{Perfomed on a Intel(R) Xeon(R) CPU E5-2698 v3 @ 2.30GHz/ Debian8.}
      }}


\item{Figure 12 -- \code{SBB}}: 
  \itemize{
  \item {Source: \href{https://data.sbb.ch/explore/?sort=explore.download_count&refine.modified=2016}{https://data.sbb.ch/explore} 2016-05-12}.
 \item{Perfomed on a Intel(R) Xeon(R) CPU E5-2698 v3 @ 2.30GHz/ Debian 8.}
}

\item{Figure 13 -- \code{UK}}:
  \itemize{
    \item {input map rectangles derived from: \code{https://census.edina.ac.uk/ukborders};
      Contains OS data Crown copyright [and database right] (2016);}
    \item {Source of election data: \href{https://www.nisra.gov.uk}{NISRA}}
    \item {copyright - Contains National Statistics data Crown copyright and database right 2016
    Contains NRS data Crown copyright and database right 2016}
    \item {Perfomed on a Intel(R) Xeon(R) CPU E5-2698 v3 @ 2.30GHz/ Debian8}
    }}
}


\author{
 Christian Panse, 2018
}

\references{
Panse C (2018). "Rectangular Statistical Cartograms in R: The recmap
Package." Journal of Statistical Software, Code Snippets, 86(1),
pp. 1-27. \doi{10.18637/jss.v086.c01}.
}

\examples{
options(warn = -1)

## Figure 4 
jss2711_figure4 <- function(nrep = 1, size = 2:10){
  recmap_debug_code <- '
  // [[Rcpp::plugins(cpp11)]]
  
  #include <Rcpp.h>
  #include <string>
  #include <recmap.h>
  
  using namespace Rcpp;

  // [[Rcpp::depends(recmap)]]
  // [[Rcpp::export]]
  int recmap_debug(DataFrame df,
    bool map_region_intersect_multiset = true) {
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
      ncall.multiset <- recmap_debug(CB.smp,
         map_region_intersect_multiset = TRUE)

      end_time <- Sys.time()

      diff_time.multiset <- as.numeric(difftime(end_time,
        start_time, units = "secs"))


      start_time <- Sys.time()
      ncall.list <- recmap_debug(CB.smp,
        map_region_intersect_multiset = FALSE)
      end_time <- Sys.time()
      diff_time.list <- as.numeric(difftime(end_time,
        start_time, units = "secs"))

      rv <- rbind(data.frame(number = ncall.multiset,
        algorithm="multiset", size = nrow(CB),
	  time_in_secs = diff_time.multiset),
        data.frame(number = ncall.list,
	  algorithm="list", size = nrow(CB),
	    time_in_secs =  diff_time.list))

      rv$machine <- Sys.info()['machine']
      rv$sysname <- Sys.info()['sysname']
      rv
      }))
    }))
}

\dontrun{
	mbb_check <- jss2711_figure4()
}

data(jss2711)
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



## Figure 5

op <- par(mar=c(0, 0, 0, 0), mfrow=c(1, 3), bg = 'azure')

plot(cmp_GA_GRASP$GRASP$Map,
     border='black',
     col=c('white', 'white', 'white', 'black')[cmp_GA_GRASP$GRASP$Map$z])

plot(cmp_GA_GRASP$GRASP$Cartogram,
     border='black',
     col = c('white', 'white', 'white', 'black')[cmp_GA_GRASP$GRASP$Cartogram$z])

plot(cmp_GA_GRASP$GA$Cartogram,
     border='black',
     col = c('white', 'white', 'white', 'black')[cmp_GA_GRASP$GA$Cartogram$z])
par(op)

## Figure 6 - right

op <- par(mar = c(0, 0, 0, 0), mfrow=c(1, 1), bg = 'azure')
# found by the GA
smp <- cmp_GA_GRASP$GA$GA@solution[1,]

Cartogram.Checkerboard <- recmap(cmp_GA_GRASP$GA$Map[smp, ])
idx <- order(Cartogram.Checkerboard$dfs.num)

plot(Cartogram.Checkerboard,
     border='black',
     col=c('white', 'white', 'white', 'black')[Cartogram.Checkerboard$z])

# draw placement order
lines(Cartogram.Checkerboard$x[idx],
  Cartogram.Checkerboard$y[idx],
  col = rgb(1,0,0, alpha=0.3), lwd = 4, cex=0.5)

text(Cartogram.Checkerboard$x[idx],
  Cartogram.Checkerboard$y[idx],
  1:length(idx), pos=1, col=rgb(1,0,0, alpha=0.7))

points(Cartogram.Checkerboard$x[idx[1]],
  Cartogram.Checkerboard$y[idx[1]], lwd = 5, col = 'red')
text(Cartogram.Checkerboard$x[idx[1]],
  Cartogram.Checkerboard$y[idx[1]], "start", col = 'red', pos=3)
points(Cartogram.Checkerboard$x[idx[length(idx)]],
  Cartogram.Checkerboard$y[idx[length(idx)]],
       cex = 1.25, lwd = 2, col = 'red', pch = 5)
par(op)
op <- par(mar = c(4, 4, 1.5, 0.5), mfrow = c(1, 1), bg = 'white')
plot(best ~ elapsedtime, data = cmp_GA_GRASP$cmp,
     type = 'n',
     ylab = 'best fitness value',
     xlab = 'elapsed time [in seconds]')
abline(v=60, col='lightgrey',lwd=2)
lines(cmp_GA_GRASP$cmp[cmp_GA_GRASP$cmp$algorithm == "GRASP",
  c('elapsedtime', 'best')], type = 'b', col='red', pch=16)
lines(cmp_GA_GRASP$cmp[cmp_GA_GRASP$cmp$algorithm == "GA",
  c('elapsedtime', 'best')], type = 'b', pch=16)
legend("bottomright", 
  c("Evolutionary based Genetic Algorithm (GA)",
    "Greedy Randomized Adaptive Search Procedures (GRASP)"),
    col = c('black', 'red'),
       pch=16, cex=1.0)

par(op)

## Figure 7
\dontrun{

res <- lapply(c(1, 1, 2, 2, 3, 3), function(seed){
  set.seed(seed); 
  res <- recmapGA(V = checkerboard(4), pmutation = 0.25)
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
  rv <- identical(x$x, y$x) && identical(x$y, y$y)  && 
    identical(x$dx, y$dx) && identical(x$dy, y$dy)
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

C <- Switzerland$Cartogram

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
SBB <- recmapGA(V=SBB$Map, 
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

Cartogram.recomp <- recmap(S)
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

\dontrun{
DF <- data.frame(Pct_Leave = UK$Map$Pct_Leave, row.names = UK$Map$name)
spplot(as.SpatialPolygonsDataFrame(UK$Map, DF), 
  main="Input England/Wales/Scottland")

UK.recmap <- recmap(UK$Map)
spplot(as.SpatialPolygonsDataFrame(UK.recmap , DF))

# sanity check - reproducibility cross plattform
op <- par(mfrow=c(2,2), mar=c(5,5,5,5))
identical.recmap(UK.recmap, UK$Cartogram, TRUE)
}

}
\keyword{datasets}
