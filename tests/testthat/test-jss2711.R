#R

context("Test jss2711")

test_that("test recmapGA on a 4x4 checkerboard (jss2711 paper Figure 7)", {
  
  seeds <- c(1, 1, 2, 2, 3, 3)
  
  res <- lapply(seeds, function(seed){
    
    set.seed(seed);
    
    res <- recmapGA(Map = checkerboard(4), 
                    pmutation = 0.25, 
                    parallel = FALSE)
    res$seed <- seed
    res})
  
  # sanity check - extract best solution
  solutions <- lapply(res, function(x){x$GA@solution[1,]})
  
  # solution must be identical on the same platform
  expect_true(identical(solutions[[1]], solutions[[2]]))
  expect_true(identical(solutions[[3]], solutions[[4]]))
  expect_true(identical(solutions[[5]], solutions[[6]]))
})

test_that("test reproducibility of jss2711 Figures 11 (Switzerland))", {
  
  data(jss2711)
  solutions.best <- Switzerland$solution
  Switzerland.recmap <- recmap(Switzerland$map[solutions.best, ])

  expect_equal(Switzerland.recmap[, 'x'], Switzerland$cartogram[, 'x'], tolerance = 0.001)
  expect_equal(Switzerland.recmap[, 'y'], Switzerland$cartogram[, 'y'], tolerance = 0.001)
  expect_equal(Switzerland.recmap[, 'dx'], Switzerland$cartogram[, 'dx'], tolerance = 0.001)
  expect_equal(Switzerland.recmap[, 'dy'], Switzerland$cartogram[, 'dy'], tolerance = 0.001)
  
})

test_that("test reproducibility of jss2711 Figures 12 (SBB))", {
  
  data(jss2711)
  solutions.best <- SBB$GA@solution[1, ]
  SBB.recmap <- recmap(SBB$Map[solutions.best,])

  expect_equal(SBB.recmap[, 'x'], SBB$Cartogram[, 'x'], tolerance = 0.001)
  expect_equal(SBB.recmap[, 'y'], SBB$Cartogram[, 'y'], tolerance = 0.001)
  expect_equal(SBB.recmap[, 'dx'], SBB$Cartogram[, 'dx'], tolerance = 0.001)
  expect_equal(SBB.recmap[, 'dy'], SBB$Cartogram[, 'dy'], tolerance = 0.001)
  
})

test_that("test reproducibility of jss2711 Figures 13 (UK))", {
  
  data(jss2711)

  # note: map idx is in best solution order
  UK.recmap <- recmap(UK$Map)

  expect_equal(UK.recmap[, 'x'], UK$Cartogram[, 'x'], tolerance = 0.001)
  expect_equal(UK.recmap[, 'y'], UK$Cartogram[, 'y'], tolerance = 0.001)
  expect_equal(UK.recmap[, 'dx'], UK$Cartogram[, 'dx'], tolerance = 0.001)
  expect_equal(UK.recmap[, 'dy'], UK$Cartogram[, 'dy'], tolerance = 0.001)
  
})