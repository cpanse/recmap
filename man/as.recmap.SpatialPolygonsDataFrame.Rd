\name{as.recmap.SpatialPolygonsDataFrame}
\alias{as.recmap.SpatialPolygonsDataFrame}
\alias{as.recmap}
\alias{sp2recmap}

\title{
    Convert a SpatialPolygonsDataFrame Object to recmap Object
}

\description{
    The method generates a recmap class out of a \code{\link{SpatialPolygonsDataFrame}} object.
}
\usage{
	\method{as.recmap}{SpatialPolygonsDataFrame}(X)
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
		\item{\code{\link{as.SpatialPolygonsDataFrame}}}
	}
}

\examples{

  SpDf <- as.SpatialPolygonsDataFrame(recmap(checkerboard(8)))

  summary(SpDf)
  spplot(SpDf)

  summary(as.recmap(SpDf))



  # taken from https://github.com/sjewo/cartogram
	
	\dontrun{
     if (requireNamespace("maptools", quietly = TRUE)) {
	library(maptools)
        data(wrld_simpl)

	afr <- as.recmap(wrld_simpl[wrld_simpl$REGION==2, ])
	is.recmap(afr)

	afr$z <- afr$POP2005 

	is.recmap(afr)
	afr <- afr[afr$z > 0, ]

	# make map overlap to generate a connected pseudo dual
	afr$dx <- 2.0 * afr$dx
	afr$dy <- 2.0 * afr$dy


	# overview
	plot(recmap(afr))

	# use the GA
	set.seed(1)
	plot(recmapGA(afr))

     }
	}
}
