\name{recmapGA}
\alias{recmapGA}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Genetic Algorithm Wrapper Function for recmap
}
\description{
high-level function for \code{\link{recmap}} using a Genetic Algorithm as 
metaheuristic.
}
\usage{
recmapGA(Map, 
  fitness = .recmap.fitness, 
  pmutation = 0.25, 
  popSize = 10 * nrow(Map), 
  maxiter = 10, 
  run = maxiter, 
  monitor = if (interactive()) { gaMonitor2} else FALSE, 
  parallel = FALSE, 
  \dots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
The following arguments are passed through \code{\link[GA]{ga}}.
  \item{Map}{defines the input map regions formatted as \code{\link{data.frame}}
  having the column names \code{c('x', 'y', 'dx', 'dy', 'z', 'name')} 
  as described above.
}
  \item{fitness}{
a fitness function \code{function(idxOrder, Map, ...)} returning a number 
which as to be maximized.
}

  \item{pmutation}{
see docu of \code{\link[GA]{ga}}.
}
  \item{popSize}{
    see docu of \code{\link[GA]{ga}}.}
  \item{maxiter}{
see docu of \code{\link[GA]{ga}}.
}
  \item{run}{
see docu of \code{\link[GA]{ga}}.
}
\item{monitor}{
see docu of \code{\link[GA]{ga}}.
}
  \item{parallel}{
see docu of \code{\link[GA]{ga}}.
}
  \item{\dots}{
passed through the \code{\link{ga}} method.
}
}

\value{
returns a list of the input \code{Map}, the solution of the \code{\link[GA]{ga}} 
function, and a \code{\link{recmap}} object containing the cartogram. 
}
\references{
Luca Scrucca (2013). GA: A Package for Genetic Algorithms in R.
Journal of Statistical Software, 53(4), 1-37. 
\url{http://dx.doi.org/10.18637/jss.v053.i04}. 
}
\author{
Christian Panse
}


\seealso{
\itemize{
\item \code{\link{recmap}} - Compute a Rectangular Statistical Cartogram
\item \code{\link[GA]{ga}} - Genetic Algorithms
}
}
\examples{

## The default fitnes function is currently defined as
function(idxOrder, Map, ...){

  Cartogram <- recmap(Map[idxOrder, ])
  # a map region could not be placed; 
  # accept only feasible solutions!
  
  if (sum(Cartogram$topology.error == 100) > 0){return (0)}
  
  1 / sum(Cartogram$relpos.error)
}


## use Genetic Algorithms (GA >=3.0.0) as metaheuristic
set.seed(1)
res <- recmapGA(Map = checkerboard(4), pmutation = 0.25)

op <- par(mfrow = c(1, 3))
plot(res$Map, main = "Input Map") 
plot(res$GA, main="Genetic Algorithm")
plot(res$Cartogram, main = "Output Cartogram")


## US example
getUS_map <- function(){
  usa <- data.frame(x = state.center$x, 
  y = state.center$y, 
  # make the rectangles overlapping by correcting 
  # lines of longitude distance.
  dx = sqrt(state.area) / 2 
    / (0.8 * 60 * cos(state.center$y * pi / 180)), 
  dy = sqrt(state.area) / 2 / (0.8 * 60), 
  z = sqrt(state.area),
  name = state.name)
      
  usa$z <- state.x77[, 'Population']
  US.Map <- usa[match(usa$name, 
    c('Hawaii', 'Alaska'), nomatch = 0)  == 0, ]

  class(US.Map) <- c('recmap', 'data.frame')
  US.Map
}

\dontrun{
# takes 34.268 seconds on CRAN
res <- recmapGA(getUS_map(), maxiter = 5)
op <- par(ask = TRUE)
plot(res)
par(op)
summary(res)
}
}

