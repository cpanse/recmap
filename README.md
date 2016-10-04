[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/recmap)](https://cran.r-project.org/package=recmap)
[![](https://images.microbadger.com/badges/image/cpanse/recmap.svg)](http://microbadger.com/images/cpanse/recmap "Get your own image badge on microbadger.com")

# recmap - Compute the Rectangular Statistical Cartogram

This package contains an implementation of the [RecMap](http://dx.doi.org/10.1109/INFVIS.2004.57) construction algorithm (MP2).


## Installation


### Install from CRAN

`recmap` requires R 3.3 or later.

Released and tested versions of `recmap` are available via the 
[CRAN](https://CRAN.R-project.org/package=recmap) network, 
and can be installed using the R shell via

```
install.package('recmap')
```


### Use the docker public | automated build [recmap image](https://hub.docker.com/r/cpanse/recmap/) 

this image contains the latest build.

```
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


## Author

Christian Panse, 2016


## License

[GPL 3](http://www.gnu.org/licenses/gpl-3.0.en.html)
