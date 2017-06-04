\name{as.SpatialPolygonsDataFrame.recmap}
\alias{as.SpatialPolygonsDataFrame.recmap}
\alias{as.SpatialPolygonsDataFrame}
\alias{recmap2sp}

\title{
    Convert a recmap Object to SpatialPolygonsDataFrame Object
}

\description{
    The method generates a SpatialPolygons object of a as input given
    \code{\link{recmap}} object. Both \code{data.frame}s are merged by the index order.
}

\usage{
	\method{as.SpatialPolygonsDataFrame}{recmap}(x, df = NULL, \dots)
}

\arguments{
  \item{x}{ a \code{\link{recmap}} object.  }
  \item{df}{ a \code{data.frame} object. default is NULL.  }
  \item{\dots}{ ... }
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

\note{This S3method has replaced the \code{recmap2sp} function since package version 0.5.22.}

\examples{
  SpDf <- as.SpatialPolygonsDataFrame(recmap(checkerboard(8)))
  summary(SpDf)
  spplot(SpDf)
}
