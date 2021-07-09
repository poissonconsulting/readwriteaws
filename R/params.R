#' Parameters for readwriteaws functions
#'
#' Descriptions of the parameters for readwriteaws functions
#'
#' @keywords internal
#' @name params
#'
#' @param bucket_name A string of the AWS S3 bucket name.
#'
#' @param pattern A string containing a regular expression.
#' @param max_request_size A whole number (by default `1000`) indicating the
#'   maximum number of files to be returned.
#' @param silent A flag (by default `FALSE`) to toggle messages about number of
#'   files returned on and off. Set to `TRUE` to silence messages.
#'
#' @param data_type A string (by default `NULL`) for which data type to return.
#'   Options currently include punch-data, tracks, logger, image and pdf.
#' @param year A whole number (by default `NULL`) indicating which year is
#'   returned. Format YYYY.
#' @param month A whole number (by default `NULL`) indicating which month is
#'   returned. Format MM.
#' @param day A whole number (by default `NULL`) indicating which day is
#'   returned. Format DD.
#' @param file_name A string (by default `NULL`) containing the name of the file
#'   to be returned. Do not include extension type.
#' @param file_extension A string (by default `NULL`) for which file extension
#'   to return. Do not include period in front of extension.
#'
#' @param file_list A character vector containing a list of files.
#'
#' @param ask A flag (by default `TRUE`) to toggle on and off being asked about
#'   potentially overwriting files present in the directory argument. Set to
#'   `FALSE` to not be asked.
#'
#' @param bucket_path A string (by default `""`) to prefix the file path in the
#'   bucket. This allows you to place files in a different folder in the bucket
#'   then locally. If the default is used the file structure will be identical
#'   to the `file_list` passed.
#'
#' @param aws_access_key_id A string of your AWS user access key id from AWS.
#'   The default is the system environment variable of `AWS_ACCESS_KEY_ID`.
#' @param aws_secret_access_key A string of your AWS user secret access key from
#'   AWS. The default is the system environment variable of
#'   `AWS_SECRET_ACCESS_KEY`.
#' @param region A string of the AWS region you are working within. The default
#'   is the system environment variable of `AWS_REGION`
NULL
