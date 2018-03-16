#R

context("Test recmap")

test_that("test recmapGA on a 4x4 checkerboard (jss paper Figure 7)", {
  
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
  
  expect_true(all.equal(solutions[[1]], solutions[[2]]))
  expect_true(all.equal(solutions[[3]], solutions[[4]]))
  expect_true(all.equal(solutions[[5]], solutions[[6]]))
  
})
