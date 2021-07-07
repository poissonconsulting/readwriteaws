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
#' @param max_request_size An integer indicating the maximum request size sent to AWS API
#' @param silent A logical flag to turn on and off messages about number of files returned
#'
#' @param year A numeric value for what years you want returned. Format YYYY
#' @param month A numeric value for what month you want returned. Format MM
#' @param day A numeric value for what day you want returned. Format DD
#' @param data_type A character string for which data you want to return. Options currently include punch-data, tracks, logger, image and pdf.
#'
#' @param file_extension A character string for which file extension you want without the period
#' @param file_name A character string for which file names you want
#'
#' @param file_list A vector containing a list of files from the object names in AWS
#' @param directory A string that names the folder you want to save the objects into.
#' @param progress A logical flag to turn on and off the progress bar
NULL
