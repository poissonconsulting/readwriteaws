#' List Files in S3 Bucket
#'
#' Lists all files from s3 bucket
#' @inheritParams params
#'
#' @export
#'
#'

rwa_list_files <- function(bucket_name,
                           ### it can also be NULL not sure whats a better default value
                           ### how does user know if they should increase? print total number returned?
                           max_request_size = 1000L,
                           pattern = ".*") {
  chk::chk_string(bucket_name)
  chk::chk_integer(max_request_size)
  chk::chk_string(pattern)

  s3 <- paws::s3()
  key_list <- s3$list_objects_v2(Bucket = bucket_name, MaxKeys = max_request_size)

  key_names <- lapply(key_list$Contents, function(x) {x$Key})
  key_names <- unlist(key_names)

  grep(pattern, key_names, value = TRUE)
}
