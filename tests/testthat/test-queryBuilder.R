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
      operators = "r_operators"
    )
  })

  expect_error({
    queryBuilderInput(
      inputId = "test",
      filters = filters,
      return_value = "sql",
      operators = "r_operators"
    )
  })


  expect_type(
    {
      queryBuilderInput(
        inputId = "test",
        filters = filters,
        return_value = "sql",
        operators = "sql_operators"
      )
    },
    "list"
  )

  expect_type(
    {
      queryBuilderInput(
        inputId = "test",
        filters = filters,
        return_value = "r_rules",
        operators = "r_operators"
      )
    },
    "list"
  )
})