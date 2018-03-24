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
jss2711 contains the recmap input for the Figures 4, 6, 7, 11, 12, 13.
}
\format{
  A set of nested list of data frames.
}

\source{
\itemize{
\item{Figure 11 -- \code{Switzerland}:
map data source:
Swiss Federal Office of Topography using Landscape Models / Boundaries GG25,
downloaded 2016-05-01; statistical data: Bundesamt fur Statistik (BFS),
Website Statistik Schweiz, downloaded file \code{je-d-21.03.01.xls} on 2016-05-26.}
\item{Figure 12 -- \code{sbb}:
\url{sbb.ch} 2016-05-12}
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
data(package = "recmap")
data(jss2711)
options(warn = -1)

## Figure 4 - left
op <- par(mar=c(4, 4, 2, 2), mfrow = c(1, 2))

boxplot(number ~ size, data = mbb_check,
    subset = algorithm == "linear",
    xlab = 'number of map regions',
    ylab = 'number of MBB intersection calls',
    col = "red", log='y')

boxplot(number ~ size, data = mbb_check, 
        subset = algorithm == "multiset",
        xlab = 'number of map regions',
        ylab = 'number of MBB intersection calls',
        log='y');

legend("bottomright", c("recmap > 0.2.1", "recmap <= 0.2.1"),
        col=c('black', 'red'), pch = 22, cex = 1.5)



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

# text(C$x[idx], C$y[idx], iconv(as.character(C$name[idx]),
#   "latin1", "UTF-8"), col='red',
#   cex = C$dx[idx]/strwidth(as.character(C$name[idx])))


## Figure 12
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
op <- par(mfrow=c(2,2), mar=c(5,5,5,5))
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
