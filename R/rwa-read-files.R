#' List Files in S3 Bucket
#'
#' Lists all files from s3 bucket
#' @inheritParams params
#'
#' @export
#'
rwa_read_files <- function(bucket_name,
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
  number_of_files <- length(key_names)

  usethis::ui_info(glue::glue("There are {number_of_files} files in {bucket_name}. If
                              over 1000 then you need to narrow the query."))

  ### think this will need to return a list where the first item is total number of
  ### files
  ### then the "wrapper" functions can test against it and resend a request without
  ### the user knowing - so when get_tracks  is called if the base call is over
  ### 1000 then it will ignore a bunch of other files until the request works
  ### the user won't know on the front end the search was narrowed just in case

  key_names
}


