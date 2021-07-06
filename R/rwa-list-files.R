#' List Files in S3 Bucket
#'
#' Lists all files from s3 bucket
#' @inheritParams params
#' @details The AWS API only allows a max of 1000 objects to return per request.
#' The `max_request_size` argument is for creating multiple requests to the API
#' so you are able to get all the files if there are more then 1000 objects
#' in your bucket. If `max_request_size` is over 1000 it will make multiple
#' request to AWS until the `max_request_size` is reached.
#'
#' The `pattern` argument is a regex that is applied after all the files are
#' obtained from AWS. If this argument is given you may get less
#' then the value given for `max_request_size` as it will only return the
#' objects that match the pattern.
#'
#' @examples
#' \dontrun{
#' # List all files in the bucket up to a max of 1000
#' rwa_list_files(bucket_name = "my-project-bucket")
#'
#' # Add regex to only list pdfs from June 30th
#' rwa_list_files(bucket_name = "my-project-bucket",
#'                pattern = "pdf.*2021-06-30")
#'
#' # Add regex to only list files from 2021
#' rwa_list_files(bucket_name = "my-project-bucket",
#'                pattern = "2021")
#'
#' # List all files in the bucket up to a max of 2000
#' rwa_list_files(bucket_name = "my-project-bucket",
#'                max_request_size = 2000)
#' }
#' @export
rwa_list_files <- function(bucket_name,
                           max_request_size = 1000,
                           pattern = ".*") {
  chk::chk_string(bucket_name)
  chk::chk_whole_number(max_request_size)
  chk::chk_gt(max_request_size, value = 0)
  chk::chk_string(pattern)

  max_2 <- max_request_size

  start_after <- ""
  all_keys <- c()
  s3 <- paws::s3()
  while (max_request_size > 0) {
      key_list <- s3$list_objects_v2(Bucket =  bucket_name,
                                     MaxKeys = max_request_size,
                                     StartAfter = start_after
                                    )
      key_names <- vapply(key_list$Contents, function(x) {x$Key}, "")
      all_keys <- c(all_keys, key_names)
      start_after <- key_names[length(key_names)]
      max_request_size = max_request_size - 1000
  }

   grep(pattern, all_keys, value = TRUE)
}
