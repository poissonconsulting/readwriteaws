#' Parameters for readwriteaws functions
#'
#' Descriptions of the parameters for readwriteaws functions
#'
#' @keywords internal
#' @name params
#'
#' @param bucket_name A character string of the name of the AWS s3 bucket you are trying to access
#'
#' @param pattern A character string containing a regular expression to be matched in the given character vector
#'
#' @param year Regex filter param
#' @param module_name Regex filter param
#' @param file_type Regex filter param
#' @param date Regex filter param format YYYY-MM-DD
#' @param file_extension Regex filter param (think this is better then file_type)
#' @param file_name Regex filter param
#'
#'
#' @param file_names A vector containing a list of files from the object names in AWS
#' @param directory A string that names the folder you want to save the objects into.
NULL
