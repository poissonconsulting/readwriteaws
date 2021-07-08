#' Parameters for readwriteaws functions
#'
#' Descriptions of the parameters for readwriteaws functions
#'
#' @keywords internal
#' @name params
#'
#' @param bucket_name A string of the name of the AWS s3 bucket you are trying to access
#'
#' @param pattern A character string containing a regular expression to be matched in the given character vector
#' @param max_request_size An integer indicating the maximum request size sent to AWS API
#' @param silent A flag to turn on and off messages about number of files returned
#'
#' @param year A whole number for what years you want returned. Format YYYY
#' @param month A while number for what month you want returned. Format MM
#' @param day A whole number value for what day you want returned. Format DD
#' @param data_type A string for which data you want to return. Options currently include punch-data, tracks, logger, image and pdf.
#'
#' @param file_extension A character string for which file extension you want without the period
#' @param file_name A character string for which file names you want
#'
#' @param file_list A character vector containing a list of files from the object names in AWS
#' @param directory A string that names the folder you want to save the objects into.
#' @param ask A flag that turns on and off whether you want to be asked about overwriting files. If set to TRUE you will be asked before proceeding if the directory given is not empty.
#'
#' @param bucket_path A character string for adding a different folder to where the files are saved in your bucket. Default it "" which means it saves in the directory given by file_list and directory.
#'
#' @param aws_access_key_id
#' @param aws_secret_access_key
#' @param region
NULL
