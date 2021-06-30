#' Parameters for readwriteaws functions
#'
#' Descriptions of the parameters for readwriteaws functions
#'
#' @keywords internal
#' @name params
#'
#' @param bucket_name A string of the name of the AWS s3 bucket you are trying to access
#' @param year For narrowing scope of search if used in read-files it will need to build itself up
#' @param module_name For scope like tracks, pdf, etc
#' @param file_type Regex later for grabbing what is wanted
#'
#'
#' @param file_names A vector containing a list of files from the object names in AWS
#' @param directory A string that names the folder you want to save the objects into.
NULL
