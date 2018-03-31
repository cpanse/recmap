#R

context("sp")

test_that("convert a SpatialPolygonsDataFrame object to a recmap object and back", {
  
  
  X <- checkerboard(8)

  expect_is(X, 'recmap')

  XX <- as.recmap(X.sp <- as.SpatialPolygonsDataFrame(X))

  expect_is(X.sp, 'SpatialPolygonsDataFrame')
  expect_is(XX, 'recmap')

  expect_true(sum(X$x == XX$x) == 64)
  expect_true(sum(X$y == XX$y) == 64)
  expect_true(sum(X$z == XX$z) == 64)
  expect_true(sum(X$name == XX$name) == 64)
  expect_true(sum(X$dx == XX$dx) == 64)
  expect_true(sum(X$dy == XX$dy) == 64)

## TODO(cp): idea would be expect_identical
})
