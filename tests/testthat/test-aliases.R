test_that("English aliases exist and are functions", {
  expect_true(is.function(get_entities))
  expect_true(is.function(get_annexes))
  expect_true(is.function(get_annual_accounts))
  expect_true(is.function(get_delivery_status))
  expect_true(is.function(get_budget_report))
  expect_true(is.function(get_fiscal_report))
  expect_true(is.function(get_msc_control))
  expect_true(is.function(get_msc_budget))
  expect_true(is.function(get_msc_equity))
})

test_that("English aliases use English parameter names", {
  expect_named(
    formals(get_annual_accounts),
    c("fiscal_year", "entity_id", "appendix", "use_cache")
  )
  expect_named(
    formals(get_delivery_status),
    c("entity_id", "year", "use_cache")
  )
  expect_named(
    formals(get_budget_report),
    c("fiscal_year", "period", "report_type", "appendix",
      "sphere", "entity_id", "use_cache")
  )
  expect_named(
    formals(get_fiscal_report),
    c("fiscal_year", "periodicity", "period", "report_type",
      "appendix", "sphere", "branch", "entity_id", "use_cache")
  )
  expect_named(
    formals(get_msc_control),
    c("entity_id", "year", "month", "matrix_type",
      "account_class", "value_type", "use_cache")
  )
})

test_that("English aliases report English param names in errors", {
  expect_error(get_annual_accounts(), "fiscal_year")
  expect_error(get_delivery_status(), "entity_id")
  expect_error(get_budget_report(), "fiscal_year")
  expect_error(get_fiscal_report(), "fiscal_year")
  expect_error(get_msc_control(), "entity_id")
  expect_error(get_msc_budget(), "entity_id")
  expect_error(get_msc_equity(), "entity_id")
})

test_that("Original functions report Portuguese param names in errors", {
  expect_error(get_dca(), "an_exercicio")
  expect_error(get_extrato(), "id_ente")
  expect_error(get_rreo(), "an_exercicio")
  expect_error(get_rgf(), "an_exercicio")
  expect_error(get_msc_controle(), "id_ente")
})
