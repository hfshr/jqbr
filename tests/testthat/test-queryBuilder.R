filters <- list(
  list(
    id = "name",
    label = "Name",
    type = "string"
  )
)

test_that("invalid operator fails", {
  expect_error({
    queryBuilderInput(
      inputId = "test",
      filters = filters,
      operators = "bad_value"
    )
  })
})

test_that("invalid return value fails", {
  expect_error({
    queryBuilderInput(
      inputId = "test",
      filters = filters,
      return_value = "wrong_value"
    )
  })
})

test_that("operator input works", {
  expect_error({
    queryBuilderInput(
      inputId = "test",
      filters = filters,
      return_value = "all",
      operators = "oops"
    )
  })

  expect_error({
    queryBuilderInput(
      inputId = "test",
      filters = filters,
      return_value = "sql",
      add_na_filter = TRUE
    )
  })



  expect_type(
    {
      queryBuilderInput(
        inputId = "test",
        filters = filters,
        return_value = "r_rules",
        add_na_filter = TRUE
      )
    },
    "list"
  )
})
