#' List Shiny Upload Files in an AWS S3 Bucket
#'
#' Wrapper function to `rwa_list_files` to simplify accessing files uploaded
#' through Shiny apps.
#' @inheritParams params
#'
#' @return Character vector of files names.
#'
#' @examples
#' \dontrun{
#' # Getting all the objects related to punch data
#' rwa_list_su_files(bucket_name = "purple-lake-poissonconsulting")
#'
#' # Get only punch data from 2021
#' rwa_list_su_files(bucket_name = "purple-lake-poissonconsulting",
#'                   year = 2021)
#'
#' # Get only the csv files
#' rwa_list_su_files(bucket_name = "purple-lake-poissonconsulting",
#'                   extension = "csv")
#'
#' # Combine to only get excel files submitted in 2021
#' rwa_list_su_files(bucket_name = "purple-lake-poissonconsulting",
#'                   extension = "xlsx", year = 2021)
#' }
#' @export
rwa_list_su_files <- function(bucket_name,
                              data_type = NULL,
                              year = NULL,
                              month = NULL,
                              day = NULL,
                              file_name = NULL,
                              file_extension = NULL,
                              max_request_size = 1000,
                              silent = FALSE,
                              aws_access_key_id = Sys.getenv("AWS_ACCESS_KEY_ID"),
                              aws_secret_access_key = Sys.getenv("AWS_SECRET_ACCESS_KEY"),
                              region = Sys.getenv("AWS_REGION", "ca-central-1")) {
  chk::chk_null_or(data_type, chk::chk_string)
  chk::chk_null_or(year, chk::chk_whole_number)
  chk::chk_range(year, range = c(1900, 2100))
  chk::chk_null_or(month, chk::chk_whole_number)
  chk::chk_range(month, range = c(1, 12))
  chk::chk_null_or(day, chk::chk_whole_number)
  chk::chk_range(day, range = c(1, 31))
  chk::chk_null_or(file_name, chk::chk_string)
  chk::chk_null_or(file_extension, chk::chk_string)
  chk::chk_whole_number(max_request_size)
  chk::chk_gt(max_request_size, value = 0)
  chk::chk_string(aws_access_key_id)
  chk::chk_string(aws_secret_access_key)
  chk::chk_string(region)

  year <- year %||% "\\d{4,4}"
  month <- month %||% "\\d{2,2}"
  day <- day %||% "\\d{2,2}"

  day <- pad_dates(day)
  month <- pad_dates(month)

  date <- paste(year, month, day, sep = "-")
  regex_pattern <- paste(data_type,
    date,
    file_name,
    file_extension,
    sep = ".*"
  )
  file_list <- rwa_list_files(bucket_name,
    pattern = regex_pattern,
    max_request_size = max_request_size,
    silent = silent,
    aws_access_key_id = aws_access_key_id,
    aws_secret_access_key = aws_secret_access_key,
    region = region
  )
}
