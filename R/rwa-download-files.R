#' Download Files from AWS to Local Drive
#'
#' Copies files from your AWS s3 bucket to your local drive
#' @inheritParams params
#'
#' @export
#'
rwa_download_files <- function(file_list,
                               directory,
                               bucket_name,
                               silent = FALSE,
                               ask = TRUE) {

  chk::chk_character(file_list)
  chk::chk_dir(directory)
  chk::chk_string(bucket_name)
  chk::chk_flag(silent)
  chk::chk_flag(ask)

  if(ask_to_overwrite(directory, ask)) {

    if (!silent) {
      pb <- progress::progress_bar$new(total = length(file_list))
      pb$tick(0)
    }

    for (file in file_list) {
      if (!silent) {
        pb$tick()
      }

      save_location <- paste0(directory, "/", file)
      aws.s3::save_object(
        object = file,
        bucket = bucket_name,
        file = save_location
      )
    }
  }
}
