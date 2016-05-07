\name{recmap}
\alias{recmap}
\alias{RecMap}
\alias{cartogram}

\title{
Rectangular Map Approximations 
}

\description{
The input consist of a map represented by overlapping rectangles. Furthermore the algorithm reqires as input for each map region:

- a tuple of (x, y) values corresponding to the (longitude, latitude) position

- a tuple of (dx, dy) of expansion along (longitude, latitude)

- and a statistical value z.

The (x, y) coordinates represents the center of the minimal bounding boxes (MBB), The coordinates of the MBB are derived by adding or substracting the (dx, dy) tuple accordingly. The tuple (dx, dy) defines also the ratio of the map region. The statistical values define the desired area of each map region.

The output is a rectangular cartogram where the map regions are:

- non overlapping,
- connected,
- ratio and area of each rectangle corresponds to the desired areas.
- rectangles are placed parallel to the axes

The construction heuristic places the rectangles in a way that important spatial constraints, in particular

- the topology of the pseudo dual graph,

- the relative position of MBB centers.

are tried to be preserved.

The ratios are preserved and the area of each region corresponds to the as input given statistical value z.
}

\usage{
recmap(df)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{df}{a \code{data.frame} having the columns (x, y, dx, dy, z, name) described above.}
}

\details{

Time Complexity:
The time complexity is O(n^2), where n is the number of regions.
DFS is visiting each map region only once and therefore has 
time complexity O(n). For each placement a constant number of
mbb intersection are called (max 360). mbb check is implemented using
\code{std::set}, \code{insert}, \code{upper_bound}, \code{upper_bound} 
costs are O(log(n)). 
However, worst case for a range query is O(n), iff dx or dy cover the whole
x or y range.
Q.E.D.

In praxis on a 2.4 GHz Intel Core i7 computing the ~50 state U.S. map the computation is less than a second. 

}

\value{

  returns a \code{data.frame} object.

}

\references{

Roland Heilmann, Daniel Keim, Christian Panse, and Mike Sips (2004). RecMap: Rectangular Map
Approximations. InfoVis 2004, IEEE Symposium on Information Visualization, Austin, Texas, 33-40.
\url{http://dx.doi.org/10.1109/INFVIS.2004.57}

}

\author{

  Christian Panse 2016

}

\seealso{

  The package vignette \url{https://cran.r-project.org/web/packages/recmap/vignettes/recmap.html} or 
  by calling \code{vignette("recmap")} on the R command prompt.

}

\examples{

Cartogram <- recmap(Map <- recmap:::.checker_board(2))

plot_recmap(Cartogram)

## Have Fun!

}

\keyword{cartogram}
\keyword{value-by-area-map}
