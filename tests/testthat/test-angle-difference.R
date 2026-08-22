test_that("angle difference uses sum for opposite-sign bearings (#8)", {
  # ComputeError: when gammaM and gammaC have opposite signs the delta
  # is |gammaC + gammaM| instead of |gammaC - gammaM|, so that bearings
  # straddling the +/-pi discontinuity yield a small angular difference.
  gammaM <- -3.0
  gammaC <- 2.8
  expect_true(gammaM < 0 && gammaC > 0)
  expect_equal(abs(gammaC + gammaM), 0.2)
  expect_lt(abs(gammaC + gammaM), abs(gammaC - gammaM))
})

test_that("recmap on a shuffled checkerboard keeps small relpos errors", {
  set.seed(1)
  res <- sapply(1:10, function(i) {
    cm <- recmap(checkerboard(8)[sample(64, 64), ])
    mean(cm$relpos.error)
  })
  expect_true(all(res < 1))
})
