\name{plot.recmap}

\title{Prints recmap object.}
\alias{plot}
\alias{plot.recmap}

\description{
  plots input and output of the \code{\link{recmap}} function.
  The function requires column names (x, y, dx, dy).
}

\usage{\method{plot}{recmap}(x, col='#00000011', col.text = 'grey', ...)}

%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
  \code{recmap} object - can be input or output of \code{recmap}.
}
  \item{col}{
  a vector of colors.
}
  \item{col.text}{
  a vector of colors.
}
  \item{\dots}{
whatsoever
}

}

\value{
  graphical output
}

\author{
  Christian Panse
}


\seealso{

  \code{\link{recmap}} or \code{vignette("recmap")}

}
\examples{

  Cartogram <- recmap(Map <- checkerboard(2))

  plot(Map)
  plot(Cartogram)

}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.

\keyword{plot}

