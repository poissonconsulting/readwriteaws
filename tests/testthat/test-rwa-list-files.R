
bucket_name <- "readwriteaws-test-poissonconsulting"

test_that("functions works", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 1000L,
                              pattern = ".*")
  expect_type(file_list, "character")
  expect_equal(length(file_list), 1014L)
})

test_that("regex pattern returns 2 images files", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 1000L,
                              pattern = "image")
  expect_equal(length(file_list), 2L)
})

test_that("regex pattern returns 2 logger files", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 1000L,
                              pattern = "logger")
  expect_equal(length(file_list), 2L)
})

test_that("regex pattern returns 4 pdf files", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 1000L,
                              pattern = "pdf")
  expect_equal(length(file_list), 4L)
})

test_that("regex pattern returns 3 punch files", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 1000L,
                              pattern = "punch")
  expect_equal(length(file_list), 3L)
})

test_that("regex pattern returns 3 tracks files", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 1000L,
                              pattern = "tracks")
  expect_equal(length(file_list), 3L)
})

test_that("regex pattern returns 9 files from June 30th", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 1000L,
                              pattern = "2021-06-30")
  expect_equal(length(file_list), 9L)
})

test_that("regex pattern returns 5 files from July 1st", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 1000L,
                              pattern = "2021-07-01")
  expect_equal(length(file_list), 5L)
})

test_that("regex pattern returns 7 csv files", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 1000L,
                              pattern = "\\.csv")
  expect_equal(length(file_list), 7L)
})

test_that("regex pattern returns 2 pdf files", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 1000L,
                              pattern = "\\.pdf")
  expect_equal(length(file_list), 2L)
})

test_that("regex pattern returns 14 files in 2021", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 1000L,
                              pattern = "2021")
  expect_equal(length(file_list), 14L)
})

test_that("function errors out when no bucket name not the same", {
  expect_error(rwa_list_files(bucket_name = "any-bucket",
                              max_request_size = 1000L,
                              pattern = "2021"),
               regexp = "301")
})

test_that("Max request of zero gives zero files", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 0L,
                              pattern = "2021")
  expect_equal(length(file_list), 0L)
})

test_that("Max request of 10 gives 10 files", {
  file_list <- rwa_list_files(bucket_name = bucket_name,
                              max_request_size = 10L,
                              pattern = "2021")
  expect_equal(length(file_list), 10L)
})
