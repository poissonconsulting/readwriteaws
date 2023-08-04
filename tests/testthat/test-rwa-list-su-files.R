
bucket_name <- "readwriteaws-test-poissonconsulting"

test_that("get 6 image related files", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "image",
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 6L)
})

test_that("get 2 image related files", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "image",
    max_request_size = 2,
    silent = TRUE
  )
  expect_equal(length(file_list), 2L)
})

test_that("get 1 image related files", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "image",
    max_request_size = 1,
    silent = TRUE
  )
  expect_equal(length(file_list), 1L)
})

test_that("get 4 logger related files", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "logger",
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 4L)
})

test_that("get 4 pdf related files", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "pdf",
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 4L)
})

test_that("get 6 punch data related files", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "punched-data",
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 6L)
})

test_that("get 6 tracks related files", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "tracks",
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 6L)
})

test_that("get 4 files - pdf and year, month, day", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "pdf",
    year = 2023,
    month = 08,
    day = 02,
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 4L)
})

test_that("get 4 files - pdf and year", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "pdf",
    year = 2023,
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 4L)
})

test_that("get 4 files - logger and year, month", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "logger",
    year = 2023,
    month = 08,
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 4L)
})

test_that("get 4 files - logger and year, month when month
          passed as single digit", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "logger",
    year = 2023,
    month = 8,
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 4L)
})

test_that("get 26 files - year & month", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    year = 2023,
    month = 08,
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 26L)
})

test_that("get 2 files - pdf and day", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "logger",
    day = 02,
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 2L)
})

test_that("get 11 files - file name of input_data", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    file_name = "input_data",
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 11L)
})

test_that("get 7 files - file name of uploaded_file", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    file_name = "uploaded_file",
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 7L)
})

test_that("get 13 files - file extension csv", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    file_extension = "csv",
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 13L)
})

test_that("get 2 files - file extension pdf", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    file_extension = "pdf",
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 2L)
})

test_that("get 2 files - file extension gpx", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    file_extension = "gpx",
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 2L)
})

test_that("get 6 files - tracks and day given as 2 digits", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "tracks",
    day = 03,
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 6L)
})

test_that("get 0 files - tracks and day given as 2 digits", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "tracks",
    day = 02,
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(file_list, character(0))
})

test_that("get 6 files - tracks and day given as 1 digit", {
  file_list <- rwa_list_su_files(
    bucket_name = bucket_name,
    data_type = "tracks",
    day = 3,
    max_request_size = 2000,
    silent = TRUE
  )
  expect_equal(length(file_list), 6L)
})

test_that("error when year is passed as string", {
  expect_error(rwa_list_su_files(
    bucket_name = bucket_name,
    year = "2021",
    max_request_size = 2000,
    silent = TRUE
  ),
  regexp = "must be a whole number"
  )
})

test_that("error when month is passed as string", {
  expect_error(rwa_list_su_files(
    bucket_name = bucket_name,
    month = "07",
    max_request_size = 2000,
    silent = TRUE
  ),
  regexp = "must be a whole number"
  )
})

test_that("error when month is passed as string", {
  expect_error(rwa_list_su_files(
    bucket_name = bucket_name,
    day = "30",
    max_request_size = 2000,
    silent = TRUE
  ),
  regexp = "must be a whole number"
  )
})

#### Credentials ####

Sys.sleep(5)

test_that("Fails with bad key", {
  expect_error(
    rwa_list_su_files(
      bucket_name = bucket_name,
      aws_access_key_id = "fake_key"
    ),
    regexp = "InvalidAccessKeyId"
  )
})

Sys.sleep(5)

test_that("Fails with bad secret", {
  expect_error(
    rwa_list_su_files(
      bucket_name = bucket_name,
      aws_secret_access_key = "fake_secret"
    ),
    regexp = "SignatureDoesNotMatch"
  )
})

Sys.sleep(5)

test_that("Fails with bad region", {
  expect_error(
    rwa_list_su_files(
      bucket_name = bucket_name,
      region = "fake_place"
    ),
    regexp = "Could not resolve host"
  )
})

Sys.sleep(5)
