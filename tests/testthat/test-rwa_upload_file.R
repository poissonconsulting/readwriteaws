
bucket_name <- "readwriteaws-test-poissonconsulting"

file_01 <- "tests/shiny-upload/upload_test/demo-1.pdf"
file_02 <- "tests/shiny-upload/upload_test/demo-2.pdf"
directory <- "inst"
key_path_01 <- paste0(directory, "/", file_01)
key_path_02 <- paste0(directory, "/", file_02)
multi_files <- c(file_01, file_02)

s3_bucket <- paws::s3()

test_that("test files are not in bucket", {
  expect_error(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = key_path_01
    ),
    regexp = "HTTP 404"
  )

  expect_error(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = key_path_02
    ),
    regexp = "HTTP 404"
  )

})

test_that("put files in bucket and confirm present", {

  rwa_upload_files(
    file_list = multi_files,
    directory = directory,
    bucket_name = bucket_name,
    bucket_path = ""
  )

  expect_type(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = key_path_01
    ),
    "list"
  )

  expect_type(
    s3_bucket$get_object(
      Bucket = bucket_name,
      Key = key_path_02
    ),
    "list"
  )
})

test_that("delete files - ie clean up", {
  expect_type(
    s3_bucket$delete_object(
      Bucket = bucket_name,
      Key = key_path_01
    ),
    "list"
  )

  expect_type(
    s3_bucket$delete_object(
      Bucket = bucket_name,
      Key = key_path_02
    ),
    "list"
  )

})

#### Test inputs ####









