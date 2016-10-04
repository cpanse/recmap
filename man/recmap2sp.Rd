\name{recmap2sp}
\alias{recmap2sp}

\title{
    Export recmap Object to SpatialPolygonsDataFrame Object
}

\description{
    The method generates a SpatialPolygons object out of the a as input given
    recmap object. Both tables are mergerd by the index order.
}
\usage{
recmap2sp(rm, df = NULL)
}

\arguments{
  \item{rm}{ a \code{\link{recmap}} object.  }
  \item{df}{ a \code{data.frame} object. default is NULL.  }
}

\value{ returns a \code{\link[sp]{SpatialPolygonsDataFrame}} }

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
  SpDf<- recmap2sp(recmap(checkerboard(8)))
  summary(SpDf)
  spplot(SpDf)
}
