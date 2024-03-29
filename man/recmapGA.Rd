% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/recmap.R
\name{recmapGA}
\alias{recmapGA}
\title{Genetic Algorithm Wrapper Function for recmap}
\usage{
recmapGA(
  V,
  fitness = .recmap.fitness,
  pmutation = 0.25,
  popSize = 10 * nrow(Map),
  maxiter = 10,
  run = maxiter,
  monitor = if (interactive()) {
     gaMonitor
 } else FALSE,
  parallel = FALSE,
  ...
)
}
\arguments{
\item{V}{defines the input map regions formatted as \code{\link{data.frame}}
having the column names \code{c('x', 'y', 'dx', 'dy', 'z', 'name')} 
as described above. V could also be considered as the nodes of the pseudo dual.}

\item{fitness}{the fitness function, any allowable R function which takes as input an individual \code{string} representing a potential solution, and returns a numerical value describing its ``fitness''.}

\item{pmutation}{the probability of mutation in a parent chromosome. Usually mutation occurs with a small probability, and by default is set to 0.1.}

\item{popSize}{the population size.}

\item{maxiter}{the maximum number of iterations to run before the GA search is halted.}

\item{run}{the number of consecutive generations without any improvement in the best fitness value before the GA is stopped.}

\item{monitor}{a logical or an R function which takes as input the current state of the \code{ga-class} object and show the evolution of the search. By default, for interactive sessions the function \code{\link[GA]{gaMonitor}} prints the average and best fitness values at each iteration. If set to \code{plot} these information are plotted on a graphical device. Other functions can be written by the user and supplied as argument. In non interactive sessions, by default \code{monitor = FALSE} so any output is suppressed.}

\item{parallel}{
An optional argument which allows to specify if the Genetic Algorithm should be run sequentially or in parallel. 

For a single machine with multiple cores, possible values are: 
\itemize{
  \item a logical value specifying if parallel computing should be used (\code{TRUE}) or not (\code{FALSE}, default) for evaluating the fitness function;
  \item a numerical value which gives the number of cores to employ. By default, this is obtained from the function \code{\link[parallel]{detectCores}}; 
  \item a character string specifying the type of parallelisation to use. This depends on system OS: on Windows OS only \code{"snow"} type functionality is available, while on Unix/Linux/Mac OSX both \code{"snow"} and \code{"multicore"} (default) functionalities are available.
}
In all the cases described above, at the end of the search the cluster is automatically stopped by shutting down the workers.

If a cluster of multiple machines is available, evaluation of the fitness function can be executed in parallel using all, or a subset of, the cores available to the machines belonging to the cluster. However, this option requires more work from the user, who needs to set up and register a parallel back end. 
In this case the cluster must be explicitly stopped with \code{\link[parallel]{stopCluster}}.
}

\item{...}{additional arguments to be passed to the fitness function. This allows to write fitness functions that keep some variables fixed during the search.}
}
\value{
returns a list of the input \code{Map}, the solution of the \code{\link[GA]{ga}} 
function, and a \code{\link{recmap}} object containing the cartogram.
}
\description{
higher-level function for \code{\link{recmap}} using a Genetic Algorithm as
metaheuristic.
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

## https://github.com/luca-scr/GA/issues/52
if (Sys.info()['machine'] == "arm64") GA::gaControl(useRcpp = FALSE)
res <- recmapGA(V = checkerboard(4), pmutation = 0.25)

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
res <- recmapGA(V = getUS_map(), maxiter = 5)
op <- par(ask = TRUE)
plot(res)
par(op)
summary(res)
}
}
\references{
Luca Scrucca (2013). GA: A Package for Genetic Algorithms in R.
Journal of Statistical Software, 53(4), 1-37.
\doi{10.18637/jss.v053.i04}.
}
