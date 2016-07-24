\name{recmapGRASP}
\alias{recmapGRASP}

\title{
Greedy Randomized Adaptive Search Procedure Wrapper Function for recmap
}
\description{
Implements a metaheuristic for \code{\link{recmap}} based on GRASP.
}
\usage{
recmapGRASP(Map, fitness = .recmap.fitness, n.samples = nrow(Map) * 2, 
  fitness.cutoff = 1.7, iteration.max = 10)
}

\arguments{
  \item{Map}{
is the input formatted as \code{\link{data.frame}} having the
  columns (x, y, dx, dy, z, name)
}
  \item{fitness}{
a fitness \code{function(idxOrder, Map, ...)} which as to be maximized.
}

  \item{n.samples}{
number of samples.
}
  \item{fitness.cutoff}{
cut-off value.
}
  \item{iteration.max}{
maximal number of iteration.
}
}

\value{
returns a list of the input \code{Map}, the best solution of GRASP,
and a \code{\link{recmap}} object containing the cartogram. 
}

\references{
Feo TA, Resende MGC (1995). 
"Greedy Randomized Adaptive Search Procedures."
Journal of Global Optimization, 6(2), 109-133. ISSN 1573-2916. 
\doi{10.1007/BF01096763}.
}
\author{
Christian Panse
}

\seealso{
 \code{\link{recmapGA}} and \code{\link{recmap}}
}

\examples{

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
res <- recmapGRASP(getUS_map())
plot(res$Map, main = "Input Map") 
plot(res$Cartogram, main = "Output Cartogram")
}

}

