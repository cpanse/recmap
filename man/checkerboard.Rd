\name{checkerboard}
\alias{checkerboard}

\title{
Create a Checkboard
}
\description{

This function generates a \code{\link{recmap}} object.
}
\usage{
checkerboard(n = 8, ratio = 4)
}

\arguments{
  \item{n}{defines the size of the map. default is 8 which will generate a map 
  having 64 regions.}
  
  \item{ratio}{defines the ratio of the statistical value. As default, the 
  black regions have a value which is four times higher.}
}

\value{
returns a checkerboard as \code{\link{recmap}} object.
}

\author{
Christian Panse
}

\seealso{

\itemize{
  \item \code{\link{recmap}}.
}
}

\examples{

checkerboard8x8 <- checkerboard(8)

plot(checkerboard8x8, 
  col=c('white','white','white','black')[checkerboard8x8$z])

}

