\name{plot.recmap}

\title{Prints a recmap object.}
\alias{plot}
\alias{plot.recmap}
\alias{plot.recmapGA}
\alias{plot.recmapGRASP}
\description{
  plots input and output of the \code{\link{recmap}} function.
  The function requires column names (x, y, dx, dy).
}

\usage{\method{plot}{recmap}(x, col='#00000011', col.text = 'grey', border = 'darkgreen', ...)}

%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
  \code{recmap} object - can be input or output of \code{recmap}.
}
  \item{col}{
  a vector of colors.
}
\item{border}{
  this parameter is passed to the rect function.
  color for rectangle border(s). The default means par("fg"). 
  Use border = NA to omit borders. If there are shading lines, border = TRUE 
  means use the same colour for the border as for the shading lines.
  default is 'darkgreen'.
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

