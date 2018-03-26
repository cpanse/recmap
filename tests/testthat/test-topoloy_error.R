#R

context("topology fitness")

test_that("input 2x2 checker board for topoloy error test", {
  
  
 input.map <- data.frame(x = c(1, 1, 2, 2), 
  y = c(1, 2, 1, 2), 
  dx = rep(0.5, 4), 
  dy = rep(0.5, 4), 
  z = c(4, 1, 1, 4), 
  name = c('a1', 'a2', 'b1', 'b2'))
 
  output.recmap <- recmap(input.map)

  #  a1 loast a2 and b1                 => d_T = 2
  #  a2 lost a1 and b1                  => d_T = 2
  #  b1 lost a1 and a2                  => d_T = 2
  #  b2 is connected to all map regions => d_T = 0
  expect_true(sum(output.recmap$topology.error == c(2,2,2,0)) == 4)
})
