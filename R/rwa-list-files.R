#' List Files in S3 Bucket
#'
#' Lists all files from s3 bucket
#' @inheritParams params
#' @examples
#' \dontrun{
#' # List all files in the bucket
#' rwa_list_files(bucket_name = "my-project-bucket")
#'
#' # Add regex to only list pdfs from June 30th
#' rwa_list_files(bucket_name = "my-project-bucket",
#'                pattern = "pdf.*2021-06-30")
#'
#' # Add regex to only list files from 2021
#' rwa_list_files(bucket_name = "my-project-bucket",
#'                pattern = "2021")
#' }
#' @export
rwa_list_files <- function(bucket_name,
                           ### it can also be NULL not sure whats a better default value
                           ### how does user know if they should increase? print total number returned?
                           max_request_size = 1000,
                           pattern = ".*") {
  chk::chk_string(bucket_name)
  chk::chk_whole_number(max_request_size)
  ?chk::chk_gt(max_request_size, value = 0)
  chk::chk_string(pattern)



  if (max_request_size <= 1000) {
    s3 <- paws::s3()
    key_list <- s3$list_objects_v2(Bucket =  bucket_name, MaxKeys = max_request_size)
  } else {
    while (max_request_size > 0) {
      print(max_request_size)
      max_request_size = max_request_size - 1000
    }
  }


  ### comment out for now
  #key_names <- lapply(key_list$Contents, function(x) {x$Key})
  #key_names <- unlist(key_names)
  #grep(pattern, key_names, value = TRUE)
}


x <- rwa_list_files(bucket_name = "readwriteaws-test-poissonconsulting",
               max_request_size = 1014)



###

i <- 1014
while (i > 0) {
  print(i)
  i = i-1000
}







