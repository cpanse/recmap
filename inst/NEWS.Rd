\name{NEWS}
\title{News for Package 'recmap'}

\newcommand{\ghit}{\href{https://github.com/cpanse/recmap/issues/#1}{##1}}

\section{Changes until version 1.0.17 (2023-09-16)}{
  \itemize{
    \item Use RoxygenNote for man page and Rcpp wrapper \ghit{21}.
  }
}

\section{Changes until version 1.0.12 (2021-11-20)}{
  \itemize{
    \item GA Rcpp issue on apply M1; replace skip_on_os with \code{GA::gaControl("useRcpp" = FALSE)} \href{https://github.com/luca-scr/GA/issues/52}{#52}
  }
}

\section{Changes until version 1.0.10 (2021-09-20)}{
  \itemize{
    \item url fix in man page urls
    \item skip recmapGA test case on mac os \href{https://github.com/luca-scr/GA/issues/52}{#52}
  }
}

\section{Changes until version 1.0.9 (2021-05-07)}{
  \itemize{
    \item Moving towards defining STRICT_R_HEADERS in Rcpp.h \url{https://github.com/RcppCore/Rcpp/issues/1158} \url{https://github.com/cpanse/recmap/commit/5ae6aade93026b96238804e06593fa9088dda763}
    \item url fix in man page urls
  }
}

\section{Changes until version 1.0.8 (2020-02-20)}{
  \itemize{
    \item remove shiny colorspace and xtable package in suggest
    \item R (>=3.6)  and hard coded colormaps or
      use `grDevices::hcl.colors()` \ghit{19}
	  \item added construction animated gif
	  \url{https://user-images.githubusercontent.com/4901987/64121133-3dfc9100-cd9e-11e9-8c35-078678966100.gif} to README.md.
  }
}
\section{Changes until version 1.0.5 (2019-06-03)}{
  \itemize{
	  \item fix recmapGRASP testcase \ghit{14}.
	  \item text cosmetics \ghit{14}.
	  \item fixed \ghit{15}.
	  \item fixed \ghit{16}.
	  \item fixed \ghit{17}.
	  \item added DOI in Description.
  }
}

\section{Changes until version 1.0.0 (2018-09-16)}{
  \itemize{
	  \item incorporate CITATION file to refer back to 
	  the JSS manuscript \doi{10.18637/jss.v086.c01}.
  }
}

\section{Changes until version 0.5.35 (2018-06-01)}{
  \itemize{
	  \item \ghit{11}.
	  \item replaced items in data/jss2711.RData.
  }
}

\section{Changes until version 0.5.33 (2018-05-01)}{
  \itemize{
	  \item mv src/recmap.h inst/include/recmap
	  \item man page cosmetics 
  }
}

\section{Changes until version 0.5.32 (2018-03-24)}{
  \itemize{
	  \item added test-jss2711(renamed test-recmapGA.R) checking Figure 7, 11, 12 ,13.
  }
}

\section{Changes until version 0.5.31 (2018-03-23)}{
  \itemize{
	  \item added jss2711 submission as vignette file.
	  \item added jss2711 data.
	  \item replace gaMonitor2 by gaMonitor (GA3.1).
	  \item added test-recmapGA.R for reproducibility.
  }
}

\section{Changes until version 0.5.24 (2017-09-16)}{
  \itemize{
	  \item spell check cosmetics.
	  \item added a progress window in the shiny apps.
	  \item added \code{is.recmap} function.
	  \item replaced \code{recmap2sp} and \code{sp2recmap} functions by S3methods \code{as.SpatialPolygonsDataFrame} and \code{as.recmap}.
  }
}

\section{Changes until version 0.5.20 (2017-04-10)}{
  \itemize{
   \item added argument for the definition of the pseudo dual graph in \code{recmap}.
   \item fixed register native routine issue by using \code{tools::package_native_routine_registration_skeleton(".")}
   \item added shiny example including
   \href{https://shiny.rstudio.com/reference/shiny/1.4.0/hoverOpts.html}{hoverOpts}
   using \code{state.x77} data executable through
   \code{recmap_state.x77 <- system.file("shiny-examples", "state.x77", package = "recmap")}
   and 
   \code{recmap_US.county <- system.file("shiny-examples", "US.county", package = "recmap")}
  }
}
\section{Changes until version 0.5.16 (2017-01-15)}{
improvements concerning \href{https://www.jstatsoft.org}{JSS} reviewer comments:
  \itemize{
  
  \item added a \code{sp2recmap} method including a testthat method.
  \item added 'meta' plot methods \code{plot.recmapGA} and 
  \code{plot.recmapGRAP}.

    \item added a \code{border} attribute to the \code{plot.recmap} method.
    \item \code{plot.recmap} labels are now scaled by using \code{S$dx / strwidth(S$name)}.
  }
  }
  
\section{Changes until version 0.5.5 (2016-12-13)}{
  \itemize{
  	\item added a screen-filling parameter in \code{summary.recmap} function.
	  \item man page cosmetics.
	  \item bugfix in \code{summary.recmap} function for MBB computation.
  }
}

\section{Changes version 0.5.4 (2016-07-24)}{
  improvements concerning \href{https://www.jstatsoft.org}{JSS} editorial comments
  prescreening stage:
  \itemize{
  \item added dependencies from \href{https://cran.r-project.org/package=GA}{GA}
  and \href{https://cran.r-project.org/package=sp}{sp} 
  \item added S3 methods \code{plot.recmap()} and  \code{recmap.summary}.
  \item added \code{recmapGA} to glue \code{ga} and \code{recmap} functions.
  \item added \code{recmapGRASP} method.
  \item exported \code{checkerboard()} function.
  \item added method \code{recmap2sp} to export a 
  \href{https://cran.r-project.org/package=sp}{sp} object.
  }
}

\section{Changes version 0.5.0 (2016-07-01)}{
  \itemize{
    \item add docker Public | Automated Build
    \url{https://hub.docker.com/r/cpanse/recmap/}.
    \item manual and vignette cosmetics.
    \item added \code{zzz.R}.
  }
}

\section{Changes version 0.4.0 (2016-06-12)}{

  \itemize{
    \item \emph{bugfix} - \code{valgrind} 
    'Conditional jump or move depends on uninitialized value(s)'.
    
	  \item added test case for topology error
	  
	  \item added startup message for package version
    
    \item \emph{bugfix} - topology error; if a region cannot be placed
    return topology error 100. 
    this has a major impact on the return value of the fitness function.
    
    \code{# accept only feasible solutions!}
    
    \code{if (sum(cartogram$topology.error == 100) > 0){return (0)}}
    
    \item make \code{recmap.h} pass google/styleguides using
    \href{https://github.com/google/styleguide/tree/gh-pages/cpplint}{cpplint}.
    
    \item manual and vignette cosmetics.

  }
}


\section{Changes in version 0.3.0 (2016-05-30)}{
  \itemize{
    \item refactor linear MBB intersection test by introducing using 
    \code{std::multiset}. 
    
    \item added local relative position and topology objective function.
    \item added GA metaheuristic example in man page.
    \item improved documentation (man page and vignette).
    \item added unit test case for recmap.
    \item added NEWS.Rd file.
  }
  }

\section{Changes in version 0.2.1 (2016-05-01)}{
  \itemize{
    \item cosmetics in the DESCRIPTION; on CRAN.
  }
}


\section{Changes in version 0.2.0 (2016-05-01)}{
  \itemize{
    \item 1st submit to CRAN.
  }
}


