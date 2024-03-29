[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/recmap)](https://cran.r-project.org/package=recmap)
[![Research software impact](http://depsy.org/api/package/cran/recmap/badge.svg)](http://depsy.org/package/r/recmap)
[![](http://cranlogs.r-pkg.org/badges/grand-total/recmap)](https://cran.r-project.org/package=recmap)
[![](http://cranlogs.r-pkg.org/badges/recmap)](https://cran.r-project.org/package=recmap) 
![](https://github.com/cpanse/recmap/workflows/R-CMD-check-recmap/badge.svg)
[![JSS](https://img.shields.io/badge/JSS-10.18637%2Fjss.v086.c01-brightgreen)](http://dx.doi.org/10.18637/jss.v086.c01)
[![codecov](https://codecov.io/github/cpanse/recmap/branch/master/graph/badge.svg?token=QbuhWl5bx5)](https://codecov.io/github/cpanse/recmap)

# recmap - Compute the Rectangular Statistical Cartogram 

This package implements the [RecMap construction algorithm (MP2)](http://dx.doi.org/10.1109/INFVIS.2004.57) using the [GA]( https://CRAN.R-project.org/package=GA) CRAN package as metaheuristic.


![rectangular population cartogram construction demo - animated gif](https://user-images.githubusercontent.com/4901987/64121133-3dfc9100-cd9e-11e9-8c35-078678966100.gif)

## 1. Installation

use [CRAN](https://CRAN.R-project.org/package=recmap)

`recmap` requires R 3.6 or later.

Released and tested versions of `recmap` are available via
[CRAN](https://CRAN.R-project.org/package=recmap), 
and can be installed using the following code

```{r}
install.packages('recmap')
```

before running `R CMD build` and `R CMD check` or running the shiny demo execute
```{r}
pkgs <- c('colorspace', 'doParallel', 'DT', 'knitr', 'maps',
  'shiny', 'testthat', 'tufte')
pkgs <- pkgs[(!pkgs %in% unique(installed.packages()[,'Package']))]
if(length(pkgs) > 0){install.packages(pkgs)}
```

## 2. Documentation

The package ships with a package 
[vignette](https://CRAN.R-project.org/package=recmap/vignettes/recmap.html)
(`browseVignettes('recmap')`)
and a reference manual (just type `?recmap` on the R shell).
Both documents are also available on the package's 
[CRAN](https://CRAN.R-project.org/package=recmap) page.
A white paper containing more technical information and examples is
available through [jss.v086.c01](http://dx.doi.org/10.18637/jss.v086.c01).

## 3. Demonstration

Run an interactive shiny application

```{r}
library(recmap)
GA::gaControl("useRcpp" = FALSE) # apple M1
recmap_shiny <- system.file('shiny-examples', package = 'recmap')
shiny::runApp(recmap_shiny, display.mode = 'normal')
```

Run the recmap shiny demonstration as a stand-alone application
using Linux and macOS systems use the `Terminal` application add the following 
code to your alias file, e.g., `$HOME/.bashrc`

```
alias recmapShiny="R -e \"library(shiny); \
  recmap_shiny <- system.file('shiny-examples', package = 'recmap'); \
  shiny::runApp(recmap_shiny, display.mode = 'normal', launch.browser=TRUE)\""
```

execute 

`. $HOME/.bashrc && recmapShiny` 

## 4. (Frequently) Asked Questions

### 4.1 Is there an easy way to convert a `recmap` object to an [`sf`](https://CRAN.R-project.org/package=sf ) object?


Use [`as.SpatialPolygonsDataFrame`](https://github.com/cpanse/recmap/blob/da2f90d2edb3feda7464bb543147d2908851e92b/R/recmap.R#L265),
see also issue [#13](https://github.com/cpanse/recmap/issues/13). 
The `as.recmap` function performs the transformation from a
`SpatialPolygonsDataFrame` into a `recmap` compatible object.

## 5. Related approaches

* [Rectangular Cartograms: the game](https://bspeckmann.win.tue.nl/demos/game/index.html), [Rectangular Cartograms](https://bspeckmann.win.tue.nl/Cartograms/SoccerCarto.html)
* cartogram: Create Cartograms with R [https://CRAN.R-project.org/package=cartogram](https://CRAN.R-project.org/package=cartogram)
* [Rcartogram](https://github.com/omegahat/Rcartogram)
* [High-performance software to produce flow-based cartograms.](https://github.com/Flow-Based-Cartograms/go_cart) 
* see also [CRAN Task View: Analysis of Spatial Data](https://CRAN.R-project.org/view=Spatial)
* Computing Stable Demers Cartograms - https://arxiv.org/abs/1908.07291
