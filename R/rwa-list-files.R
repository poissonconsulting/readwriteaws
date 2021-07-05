#' List Files in S3 Bucket
#'
#' Lists all files from s3 bucket
#' @inheritParams params
#' @examples
#' \dontrun{
#' # List all files in the bucket
#' rwa_list_files(bucket_name = "my-project-bucket")
#'
#' # Add regex to only list pdfs from June 30th
#' rwa_list_files(bucket_name = "my-project-bucket",
#'                pattern = "pdf.*2021-06-30")
#'
#' # Add regex to only list files from 2021
#' rwa_list_files(bucket_name = "my-project-bucket",
#'                pattern = "2021")
#' }
#' @export
rwa_list_files <- function(bucket_name,
                           ### it can also be NULL not sure whats a better default value
                           ### how does user know if they should increase? print total number returned?
                           max_request_size = 1000,
                           pattern = ".*") {
  chk::chk_string(bucket_name)
  chk::chk_whole_number(max_request_size)
  chk::chk_gt(max_request_size, value = 0)
  chk::chk_string(pattern)

  start_after <- ""
  all_keys <- c("")
  s3 <- paws::s3()
  while (max_request_size > 0) {
      key_list <- s3$list_objects_v2(Bucket =  bucket_name, MaxKeys = max_request_size, StartAfter = start_after)
      key_names <- vapply(key_list$Contents, function(x) {x$Key}, "")
      all_keys <- c(all_keys, key_names)
      n <- length(key_names)
      start_after <- key_names[n]
      max_request_size = max_request_size - n
  }

  ## negative subtraction so we only get what we request
  if (max_request_size < 0) {
    n <- length(all_keys)
    all_keys <- all_keys[1:(n+max_request_size)]
  }

  grep(pattern, all_keys, value = TRUE)
}
