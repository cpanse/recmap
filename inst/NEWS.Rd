\name{NEWS}
\title{News for Package 'recmap'}

\section{Changes in recmap version 0.3.3 (2016-06-07)}{
  \itemize{
    \item bugfix - topology error; if a region can not be placed
    return topology error 100. 
    this has a major impact to the return value of the fitness function.
    
    \code{# accept only feasible solutions!}
    
    \code{if (sum(cartogram$topology.error == 100) > 0){return (0)}
  }
}

\section{Changes in recmap version 0.3.0 (2016-05-30)}{
  \itemize{
    \item refactor linear MBB intersection test by introducing using 
    \code{std::multiset}. 
    \item added local relative position and topology objective function.
    \item added GA metaheuristic example in man page.
    \item improved documentation (man page and vignette)
    \item added unit test case for recmap
    \item added NEWS.Rd file
  }
  }

\section{Changes in recmap version 0.2.1 (2016-05-01)}{
  \itemize{
    \item cosmetics in the DESCRIPTION;  on CRAN
  }
}

\section{Changes in recmap version 0.2.0 (2016-05-01)}{
  \itemize{
    \item 1st submit to CRAN
  }
}

