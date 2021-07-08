#' Upload Files from your Local Drive to AWS
#'
#' Upload files from your local drive to an AWS s3 Bucket
#' @inheritParams params
#'
#' @export
#'
rwa_upload_files <- function(file_list,
                             directory = "",
                             bucket_name,
                             bucket_path = "") {

  chk::chk_character(file_list)
  chk::chk_string(directory)
  chk::chk_string(bucket_name)
  chk::chk_string(bucket_path)

  for (file in file_list) {

    local_path <- file.path(directory, file)
    key_path <- file.path(bucket_path, local_path)

    s3_bucket <- paws::s3()
    s3_bucket$put_object(Body = local_path, ## this is the local file path
                         Bucket = bucket_name,
                         Key = key_path) ## where it goes in AWS
  }
}

