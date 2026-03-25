test_that("cache_key creates deterministic keys", {
  k1 <- cache_key("http://example.com", list(a = 1, b = 2))
  k2 <- cache_key("http://example.com", list(b = 2, a = 1))
  # Order should not matter because we sort

  expect_equal(k1, k2)
})

test_that("cache_get returns NULL for missing keys", {
  expect_null(cache_get("nonexistent_key_12345"))
})

test_that("cache_set and cache_get round-trip", {
  cache_set("test_key_abc", list(x = 42))
  result <- cache_get("test_key_abc")
  expect_equal(result, list(x = 42))
  # Clean up

  rm("test_key_abc", envir = the_cache)
})

test_that("siconfir_clear_cache empties the cache", {
  cache_set("temp_key_1", "value1")
  cache_set("temp_key_2", "value2")
  expect_false(length(ls(envir = the_cache)) == 0)
  siconfir_clear_cache()
  expect_equal(length(ls(envir = the_cache)), 0)
})

test_that("base_url returns expected URL", {
  expect_equal(
    base_url(),
    "https://apidatalake.tesouro.gov.br/ords/siconfi/tt"
  )
})
