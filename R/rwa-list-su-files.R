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
#' # Get a list of all the files in the bucket
#' rwa_list_su_files(bucket_name = "purple-lake-poissonconsulting")
#'
#' # Get a list of all files from 2021
#' rwa_list_su_files(bucket_name = "purple-lake-poissonconsulting",
#'                   year = 2021)
#'
#' # Get a list of all the csv files
#' rwa_list_su_files(bucket_name = "purple-lake-poissonconsulting",
#'                   extension = "csv")
#'
#' # Get a list of excel files from 2021
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
  chk::chk_null_or(data_type, vld = chk::vld_string)
  chk::chk_null_or(year, vld = chk::vld_whole_number)
  chk::chk_range(year, range = c(1900, 2100))
  chk::chk_null_or(month, vld = chk::vld_whole_number)
  chk::chk_range(month, range = c(1, 12))
  chk::chk_null_or(day, vld = chk::vld_whole_number)
  chk::chk_range(day, range = c(1, 31))
  chk::chk_null_or(file_name, vld = chk::vld_string)
  chk::chk_null_or(file_extension, vld = chk::vld_string)
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
