#R

context("jss2711")

test_that("reproducibility check for recmapGA using a 4x4 checkerboard (Figure 7)", {
  #skip_on_os(os='mac')
  
  seeds <- c(1, 1, 2, 2, 3, 3)
  
  res <- lapply(seeds, function(seed){
    
    set.seed(seed);
    
    res <- recmapGA(Map = checkerboard(4), 
                    pmutation = 0.25, 
                    parallel = FALSE)
    res$seed <- seed
    res})
  
  # extract best solution for each run
  solutions <- lapply(res, function(x){x$GA@solution[1,]})
  
  # solution must be identical on the same platform
  expect_identical(solutions[[1]], solutions[[2]])
  expect_identical(solutions[[3]], solutions[[4]])
  expect_identical(solutions[[5]], solutions[[6]])
})

test_that("cross-platform reproducibility check of Figures 11 (Switzerland))", {
  skip_on_cran()
  
  data(jss2711)
  Switzerland.recmap <- recmap(Switzerland$Map)

  expect_equal(Switzerland.recmap[, 'x'], Switzerland$Cartogram[, 'x'], tolerance = 0.001)
  expect_equal(Switzerland.recmap[, 'y'], Switzerland$Cartogram[, 'y'], tolerance = 0.001)
  expect_equal(Switzerland.recmap[, 'dx'], Switzerland$Cartogram[, 'dx'], tolerance = 0.001)
  expect_equal(Switzerland.recmap[, 'dy'], Switzerland$Cartogram[, 'dy'], tolerance = 0.001)
  
})

test_that("cross-platform reproducibility check of Figures 12 (SBB))", {
  
  data(jss2711)
  SBB.recmap <- recmap(SBB$Map)

  expect_equal(SBB.recmap[, 'x'], SBB$Cartogram[, 'x'], tolerance = 0.001)
  expect_equal(SBB.recmap[, 'y'], SBB$Cartogram[, 'y'], tolerance = 0.001)
  expect_equal(SBB.recmap[, 'dx'], SBB$Cartogram[, 'dx'], tolerance = 0.001)
  expect_equal(SBB.recmap[, 'dy'], SBB$Cartogram[, 'dy'], tolerance = 0.001)
  
})

test_that("cross-platform reproducibility check of Figures 13 (UK))", {
 

  data(jss2711)

  # note: map idx is in best solution order
  UK.recmap <- recmap(UK$Map)

  expect_equal(UK.recmap[, 'x'], UK$Cartogram[, 'x'], tolerance = 0.001)
  expect_equal(UK.recmap[, 'y'], UK$Cartogram[, 'y'], tolerance = 0.001)
  expect_equal(UK.recmap[, 'dx'], UK$Cartogram[, 'dx'], tolerance = 0.001)
  expect_equal(UK.recmap[, 'dy'], UK$Cartogram[, 'dy'], tolerance = 0.001)
  
})
