
bucket_name <- "readwriteaws-test-poissonconsulting"

test_that("functions works", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 2000,
    pattern = ".*",
    silent = TRUE
  )
  expect_type(file_list, "character")
  expect_equal(length(file_list), 26L)
})

test_that("regex pattern returns 6 images files", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 2000,
    pattern = "image",
    silent = TRUE
  )
  expect_equal(length(file_list), 6L)
})

test_that("regex pattern returns 4 logger files", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 2000,
    pattern = "logger",
    silent = TRUE
  )
  expect_equal(length(file_list), 4L)
})

test_that("regex pattern returns 4 pdf files", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 2000,
    pattern = "pdf",
    silent = TRUE
  )
  expect_equal(length(file_list), 4L)
})

test_that("regex pattern returns 6 punch files", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 2000,
    pattern = "punch",
    silent = TRUE
  )
  expect_equal(length(file_list), 6L)
})

test_that("regex pattern returns 6 tracks files", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 2000,
    pattern = "tracks",
    silent = TRUE
  )
  expect_equal(length(file_list), 6L)
})

test_that("regex pattern returns 12 files from Aug 2nd", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 2000,
    pattern = "2023-08-02",
    silent = TRUE
  )
  expect_equal(length(file_list), 12L)
})

test_that("regex pattern returns 14 files from Aug 3rd", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 2000,
    pattern = "2023-08-03",
    silent = TRUE
  )
  expect_equal(length(file_list), 14L)
})

test_that("regex pattern returns 13 csv files", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 2000,
    pattern = "\\.csv",
    silent = TRUE
  )
  expect_equal(length(file_list), 13L)
})

test_that("regex pattern returns 2 pdf files", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 2000,
    pattern = "\\.pdf",
    silent = TRUE
  )
  expect_equal(length(file_list), 2L)
})

test_that("regex pattern returns 26 files in 2021", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 2000,
    pattern = "2023",
    silent = TRUE
  )
  expect_equal(length(file_list), 26L)
})

test_that("function errors out when no bucket name not the same", {
  expect_error(
    rwa_list_files(
      bucket_name = "any-bucket",
      max_request_size = 2000,
      pattern = "2023",
      silent = TRUE
    ),
    regexp = "403"
  )
})

test_that("Max request of zero gives zero files", {
  file_list <-
    expect_error(
      rwa_list_files(
        bucket_name = bucket_name,
        max_request_size = 0,
        pattern = "2021",
        silent = TRUE
      ),
      "must be greater than 0, not 0."
    )
})

test_that("Max request of 10 gives 10 files", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 10,
    silent = TRUE
  )
  expect_equal(length(file_list), 10L)
})

test_that("Max request of 1 gives 1 files", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 1,
    silent = TRUE
  )
  expect_equal(length(file_list), 1L)
})

test_that("Max request of 26 gives 26 files", {
  file_list <- rwa_list_files(
    bucket_name = bucket_name,
    max_request_size = 26,
    silent = TRUE
  )
  expect_equal(length(file_list), 26L)
})

test_that("Checking message about number of files returned", {
  expect_message(
    expect_message(
      rwa_list_files(
        bucket_name = bucket_name,
        max_request_size = 2000
      ),
      regexp = "26 files were retrieved from AWS"
    ),
    regexp = "26 files returned after 'pattern' is applied"
  )
})


test_that("Checking message that max size is same as outputed files", {
  expect_message(
    expect_message(
      expect_warning(
        rwa_list_files(
          bucket_name = bucket_name,
          max_request_size = 26
        ),
        regexp = paste("'Max_request_size' matches retrieved files from AWS.",
                       "Think about increasing 'Max_request_size' as there",
                       "could be more files present")
      ),
      regexp = "26 files were retrieved from AWS"
    ),
    regexp = "26 files returned after 'pattern' is applied"
  )
})

#### Credentials ####

Sys.sleep(5)

test_that("Fails with bad key", {
  expect_error(
    rwa_list_files(
      bucket_name = bucket_name,
      aws_access_key_id = "fake_key"
    ),
    regexp = "InvalidAccessKeyId"
  )
})

Sys.sleep(5)

test_that("Fails with bad secret", {
  expect_error(
    rwa_list_files(
      bucket_name = bucket_name,
      aws_secret_access_key = "fake_secret"
    ),
    regexp = "SignatureDoesNotMatch"
  )
})

Sys.sleep(5)

test_that("Fails with bad region", {
  expect_error(
    rwa_list_files(
      bucket_name = bucket_name,
      region = "fake_place"
    ),
    regexp = "Could not resolve host"
  )
})

Sys.sleep(5)
