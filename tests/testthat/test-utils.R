test_that("plugin validation works", {
  plugins <- list(
    "wrong-plugin" = NULL
  )

  expect_error({
    validate_plugins(plugins)
  })
})
