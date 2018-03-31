#R

context("recmap Greedy Random Adaptive Search")

test_that("input 4x4 checker board", {
  
  set.seed(1)
  rv <- recmapGRASP(checkerboard(4))

  expect_s3_class(rv, "recmapGRASP")

  solution <- c(7, 14, 3, 5, 8, 13, 10, 9, 16, 12, 4, 15, 11, 2, 6, 1)

  expect_equal(rv$GRASP$solution, solution)
})
