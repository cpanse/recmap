\name{NEWS}
\title{News for Package 'recmap'}

\section{Changes until version 0.5.12 (2017-01-02)}{
improvements concerning \href{https://www.jstatsoft.org}{JSS} reviewer comments
  \itemize{
  
  \item added \code{sp2recmap} method
  \item added a 'meta' plot methods \code{plot.recmapGA} and 
  \code{plot.recmapGRAP}

    \item added \code{border} attribute in \code{plot.recmap} method
    \item \code{plot.recmap} labels are now scaled by using \code{S$dx / strwidth(S$name)}.
  }
  }
  
\section{Changes until version 0.5.4 (2016-12-13)}{
  \itemize{
  	\item added screen filling parameter in \code{summary.recmap} function.
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
    this has a major impact to the return value of the fitness function.
    
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


