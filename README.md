[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/recmap)](https://cran.r-project.org/package=recmap)
[![](https://images.microbadger.com/badges/image/cpanse/recmap.svg)](http://microbadger.com/images/cpanse/recmap "Get your own image badge on microbadger.com")
[![Research software impact](http://depsy.org/api/package/cran/recmap/badge.svg)](http://depsy.org/package/r/recmap)
[![Build Status](https://travis-ci.org/cpanse/recmap.svg)](https://travis-ci.org/cpanse/recmap) 
[![](http://cranlogs.r-pkg.org/badges/grand-total/recmap)](https://cran.r-project.org/package=recmap)
[![](http://cranlogs.r-pkg.org/badges/recmap)](https://cran.r-project.org/package=recmap) 

# recmap - Compute the Rectangular Statistical Cartogram 

This package implements the [RecMap construction algorithm (MP2)](http://dx.doi.org/10.1109/INFVIS.2004.57) using the [GA]( https://CRAN.R-project.org/package=GA) CRAN package as metaheuristic.

## 1. Installation

use [CRAN](https://CRAN.R-project.org/package=recmap)

`recmap` requires R 3.5 or later.

Released and tested versions of `recmap` are available via
[CRAN](https://CRAN.R-project.org/package=recmap), 
and can be installed using the following code

```{r}
install.packages('recmap')
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
# Requires to install suggested  packages
pkgs <- c('colorspace', 'maps', 'noncensus', 'shiny')
pkgs <- pkgs[(!pkgs %in% unique(installed.packages()[,'Package']))]
if(length(pkgs) > 0){install.packages(pkgs)}

library(shiny)
recmap_shiny <- system.file('shiny-examples', package = 'recmap')
shiny::runApp(recmap_shiny, display.mode = 'normal')
```

Run the recmap shiny demonstration as a stand-alone application
using Linux and Apple systems use the `Terminal` application add the following 
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

* [Rectangular Cartograms: the game](http://www.win.tue.nl/~speckman/demos/game/index.html), [Rectangular Cartograms](http://www.win.tue.nl/~speckman/Cartograms/SoccerCarto.html)
* cartogram: Create Cartograms with R [https://CRAN.R-project.org/package=cartogram](https://CRAN.R-project.org/package=cartogram)
* [Rcartogram](https://github.com/omegahat/Rcartogram)
* [High-performance software to produce flow-based cartograms.](https://github.com/Flow-Based-Cartograms/go_cart) 
* see also [CRAN Task View: Analysis of Spatial Data](https://CRAN.R-project.org/view=Spatial)
