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
  # check that it is greater then 0
  chk::chk_string(pattern)

  s3 <- paws::s3()
  key_list <- s3$list_objects_v2(Bucket = bucket_name, MaxKeys = max_request_size)

  key_names <- lapply(key_list$Contents, function(x) {x$Key})
  key_names <- unlist(key_names)

  grep(pattern, key_names, value = TRUE)
}

### some kind of tell the number, then it lets the user know to increase the max request size
### then it will be some kind of iteration till it hits the end or the max number
### need to create bucket with 1000 things in too... not sure how we shall be doing that...
