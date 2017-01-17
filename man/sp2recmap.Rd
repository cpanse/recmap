\name{sp2recmap}
\alias{sp2recmap}

\title{
    Export SpatialPolygonsDataFrame Object to recmap Object
}

\description{
    The method generates a recmap class out of a \code{\link{SpatialPolygonsDataFrame}} object.
}
\usage{
sp2recmap(X)
}

\arguments{
  \item{X}{ a \code{\link{SpatialPolygonsDataFrame}} object.  }
}

\value{ returns a \code{\link{recmap}} object.}

\references{
Roger S. Bivand, Edzer Pebesma, Virgilio Gomez-Rubio, 2013. 
Applied spatial data analysis with R, Second edition. Springer, NY. 
\url{http://www.asdar-book.org/}
}

\author{
  Christian Panse
}

\seealso{
\itemize{
\item{\code{\link[sp]{sp}}}
}
}

\examples{
  SpDf <- recmap2sp(recmap(checkerboard(8)))
  summary(SpDf)
  spplot(SpDf)

  summary(sp2recmap(SpDf))
}
