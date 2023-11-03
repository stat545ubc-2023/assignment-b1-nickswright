test_that("Basic functionalities", {
  expect_equal(144, square(12))
  expect_equal(c(4, 9, 16), square(2:4))
  expect_equal(list(4, 9, 16), square(list(2,3,4)))
})





