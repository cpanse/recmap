#R

context("sp")

test_that("convert a SpatialPolygonsDataFrame object to a recmap object and back", {
  
  
  X <- checkerboard(8)
  XX <- as.recmap(X.sp <- as.SpatialPolygonsDataFrame(X))

  expect_is(X, 'recmap')
  expect_is(X.sp, 'SpatialPolygonsDataFrame')
  expect_is(XX, 'recmap')

  expect_true(all.equal(X, XX))
})
