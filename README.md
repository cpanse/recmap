[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/recmap)](https://cran.r-project.org/package=recmap)
[![](https://images.microbadger.com/badges/image/cpanse/recmap.svg)](http://microbadger.com/images/cpanse/recmap "Get your own image badge on microbadger.com")
[![Research software impact](http://depsy.org/api/package/cran/recmap/badge.svg)](http://depsy.org/package/r/recmap)

# recmap - Compute the Rectangular Statistical Cartogram

This package contains an implementation of the [RecMap](http://dx.doi.org/10.1109/INFVIS.2004.57) construction algorithm (MP2).


## Installation


### Install from [CRAN](https://CRAN.R-project.org/package=recmap)

`recmap` requires R 3.3 or later.

Released and tested versions of `recmap` are available via the 
[CRAN](https://CRAN.R-project.org/package=recmap) network, 
and can be installed using the R shell via

```{r}
install.package('recmap')
```

### Install from [github](https://github.com/cpanse/recmap)

```{r}
install.packages('devtools')
library(devtools)
install_git('https://github.com/cpanse/recmap', build_vignettes = TRUE, quiet = FALSE)
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


## Documentation

The package ships with a package vignette (`browseVignettes('recmap')` 
and a reference manual (just type `?recmap` on the R shell).

Both documents are also available on the package's [CRAN](https://CRAN.R-project.org/package=recmap) page.


## Examples

The [recmap gallery](http://cartodraw.science/recmap/gallery/) gives an impression what can
be expected from the cartogram drawing algorithm.


## Demonstration
```{r}
library(shiny)
recmapAppDir <- system.file("shiny-examples", "state.x77", package = "recmap")
shiny::runApp(recmapAppDir, display.mode = "normal")
```

## Author

Christian Panse

## License

[GPL 3](http://www.gnu.org/licenses/gpl-3.0.en.html)
