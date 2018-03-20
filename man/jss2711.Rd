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


## Figure 11
\dontrun{plot(recmap(Switzerland$map[Switzerland$solution,]))}
plot(Switzerland$cartogram)

## Figure 12
op <- par(mfrow = c(2, 1), mar = c(0, 0, 0, 0))
SBB.Map <- SBB$Map
S <- SBB$Map
S <- S[!is.na(S$x),]
S$dx <- 0.1; S$dy <- 0.1; S$z <- S$DTV
S$name <- S$Bahnhof_Haltestelle
plot.recmap(S)
idx <- rev(order(S$z))[1:10]
text(S$x[idx], S$y[idx], S$name[idx], col='red', cex=0.7)
idx <- rev(order(S$z))[11:30]
text(S$x[idx], S$y[idx], S$name[idx], col = 'red', cex = 0.5)

Cartogram.SBB <- recmap(S[sol <- SBB$GA@solution[1, ], ])
plot(Cartogram.SBB)

idx<-rev(order(Cartogram.SBB$z))[1:40]
text(Cartogram.SBB$x[idx],Cartogram.SBB$y[idx],
        Cartogram.SBB$name[idx],
        col = 'red',
        cex = 1.25 * Cartogram.SBB$dx[idx] / strwidth(Cartogram.SBB$name[idx]))



## Figure 13

plot(recmap(UK$Map))

}
\keyword{datasets}
