#' Save Files to Local Drive
#'
#' Takes a vector of file names and saves them into that directory.
#' @inheritParams params
#'
#' @export
#'
rwa_write_files <- function(file_list, directory, bucket_name) {
  chk::chk_vector(file_list)
  chk::chk_string(directory)

  pb <- progress::progress_bar$new(total = length(file_list))

  pb$tick(0)
  for (file in file_list) {
    pb$tick()
    save_location <- paste0(directory, "/", file)
    aws.s3::save_object(
      object = file,
      bucket = bucket_name,
      file = save_location
    )
  }
}
