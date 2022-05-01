read_data <- function() {
  files <- list.files("data/", full.names = TRUE)
  data <- map(files, read_csv)
  names(data) <- str_remove(list.files("data/"), ".csv")
  return(data)
}