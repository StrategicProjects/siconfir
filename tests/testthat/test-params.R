test_that("get_dca requires an_exercicio and id_ente", {
  expect_error(get_dca(), "Missing required")
  expect_error(get_dca(an_exercicio = 2022), "Missing required")
  expect_error(get_dca(id_ente = 17), "Missing required")
})

test_that("get_extrato requires id_ente and an_referencia", {
  expect_error(get_extrato(), "Missing required")
  expect_error(get_extrato(id_ente = 17), "Missing required")
  expect_error(get_extrato(an_referencia = 2022), "Missing required")
})

test_that("get_rreo requires all mandatory parameters", {
  expect_error(get_rreo(), "Missing required")
  expect_error(
    get_rreo(an_exercicio = 2022, nr_periodo = 6),
    "Missing required"
  )
})

test_that("get_rgf requires all mandatory parameters", {
  expect_error(get_rgf(), "Missing required")
  expect_error(
    get_rgf(an_exercicio = 2022, in_periodicidade = "Q"),
    "Missing required"
  )
})

test_that("get_msc_controle requires all mandatory parameters", {
  expect_error(get_msc_controle(), "Missing required")
  expect_error(
    get_msc_controle(id_ente = 17, an_referencia = 2022),
    "Missing required"
  )
})

test_that("get_msc_orcamentaria requires all mandatory parameters", {
  expect_error(get_msc_orcamentaria(), "Missing required")
})

test_that("get_msc_patrimonial requires all mandatory parameters", {
  expect_error(get_msc_patrimonial(), "Missing required")
})
