[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/recmap)](https://cran.r-project.org/package=recmap)
[![](https://images.microbadger.com/badges/image/cpanse/recmap.svg)](http://microbadger.com/images/cpanse/recmap "Get your own image badge on microbadger.com")
[![Research software impact](http://depsy.org/api/package/cran/recmap/badge.svg)](http://depsy.org/package/r/recmap)
[![Build Status](https://travis-ci.org/cpanse/recmap.svg)](https://travis-ci.org/cpanse/recmap) 
[![](http://cranlogs.r-pkg.org/badges/grand-total/recmap)](https://cran.r-project.org/package=recmap)
[![](http://cranlogs.r-pkg.org/badges/recmap)](https://cran.r-project.org/package=recmap) 

# recmap - Compute the Rectangular Statistical Cartogram 

This package implementats of the [RecMap construction algorithm (MP2)](http://dx.doi.org/10.1109/INFVIS.2004.57).


## Installation


### from [CRAN](https://CRAN.R-project.org/package=recmap)

`recmap` requires R 3.3 or later.

Released and tested versions of `recmap` are available via
[CRAN](https://CRAN.R-project.org/package=recmap), 
and can be installed using the following code

```{r}
install.packages('recmap')
```

### from [github](https://github.com/cpanse/recmap)

the code below installs the latest development version

```{r}
install.packages('devtools')
library(devtools)
install_github('cpanse/recmap', build_vignettes = TRUE, quiet = FALSE)
browseVignettes('recmap')
```

### Use the docker public | automated build [recmap image](https://hub.docker.com/r/cpanse/recmap/) 

this image contains the latest build.

```{bash}
docker pull cpanse/recmap \
&& docker run -d -p 8791:8787 cpanse/recmap
```

connect to http://yourdockerhost:8791  using a web browser

* username: rstudio
* password: rstudio

or stand alone

```{bash}
docker run -it -p 8787:8787 cpanse/recmap R -e "library(shiny); recmap_shiny <- system.file('shiny-examples', package = 'recmap'); shiny::runApp(recmap_shiny, display.mode = 'normal', port=8787, host='0.0.0.0')"
```

connect to the docker host:8787

## Documentation

The package ships with a package 
[vignette](https://CRAN.R-project.org/package=recmap/vignettes/recmap.html)
(`browseVignettes('recmap')`)
and a reference manual (just type `?recmap` on the R shell).
Both documents are also available on the package's 
[CRAN](https://CRAN.R-project.org/package=recmap) page.
A white paper containing more technical information and examples is
available through [jss.v086.c01](http://dx.doi.org/10.18637/jss.v086.c01).

## Demonstration

animation of the construction algorithm

![animated GIF of the construction algorithm](https://github.com/cpanse/recmap/blob/master/vignettes/graphics/rectangular_statistical_cartogram_construction_animation.gif)


interactive shiny application

```{r}
# Requires to install suggested  packages
pkgs <- c('colorspace', 'maps', 'noncensus', 'shiny')
pkgs <- pkgs[(!pkgs %in% unique(installed.packages()[,'Package']))]
if(length(pkgs) > 0){install.packages(pkgs)}

library(shiny)
recmap_shiny <- system.file('shiny-examples', package = 'recmap')
shiny::runApp(recmap_shiny, display.mode = 'normal')
```


## Related approaches
* [Rectangular Cartograms: the game](http://www.win.tue.nl/~speckman/demos/game/index.html), [Rectangular Cartograms](http://www.win.tue.nl/~speckman/Cartograms/SoccerCarto.html)
* cartogram: Create Cartograms with R [https://CRAN.R-project.org/package=cartogram](https://CRAN.R-project.org/package=cartogram)
* [Rcartogram](https://github.com/omegahat/Rcartogram)
* [High-performance software to produce flow-based cartograms.](https://github.com/Flow-Based-Cartograms/go_cart) 
* see also [CRAN Task View: Analysis of Spatial Data](https://CRAN.R-project.org/view=Spatial)
