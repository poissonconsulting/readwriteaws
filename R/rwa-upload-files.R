#' Upload Files from your Local Drive to AWS
#'
#' Upload files from your local drive to an AWS S3 bucket
#' @inheritParams params
#' @param directory A string (by default `"."`) indicating the directory where
#'   the files are locally located.
#'
#' @details The directory argument can take either relative or absolute file
#'   paths. The directory and `file_list` argument are designed to be used
#'   together. The `file_list` argument can be used without the directory
#'   argument if required.
#'
#'   The `bucket_path` argument makes it possible to place files in a different
#'   folder path in the bucket then locally. The `bucket_path` argument is
#'   appended to the `file_list`.
#'
#'   The `directory` argument is not included in the file path of the files in
#'   the bucket.
#'
#' @export
#'
rwa_upload_files <- function(file_list,
                             directory = ".",
                             bucket_name,
                             bucket_path = "",
                             aws_access_key_id = Sys.getenv("AWS_ACCESS_KEY_ID"),
                             aws_secret_access_key = Sys.getenv("AWS_SECRET_ACCESS_KEY"),
                             region = Sys.getenv("AWS_REGION", "ca-central-1")) {

  chk::chk_character(file_list)
  chk::chk_null_or(directory, chk::chk_dir)
  chk::chk_string(bucket_name)
  chk::chk_string(bucket_path)
  chk::chk_string(aws_access_key_id)
  chk::chk_string(aws_secret_access_key)
  chk::chk_string(region)

  s3 <- paws::s3(config = list(
    credentials = list(creds = list(
      access_key_id = aws_access_key_id,
      secret_access_key = aws_secret_access_key
    )),
    region = region
  ))

  for (file in file_list) {

    local_path <- paste0(directory, "/", file)
    key_path <- file.path(bucket_path, file)

    s3$put_object(Body = local_path, ## this is the local file path
                  Bucket = bucket_name,
                  Key = key_path) ## where it goes in AWS
  }
}

