
bucket_name <- "readwriteaws-test-poissonconsulting"

test_that("get 2 image related files", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            data_type = "image",
                            max_request_size = 2000)
  expect_equal(length(file_list), 2L)
})

test_that("get 2 logger related files", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            data_type = "logger",
                            max_request_size = 2000)
  expect_equal(length(file_list), 2L)
})

test_that("get 4 pdf related files", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            data_type = "pdf",
                            max_request_size = 2000)
  expect_equal(length(file_list), 4L)
})

test_that("get 3 punch data related files", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            data_type = "punch-data",
                            max_request_size = 2000)
  expect_equal(length(file_list), 3L)
})

test_that("get 3 tracks related files", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            data_type = "tracks",
                            max_request_size = 2000)
  expect_equal(length(file_list), 3L)
})

test_that("get 2 files - pdf and year, month, day", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            data_type = "pdf",
                            year = "2021",
                            month = "06",
                            day = "30",
                            max_request_size = 2000)
  expect_equal(length(file_list), 2L)
})

test_that("get 4 files - pdf and year", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            data_type = "pdf",
                            year = "2021",
                            max_request_size = 2000)
  expect_equal(length(file_list), 4L)
})

test_that("get 2 files - pdf and year, month", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            data_type = "pdf",
                            year = "2021",
                            month = "06",
                            max_request_size = 2000)
  expect_equal(length(file_list), 2L)
})

test_that("get 5 files - year & month", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            year = "2021",
                            month = "07",
                            max_request_size = 2000)
  expect_equal(length(file_list), 5L)
})

test_that("get 2 files - pdf and day", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            data_type = "pdf",
                            day = "30",
                            max_request_size = 2000)
  expect_equal(length(file_list), 2L)
})

test_that("get 6 files - file name of input_data", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            file_name = "input_data",
                            max_request_size = 2000)
  expect_equal(length(file_list), 6L)
})

test_that("get 4 files - file name of input_data", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            file_name = "uploaded_file",
                            max_request_size = 2000)
  expect_equal(length(file_list), 4L)
})

test_that("get 7 files - file extension csv", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            file_extension =  "csv",
                            max_request_size = 2000)
  expect_equal(length(file_list), 7L)
})

test_that("get 2 files - file extension pdf", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            file_extension =  "pdf",
                            max_request_size = 2000)
  expect_equal(length(file_list), 2L)
})

test_that("get 1 files - file extension gpx", {
  file_list <- rwa_get_data(bucket_name = bucket_name,
                            file_extension =  "gpx",
                            max_request_size = 2000)
  expect_equal(length(file_list), 1L)
})

test_that("error when year is not passed as string", {
  expect_error(rwa_get_data(bucket_name = bucket_name,
                            year = 2021,
                            max_request_size = 2000),
               regexp = "must be a string")
})

test_that("error when month is not passed as string", {
  expect_error(rwa_get_data(bucket_name = bucket_name,
                            month = 07,
                            max_request_size = 2000),
               regexp = "must be a string")
})

test_that("error when month is not passed as string", {
  expect_error(rwa_get_data(bucket_name = bucket_name,
                            day = 30,
                            max_request_size = 2000),
               regexp = "must be a string")
})
