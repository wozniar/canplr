read_data <- function() {
  files <- paste0("data/", list.files("data/"))
  data <- map(files, read_csv)
  names(data) <- str_remove(list.files("data/"), ".csv")
  return(data)
}