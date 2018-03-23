\name{jss2711}
\alias{js2711}
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
jss2711 contains the recmap input for the Figures 4, 6, 11, 12, 13.
}
\usage{data("jss7211")}
\format{
  A nested list of data frames.
}
\details{
\itemize{
\item{SBB}
\item{Swizterland Gemeinde - }
}
}
\source{
\itemize{
\item{Figure 11 -- \code{Switzerland}:
map data source:
Swiss Federal Office of Topography using Landscape Models / Boundaries GG25,
downloaded 2016-05-01; statistical data: Bundesamt für Statistik (BFS),
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


\references{
\url{https://arxiv.org/abs/1606.00464}
}

\examples{
data(package = "recmap")
data(jss2711)

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


## Figure 6
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

# sanity check - reproducibility 

op <- par(mfrow=c(2,2)); 

lapply(c(1,3,5), function(x){
  plot(c(res[[x]]$Cartogram$x, res[[x]]$Cartogram$y), 
    c(res[[x+1]]$Cartogram$x, res[[x+1]]$Cartogram$y),
    sub = "reproducibility on the same plattform",
    main = paste("all.equal =", all.equal(res[[x]]$Cartogram, res[[x+1]]$Cartogram))); 
  abline(a=0,b=1, col='grey')
  })


## Figure 11
\dontrun{plot(recmap(Switzerland$map[Switzerland$solution,]))}
C <- Switzerland$cartogram
class(C) <- c('recmap', 'data.frame')
plot(C)
idx <- rev(order(C$z))[1:50];
text(C$x[idx], C$y[idx], iconv(as.character(C$name[idx]),
  "latin1", "UTF-8"), col='red',
  cex = C$dx[idx]/strwidth(as.character(C$name[idx])))


## Figure 12
op <- par(mfrow = c(2, 1), mar = c(0, 0, 0, 0))
SBB.Map <- SBB$Map

# make input map overlapping
S <- SBB$Map
S <- S[!is.na(S$x),]
S$dx <- 0.1; S$dy <- 0.1; S$z <- S$DTV
S$name <- S$Bahnhof_Haltestelle
plot.recmap(S)
idx <- rev(order(S$z))[1:10]
text(S$x[idx], S$y[idx], S$name[idx], col='red', cex=0.7)
idx <- rev(order(S$z))[11:30]
text(S$x[idx], S$y[idx], S$name[idx], col = 'red', cex = 0.5)

Cartogram.recomp <- recmap(S[sol <- SBB$GA@solution[1, ], ])
plot(Cartogram.recomp)

# sanity check - reproducibility cross plattform

all.equal(Cartogram.recomp$x, SBB$Cartogram$x)
all.equal(Cartogram.recomp$y, SBB$Cartogram$y)


op <- par(mfrow=c(2, 2), mar=c(4,4,4,4))
plot(Cartogram.recomp$x, SBB$Cartogram$x); abline(a=0,b=1, col='grey')
plot(Cartogram.recomp$y, SBB$Cartogram$y); abline(a=0,b=1, col='grey')
plot(Cartogram.recomp$dx, SBB$Cartogram$dx)
plot(Cartogram.recomp$dy, SBB$Cartogram$dy)


idx<-rev(order(Cartogram.SBB$z))[1:40]
text(Cartogram.SBB$x[idx],Cartogram.SBB$y[idx],
        Cartogram.SBB$name[idx],
        col = 'red',
        cex = 1.25 * Cartogram.SBB$dx[idx] / strwidth(Cartogram.SBB$name[idx]))



## Figure 13

plot(recmap(UK$Map))

}
\keyword{datasets}
