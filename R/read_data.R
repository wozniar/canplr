#' Read Canadian Premier League Centre Circle Data
#'
#' @param dir Folder containing the data.
#'
#' @return A list of data frames.
#' @export
#'
#' @examples
#' \dontrun{
#' cpl_data <- read_data("~/cpl_data/")
#' }
read_data <- function(dir) {
  check_if_dir_exists(dir)
  files <- list.files(dir, pattern = "CPL.*csv", full.names = TRUE)
  if (length(files) == 0) {
    stop("Some files are missing. Use download_data() instead.")
  }
  names <- gsub(dir, "", files)
  names <- gsub("/", "", names)
  names <- gsub(".csv", "", names)
  data <- purrr::map(files, readr::read_csv, .progress = TRUE)
  names(data) <- names
  return(data)
}
