#' List Punch Data Files from s3 Bucket
#'
#' Lists only punch data files
#' @inheritParams params
#'
#' @return Vector of object names that match the filter criteria
#'
#' @examples
#' \dontrun{
#' # Getting all the objects related to punch data
#' rwa_get_data(bucket_name = "my_bucket")
#'
#' # Get only punch data from 2021
#' rwa_get_data(bucket_name = "my_bucket", year = "2021")
#'
#' # Get only the csv files
#' rwa_get_data(bucket_name = "my_bucket", extension = "csv")
#'
#' # Get only data submitted on June 25, 2021
#' rwa_get_data(bucket_name = "my_bucket", date = "2021-06-25")
#'
#' # Combine to only get excel files submitted in 2021
#' rwa_get_data(bucket_name = "my_bucket", extension = "xlsx", year = "2021")
#' }
#' @export
rwa_get_data <- function(bucket_name,
                         data_type = NULL,
                         year = NULL,
                         month = NULL,
                         day = NULL,
                         file_name = NULL,
                         file_extension = NULL,
                         max_request_size = 1000) {

  chk::chk_null_or(data_type, chk::chk_string)
  chk::chk_null_or(year, chk::chk_string)
  chk::chk_null_or(month, chk::chk_string)
  chk::chk_null_or(day, chk::chk_string)
  chk::chk_null_or(file_name, chk::chk_string)
  chk::chk_null_or(file_extension, chk::chk_string)
  chk::chk_whole_number(max_request_size)
  chk::chk_gt(max_request_size, value = 0)

  ### need to deal with 01 vs 1

  year <- year %||% "\\d{4,4}"
  month <- month %||% "\\d{2,2}"
  day <- day %||% "\\d{2,2}"

  date <- paste(year, month, day, sep = "-")
  regex_pattern <- paste(data_type,
                         date,
                         file_name,
                         file_extension,
                         sep = ".*")
  file_list <- rwa_list_files(bucket_name,
                              pattern = regex_pattern,
                              max_request_size = max_request_size)
}
