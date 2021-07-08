
bucket_name <- "readwriteaws-test-poissonconsulting"
# directory <- tempdir()

file_01 <- "shiny-upload/api_test/demo-1.pdf"
file_02 <- "shiny-upload/api_test/demo-2.pdf"
file_03 <- "shiny-upload/api_test/demo-3.pdf"

# file_01_path <- paste0(directory, "/", file_01)
# file_02_path <- paste0(directory, "/", file_02)
# file_03_path <- paste0(directory, "/", file_03)

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

test_that("confirm file_02 doesn't exist yet", {
  expect_false(file.exists(file_02_path))
})

test_that("confirm file_03 doesn't exist yet", {
  expect_false(file.exists(file_03_path))
})

test_that("save multiple files to temp directory", {
  rwa_download_files(file_list = multi_files,
                     directory = directory,
                     bucket_name = bucket_name)
  expect_true(file.exists(file_02_path))
  expect_true(file.exists(file_03_path))
})

#### Test inputs ####

files_in_list <- list(file_01, file_02)

test_that("function should error if list of files instead of vector given", {
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
  expect_error(rwa_download_files(file_list = multi_files,
                                  directory = directory,
                                  bucket_name = 01),
               regexp = "must be a string")
})

test_that("function should error when progress is not logical", {
  expect_error(rwa_download_files(file_list = multi_files,
                                  directory = directory,
                                  bucket_name = bucket_name,
                                  progress = "no"),
               regexp = "must be logical")
})

test_that("function should error when fake file provided", {
  expect_error(rwa_download_files(file_list = "shiny-upload/api_test/demo-1",
                                  directory = directory,
                                  bucket_name = bucket_name),
               regexp = "HTTP 404")
})

### for creating and destroying temp dir in blocks of code
### but in suggests

#withr::
#batchR
