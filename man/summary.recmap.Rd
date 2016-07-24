\name{summary.recmap}

\title{Summary for recmap}
\alias{summary}
\alias{summary.recmap}



\description{

Summary method for S3 class \code{\link{recmap}}.
The area error is computed as described in the CartoDraw paper.

}
\usage{\method{summary}{recmap}(object, ...)}

%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
S3 class \code{recmap}.
}
 \item{...}{
whatsoever.
}
}

\value{
returns a \code{data.frame} containing summary information, e.g.,  
objective functions or number of map regions.
}

\author{
Christian Panse
}

\references{
D. A. Keim, S. C. North, and C. Panse, 
"CartoDraw: A Fast Algorithm for Generating Contiguous Cartograms,"
IEEE Trans. Vis. Comput. Graph., vol. 10, no. 1, pp. 95-110, 2004.
\doi{10.1109/TVCG.2004.1260761}.
}

\examples{

summary(checkerboard(4))
summary(recmap(checkerboard(4)))

}
\keyword{ summary }% __ONLY ONE__ keyword per line
