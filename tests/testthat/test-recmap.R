#R

context("Test recmap")

test_that("input 2x2 checker board", {
  
  
 input.map <- data.frame(x = c(1, 1, 2, 2), 
  y = c(1, 2, 1, 2), 
  dx = rep(0.5, 4), 
  dy = rep(0.5, 4), 
  z = c(4, 1, 1, 4), 
  name = c('a1', 'a2', 'b1', 'b2'))
 
  output.recmap <- recmap(input.map)

  expect_true(sum(abs(c(0.7250889, 1.0413167, 2.0000000, 2.0000000) - output.recmap$x)) < 1E-5)
  expect_true(sum(abs(c(0.6837722, 1.9586833, 1.0000000, 1.9586833) - output.recmap$y)) < 1E-5)
  expect_true(sum(abs(output.recmap$dx * 4 * output.recmap$dy - c(1.6, 0.4, 0.4, 1.6))) < 1E-6)
  expect_true(sum(c("x", "y", "dx", "dy", "name") %in% names(output.recmap)) == 5)
})
