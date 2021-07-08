
bucket_name <- "readwriteaws-test-poissonconsulting"

s3_bucket <- paws::s3()

test_that("put single file in a bucket", {
  # set up
  x <- c(1, 2, 3)
  temp_folder <- withr::local_tempdir()
  saveRDS(data.frame(x = 1), file.path(temp_folder, "test.rds"))
  file_name <- file.path(temp_folder, "test.rds")
  # check file not present
  expect_error(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = file_name
    ),
    regexp = "HTTP 404"
  )
  # upload files to AWS
  rwa_upload_files(
    file_list = file_name,
    directory = "",
    bucket_name = bucket_name,
    bucket_path = ""
  )
  # test the file is uploaded
  expect_type(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = file_name
    ),
    "list"
  )
  # delete object
  expect_type(
    s3_bucket$delete_object(
      Bucket = bucket_name,
      Key = file_name
    ),
    "list"
  )
  # check file not present
  expect_error(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = file_name
    ),
    regexp = "HTTP 404"
  )
})

test_that("put multiple files in a bucket", {
  # set up
  x <- c(1, 2, 3)
  temp_folder <- withr::local_tempdir()
  saveRDS(data.frame(x = 1), file.path(temp_folder, "test_01.rds"))
  file_name_01 <- file.path(temp_folder, "test_01.rds")

  y <- c(1, 2, 3)
  temp_folder <- withr::local_tempdir()
  saveRDS(data.frame(x = 1), file.path(temp_folder, "test_02.rds"))
  file_name_02 <- file.path(temp_folder, "test_02.rds")

  multi_files <- c(file_name_01, file_name_02)

  # check file not present
  expect_error(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = file_name_01
    ),
    regexp = "HTTP 404"
  )

  expect_error(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = file_name_02
    ),
    regexp = "HTTP 404"
  )

  # upload files to AWS
  rwa_upload_files(
    file_list = multi_files,
    directory = "",
    bucket_name = bucket_name,
    bucket_path = ""
  )

  # test the file is uploaded
  expect_type(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = file_name_01
    ),
    "list"
  )

  expect_type(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = file_name_02
    ),
    "list"
  )

  # delete object
  expect_type(
    s3_bucket$delete_object(
      Bucket = bucket_name,
      Key = file_name_01
    ),
    "list"
  )

  expect_type(
    s3_bucket$delete_object(
      Bucket = bucket_name,
      Key = file_name_02
    ),
    "list"
  )

  # check file not present
  expect_error(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = file_name_01
    ),
    regexp = "HTTP 404"
  )

  expect_error(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = file_name_02
    ),
    regexp = "HTTP 404"
  )
})

#### Test inputs ####

test_that("function should error if list of files instead of vector given", {
  files_in_list <- list(1, 2)

  expect_error(
    rwa_upload_files(
      file_list = files_in_list,
      directory = "R",
      bucket_name = bucket_name
    ),
    regexp = "must be character"
  )
})

test_that("function should error when directory is not a string", {
  expect_error(
    rwa_upload_files(
      file_list = "functions.R",
      directory = 01,
      bucket_name = bucket_name
    ),
    regexp = "must be a string"
  )
})

test_that("function should error when bucket is not a string", {
  expect_error(
    rwa_upload_files(
      file_list = "functions.R",
      directory = "R",
      bucket_name = 01
    ),
    regexp = "must be a string"
  )
})

test_that("function should error when bucket_path is not a string", {
  expect_error(
    rwa_upload_files(
      file_list = "functions.R",
      directory = "R",
      bucket_name = bucket_name,
      bucket_path = 01
    ),
    regexp = "must be a string"
  )
})
