#' List Files in S3 Bucket
#'
#' Lists all files from s3 bucket
#' @inheritParams params
#'
#' @export
#'
#'
### change back to list
rwa_list_files <- function(bucket_name,
                           year = "",
                           module_name = "",
                           file_type = "") {
  chk::chk_string(bucket_name)
  chk::chk_string(year)
  chk::chk_string(module_name)

  chk::chk_string(file_type)

  s3 <- paws::s3()
  file_list <- s3$list_objects_v2(Bucket = bucket_name)

  key_names <- lapply(file_list$Contents, function(x) {x$Key})
  key_names <- unlist(key_names)
  key_names
}
