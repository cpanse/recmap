\name{recmap2sp}
\alias{recmap2sp}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Exports SpatialPolygonsDataFrame object
}
\description{
The method generates a SpatialPolygons object out of a as input given
recmap object.
}
\usage{
recmap2sp(rm, df = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rm}{
a \code{\link{recmap}} object.
}
  \item{df}{
a \code{data.frame} object. default is NULL.
}
}

\value{
returns a \code{\link[sp]{SpatialPolygonsDataFrame}}
}
\references{
Roger S. Bivand, Edzer Pebesma, Virgilio Gomez-Rubio, 2013. 
Applied spatial data analysis with R, Second edition. Springer, NY. 
\url{http://www.asdar-book.org/}
}
\author{
  Christian Panse
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\itemize{
\item{\code{\link[sp]{sp}}}
}
}
\examples{
  spplot(recmap2sp(recmap(checkerboard(8))))
}
