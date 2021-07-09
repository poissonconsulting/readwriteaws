#' Upload Files from your Local Drive to AWS
#'
#' Upload files from your local drive to an AWS s3 Bucket
#' @inheritParams params
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

