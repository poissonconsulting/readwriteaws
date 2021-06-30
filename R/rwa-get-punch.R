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
#' rwa_get_punch(bucket_name = "my_bucket")
#'
#' # Get only punch data from 2021
#' rwa_get_punch(bucket_name = "my_bucket", year = "2021")
#'
#' # Get only the csv files
#' rwa_get_punch(bucket_name = "my_bucket", extension = "csv")
#'
#' # Get only data submitted on June 25, 2021
#' rwa_get_punch(bucket_name = "my_bucket", date = "2021-06-25")
#'
#' # Combine to only get excel files submitted in 2021
#' rwa_get_punch(bucket_name = "my_bucket", extension = "xlsx", year = "2021")
#' }
#' @export
rwa_get_punch <- function(bucket_name, year = NULL,
                          date = NULL,
                          file_extension = NULL,
                          file_name = NULL) {

  chk::chk_null_or(year, chk::chk_string)
  chk::chk_null_or(date, chk::chk_string)
  chk::chk_null_or(file_extension, chk::chk_string)
  chk::chk_null_or(file_name, chk::chk_string)

  if(!is.null(year) & !is.null(date)){
    stop("Only year or date can be supplied not both")
  }

  file_list <- rwa_read_files(bucket_name)
  regex_pattern <- paste("punch-data",
                         year,
                         date,
                         file_extension,
                         file_name,
                         sep = ".*"
                        )
  grep(regex_pattern, file_list, value = TRUE)
}
