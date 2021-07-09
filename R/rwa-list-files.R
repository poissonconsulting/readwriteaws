#' List Files in S3 Bucket
#'
#' Obtain a list of files within an AWS S3 Bucket
#'
#' @inheritParams params
#'
#' @details The AWS API only allows a max of 1000 objects to return per request.
#'   The `max_request_size` argument is for creating multiple requests to the
#'   API so you are able to get a list of all the files if there are more then
#'   1000 objects in your bucket. If `max_request_size` is over 1000 it will
#'   make multiple request to AWS until `max_request_size` is reached or all the
#'   files are listed.
#'
#'   The `pattern` argument is a regex that is applied after all the files are
#'   obtained from AWS. If this argument is given you may get less then the
#'   value given for `max_request_size` as it will only return the objects that
#'   match the pattern.
#'
#'   Review the messages outputted by the function if you are unsure if you
#'   should increase `max_request size`.
#'
#' @examples
#' \dontrun{
#' # List all files in the bucket up to a max of 1000
#' rwa_list_files(bucket_name = "my-project-bucket")
#'
#' # Add regex to only list pdfs from June 30, 2020
#' rwa_list_files(
#'   bucket_name = "my-project-bucket",
#'   pattern = "pdf.*2021-06-30"
#' )
#'
#' # List all files in the bucket up to a max of 2000
#' rwa_list_files(
#'   bucket_name = "my-project-bucket",
#'   max_request_size = 2000
#' )
#'
#' # Turn off help messages regarding total number of files returned
#' rwa_list_files(
#'   bucket_name = "my-project-bucket",
#'   silent = TRUE
#' )
#'
#' # Enter AWS credentials directly into the function
#' #' rwa_list_files(
#'   bucket_name = "my-project-bucket",
#'   aws_access_key_id = "AHSGYWKJDIUAHDSJ",
#'   aws_secret_access_key = "8HYGD54/hgdx^785809",
#'   region = "us-east-1"
#' )
#'
#' }
#' @export
rwa_list_files <- function(bucket_name,
                           max_request_size = 1000,
                           pattern = ".*",
                           silent = FALSE,
                           aws_access_key_id = Sys.getenv("AWS_ACCESS_KEY_ID"),
                           aws_secret_access_key = Sys.getenv("AWS_SECRET_ACCESS_KEY"),
                           region = Sys.getenv("AWS_REGION", "ca-central-1")) {

  chk::chk_string(bucket_name)
  chk::chk_whole_number(max_request_size)
  chk::chk_gt(max_request_size, value = 0)
  chk::chk_string(pattern)
  chk::chk_string(aws_access_key_id)
  chk::chk_string(aws_secret_access_key)
  chk::chk_string(region)

  input_max_request <- max_request_size
  start_after <- ""
  all_keys <- c()
  s3 <- paws::s3(config = list(
    credentials = list(creds = list(
      access_key_id = aws_access_key_id,
      secret_access_key = aws_secret_access_key
    )),
    region = region
  ))


  while (max_request_size > 0) {
    key_list <- s3$list_objects_v2(
      Bucket = bucket_name,
      MaxKeys = max_request_size,
      StartAfter = start_after
    )
    key_names <- vapply(key_list$Contents, function(x) {
      x$Key
    }, "")
    all_keys <- c(all_keys, key_names)
    start_after <- key_names[length(key_names)]
    max_request_size <- max_request_size - 1000
  }

  if (!silent) {
    no_all_keys <- length(all_keys)
    msg <- paste(no_all_keys, "files were retrieved from AWS")
    usethis::ui_info(msg)

    if (input_max_request == no_all_keys) {
      usethis::ui_warn("{usethis::ui_path('Max_request_size')} matches retrieved files from AWS. Think about increasing {usethis::ui_path('Max_request_size')} as there could be more files present")
    }
  }

  filter_files <- grep(pattern, all_keys, value = TRUE)

  if (!silent) {
    msg <- paste(length(filter_files), "files returned after {usethis::ui_path('pattern')}  is applied")
    usethis::ui_info(msg)
  }

  filter_files
}
