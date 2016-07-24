\name{recmap}
\alias{recmap}
\alias{RecMap}
\alias{cartogram}

\title{

Compute a Rectangular Statistical Cartogram

}

\description{

The input consists of a map represented by overlapping rectangles.
The algorithm requires as input for each map region:

\itemize{
  \item{a tuple of (x, y) values corresponding to the 
  (longitude, latitude) position,}

  \item{a tuple of (dx, dy) of expansion along (longitude, latitude),}

  \item{and a statistical value z.}
}

The (x, y) coordinates represent the center of the minimal bounding boxes 
(MBB), The coordinates of the MBB are derived by adding or subtracting the 
(dx, dy)/2 tuple accordingly. The tuple (dx, dy) defines also the ratio of the 
map region. The statistical values define the desired area of each map region.

The output is a rectangular cartogram where the map regions are:

\itemize{

  \item{non overlapping,}

  \item{connected,}

  \item{ratio and area of each rectangle corresponds to the desired areas,}

  \item{rectangles are placed parallel to the axes.}
}

The construction heuristic places each rectangle in a way that important spatial 
constraints, in particular

\itemize{

  \item{the topology of the pseudo dual graph,}

  \item{the relative position of MBB centers.}

}

are tried to be preserved.

The ratios are preserved and the area of each region corresponds to the as 
input given statistical value z.

}

\usage{
recmap(df)
}

\arguments{

  \item{df}{is the input formatted as \code{\link{data.frame}} having the
  columns (x, y, dx, dy, z, name) as described above.}

}

\details{

Basic idea of the current recmap \emph{implementation}:

\enumerate{

  \item{Compute the pseudo dual out of the overlapping map regions.}

  \item{Determine the \emph{core region} by \code{index <- int(n / 2)}.}

  \item{Place region by region along DFS skeleton of pseudo dual starting 
  with the \emph{core region}.}

}

Note: if a rectangle can not be placed, accept a non \emph{feasible solution}
(avoid solutions having a topology error higher than 100)
Solving this constellation can be compute expensive and due to the assumably 
bad fitness value the candidate cartogram  will be anyway 
rejected by the metaheuristic.

\emph{Time Complexity:}
The time complexity is \eqn{O(n^2)}, where n is the number of regions.
DFS is visiting each map region only once and therefore has 
time complexity \eqn{O(n)}. For each placement a constant number of
MBB intersection are called (max 360). MBB check is implemented using
\code{std::set}, \code{insert}, \code{upper_bound}, \code{upper_bound} 
costs are \eqn{O(log(n))}. 
However, worst case for a range query is \eqn{O(n)}, iff dx or dy cover the 
whole x or y range. Q.E.D.


\emph{Perfomance:}

In praxis, computing on a 2.4 GHz Intel Core i7 machine (using only one core), using the 
50 state U.S. map example, recmap can compute approximately 100 cartograms in one second.
The number of MBB calls were
(Min., Median, Mean, Max)  = (1448, 2534, 3174, 17740), using in each run
a different index order using the (\code{\link{sample}}) method.

\emph{Geodetic datum:} the \code{recmap} algorithm is not transforming the 
geodetic datum, e.g., WGS84 or Swissgrid.

}

\value{

returns a \code{recmap} S3 object of the transformed map with new coordinates 
(x, y, dx, dy) plus additional columns containing information for topology 
error, relative position error, and the DFS number.
The error values are thought to be used for fitness function of the
metaheuristic.

}

\references{
\itemize{

\item Roland Heilmann, Daniel Keim, Christian Panse, and Mike Sips (2004). 
"RecMap: Rectangular Map Approximations."
InfoVis 2004, IEEE Symposium on Information Visualization, Austin, Texas, 33-40.
\url{http://dx.doi.org/10.1109/INFVIS.2004.57}.

\item Christian Panse (2016). 
"Rectangular Statistical Cartograms in R: The recmap Package."
\url{https://arxiv.org/abs/1606.00464}.
}
}

\author{

  Christian Panse, 2016

}

\seealso{

\itemize{
  \item S3 class methods: \code{\link{plot.recmap}} and
  \code{\link{summary.recmap}}.

  \item the metaheuristic glue methods:
  \code{\link{recmapGA}} and \code{\link{recmapGRASP}}.

  \item The package vignette 
  \url{https://cran.r-project.org/web/packages/recmap/vignettes/recmap.html} 
  or by calling \code{vignette("recmap")} on the R command prompt.
  
  \item A shiny web application \url{https://recmap.shinyapps.io/state_x77/}.
  }
}

\examples{
map <- checkerboard(2)
cartogram <- recmap(map)

map
cartogram

op <- par(mfrow = c(1, 2))
plot(map)
plot(cartogram)

## US example
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

plot.recmap(US.Map)
plot(recmap(US.Map))
par(op)

# define a fitness function
recmap.fitness <- function(idxOrder, Map, ...){
  Cartogram <- recmap(Map[idxOrder, ])
  # a map region could not be placed; 
  # accept only feasible solutions!
  if (sum(Cartogram$topology.error == 100) > 0){return (0)}
  1 / sum(Cartogram$z / (sqrt(sum(Cartogram$z^2))) 
    * Cartogram$relpos.error)
}


\dontrun{

## use Genetic Algorithms (GA >=3.0.0) as metaheuristic

# install.packages(c('doParallel', 'GA'))

library(GA)
library(parallel)
library(doParallel)

M <- US.Map

recmapGA <- ga(type = "permutation", 
  fitness = recmap.fitness, 
  Map = M,
  monitor = gaMonitor,
  min = 1, max = nrow(M) , 
  popSize = 4 * nrow(M), 
  maxiter = 10,
  run = 100, 
  parallel=TRUE,
  pmutation = 0.25)

plot(recmap(M[recmapGA@solution[1,],]))

plot(recmapGA)

}


\dontrun{
# install.packages('rbenchmark')

library(rbenchmark)
benchmark(recmap(US.Map[sample(50,50),]), replications=100)
##                              test replications elapsed relative user.self
##1 recmap(US.Map[sample(50, 50), ])          100   1.255        1     1.124
##  sys.self user.child sys.child
##1    0.038          0         0
}

## Have Fun!
}

\keyword{package}
\keyword{cartogram}
\keyword{value-by-area-map}
