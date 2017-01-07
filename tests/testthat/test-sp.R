#R

context("Test recmap")

test_that("recmap2sp and sp2recmap", {
  
  
  X <- checkerboard(8)
  XX <- sp2recmap(recmap2sp(X))

  expect_true(sum(X$x == XX$x) == 64)
  expect_true(sum(X$y == XX$y) == 64)
  expect_true(sum(X$z == XX$z) == 64)
  expect_true(sum(X$name == XX$name) == 64)
  expect_true(sum(X$dx == XX$dx) == 64)
  expect_true(sum(X$dy == XX$dy) == 64)
})
