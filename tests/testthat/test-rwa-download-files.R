
bucket_name <- "readwriteaws-test-poissonconsulting"

file_01 <- "shiny-upload/api_test/demo-1.pdf"
file_02 <- "shiny-upload/api_test/demo-2.pdf"
file_03 <- "shiny-upload/api_test/demo-3.pdf"

multi_files <- c(file_02, file_03)

test_that("save single file to temp directory", {
  directory <- withr::local_tempdir()
  file_01_path <- paste0(directory, "/", file_01)

  expect_false(file.exists(file_01_path))

  rwa_download_files(file_list = file_01,
                     directory = directory,
                     bucket_name = bucket_name)
  expect_true(file.exists(file_01_path))
})

test_that("save multiple files to temp directory", {
  directory <- withr::local_tempdir()
  file_02_path <- paste0(directory, "/", file_02)
  file_03_path <- paste0(directory, "/", file_03)

  expect_false(file.exists(file_02_path))
  expect_false(file.exists(file_03_path))

  rwa_download_files(file_list = multi_files,
                     directory = directory,
                     bucket_name = bucket_name)
  expect_true(file.exists(file_02_path))
  expect_true(file.exists(file_03_path))
})

#### Test inputs ####

files_in_list <- list(file_01, file_02)

test_that("function should error if list of files instead of vector given", {
  directory <- withr::local_tempdir()
  expect_error(rwa_download_files(file_list = files_in_list,
                     directory = directory,
                     bucket_name = bucket_name),
               regexp = "must be character")
})

test_that("function should error when directory is not a string", {
  expect_error(rwa_download_files(file_list = multi_files,
                                  directory = 01,
                                  bucket_name = bucket_name),
               regexp = "must be a string")
})

test_that("function should error when bucket is not a string", {
  directory <- withr::local_tempdir()
  expect_error(rwa_download_files(file_list = multi_files,
                                  directory = directory,
                                  bucket_name = 01),
               regexp = "must be a string")
})

test_that("function should error when silent is not logical", {
  directory <- withr::local_tempdir()
  expect_error(rwa_download_files(file_list = multi_files,
                                  directory = directory,
                                  bucket_name = bucket_name,
                                  silent = "no"),
               regexp = "must be a flag")
})

test_that("function should error when ask is not logical", {
  directory <- withr::local_tempdir()
  expect_error(rwa_download_files(file_list = multi_files,
                                  directory = directory,
                                  bucket_name = bucket_name,
                                  ask = "no"),
               regexp = "must be a flag")
})


test_that("function should error when fake file provided", {
  directory <- withr::local_tempdir()
  expect_error(rwa_download_files(file_list = "shiny-upload/api_test/demo-1",
                                  directory = directory,
                                  bucket_name = bucket_name),
               regexp = "HTTP 404")
})
