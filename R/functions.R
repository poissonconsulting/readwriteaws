
number_of_files <- function(bucket_name) {
  chk::chk_string(bucket_name)

  s3 <- paws::s3()
  file_list <- s3$list_objects_v2(Bucket = bucket_name)
  file_count <- length(file_list$Contents)
  file_count
}

`%||%` <- function(x, y) if (is.null(x) || length(x) == 0) y else x

pad_dates <- function(value) {
  if (nchar(value) == 1) {
    value <- paste0("0", value)
  }
  value
}
