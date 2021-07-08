#' Upload Files from your Local Drive to AWS
#'
#' Upload files from your local drive to an AWS s3 Bucket
#' @inheritParams params
#'
#' @export
#'
rwa_upload_files <- function(file_list,
                             directory,
                             bucket_name,
                             bucket_path = "") {

  chk::chk_character(file_list)
  # chk::chk_dir(directory)
  ### should it be chk_dir
  # chk::chk_character(directory)
  chk::chk_string(bucket_name)
  chk::chk_string(bucket_path)

  for (file in file_list) {

    local_path <- paste0(directory, "/", file)

    print(local_path)
    print("--------")

    key_path <- paste0(bucket_path, "/", local_path)

    print(key_path)

    s3_bucket <- paws::s3()
    s3_bucket$put_object(Body = local_path, ## this is the local file path
                         Bucket = bucket_name,
                         ## where it goes in AWS
                         Key = key_path)
  }
}
