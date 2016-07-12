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
recmapGA(Map, fitness = .recmap.fitness, pmutation = 0.25, 
popSize = 10 * nrow(Map), maxiter = 10, run = maxiter, 
monitor = if (interactive()) { gaMonitor2} else FALSE, parallel =
                 FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
The following arguments are passed through \code{\link[GA]{ga}}.
  \item{Map}{

}
  \item{fitness}{
%%     ~~Describe \code{fitness} here~~
}

  \item{pmutation}{
%%     ~~Describe \code{pmutation} here~~
}
  \item{popSize}{
%%     ~~Describe \code{popSize} here~~
}
  \item{maxiter}{
%%     ~~Describe \code{maxiter} here~~
}
  \item{run}{
%%     ~~Describe \code{run} here~~
}
\item{monitor}{
%%     ~~Describe \code{pmutation} here~~
}
  \item{parallel}{
%%     ~~Describe \code{parallel} here~~
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

}

