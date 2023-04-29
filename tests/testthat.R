#R


library(testthat)

suppressPackageStartupMessages(library(recmap))

if (Sys.info()['machine'] == "arm64") GA::gaControl(useRcpp = FALSE)

test_check("recmap")

