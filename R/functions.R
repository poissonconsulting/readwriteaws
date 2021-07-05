
number_of_files <- function(bucket_name) {
  chk::chk_string(bucket_name)

  s3 <- paws::s3()
  file_list <- s3$list_objects_v2(Bucket = bucket_name)
  file_count <- length(file_list$Contents)
  file_count
}

`%||%` <- function(x, y) if (is.null(x) || length(x) == 0) y else x





# bucket_name <- "shinybugtest-poissonconsulting"
# x <- rwa_list_files(bucket_name)
#
# x[1]
#
# z <- s3$get_object(
#   Bucket = bucket_name,
#   Key = x[1]
# )
#
#
#
# s3 <- paws::s3()
# file_list <- s3$list_objects_v2(Bucket = bucket_name)
#
#
# aws.s3::save_object(object = x[1],
#                     bucket = bucket_name,
#                     file = "inst/downloads/shiny-upload/image/2021-06-25_12-40-29_test_90083bea021aa25d6388d16de90d25d4/input_data.csv",
#                     check_region = F)
#
# aws.s3::save_object(object = x[2],
#                     bucket = bucket_name,
#                     file = "inst/downloads/shiny-upload/image/2021-06-25_12-40-29_test_90083bea021aa25d6388d16de90d25d4/uploaded_file.jpeg")
#
#
#
# key_name <- z$Contents
# for (i in 1:length(key_name)) {
#   print(key_name[[i]]$Key)
# }
#
# key_names <- lapply(file_list$Contents, function(x) {x$Key})
#
# unlist(key_names)
#
#
#
# #### Playing ####
#
# bucket_name <- "shinybugtest-poissonconsulting"
#
# s3 <- paws::s3()
#
# z <- s3$list_objects_v2(Bucket = bucket_name,
#                         Prefix = "shiny-upload/pdf/2021")
#
# key_name <- z$Contents
# for (i in 1:length(key_name)) {
#   print(key_name[[i]]$Key)
# }
#
# ### will need to build the path from base structure
#
# z <- s3$list_objects_v2(Bucket = bucket_name,
#                         Delimiter = ".csv")
#
# key_name <- z$Contents
# for (i in 1:length(key_name)) {
#   print(key_name[[i]]$Key)
# }
# ### deliminter essentially is what you ignore
#
#
#
# z <- s3$list_objects_v2(Bucket = bucket_name,
#                         StartAfter = "shiny-upload/tracks")
#
# key_name <- z$Contents
# vec <- list()
# for (i in 1:length(key_name)) {
#   vec[[i]] <- append(vec, key_name$Key)
#   print(key_name[[i]]$Key)
# }
# length(vec)
# ### StartAfter list after a certain key based on alphabetical order
