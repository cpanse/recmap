\name{plot_recmap}
\alias{plot_recmap}

\title{
The graphical representation of recmap
}
\description{
plots the rectangular map regions.
}
\usage{
plot_recmap(S, col='#00000011', col.text = 'grey', ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{S}{
a \code{data.frame} can be input or output of \code{recmap}.
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
\code{?recmap} or \code{vignette("recmap")}
}
\examples{
Cartogram <- recmap(Map <- recmap:::.checker_board(2))

plot_recmap(Map)
plot_recmap(Cartogram)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{cartogram}% use one of  RShowDoc("KEYWORDS")
\keyword{recmap}% __ONLY ONE__ keyword per line
