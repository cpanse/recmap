\name{NEWS}
\title{News for Package 'recmap'}

\section{Changes until version 0.5.31 (2018-03-23)}{
  \itemize{
	  \item added jss2711 submission as vignette file.
	  \item added jss2711 data.
	  \item replace gaMonitor2 by gaMonitor (GA3.1).
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
   \href{https://shiny.rstudio.com/reference/shiny/latest/hoverOpts.html}{hoverOpts}
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
  	\item added a screen filling parameter in \code{summary.recmap} function.
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
    'Conditional jump or move depends on uninitialised value(s)'.
    
	  \item added test case for topology error
	  
	  \item added startup message for package version
    
    \item \emph{bugfix} - topology error; if a region can not be placed
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


