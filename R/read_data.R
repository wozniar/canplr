#' Read Canadian Premier League Centre Circle Data
#'
#' @param dir Directory containing the data.
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
  names <- list.files(dir, pattern = "CPL.*csv")
  if (length(files) == 0) {
    stop("Some files are missing. Use download_data() instead.")
  }
  names <- gsub("/", "", names)
  names <- gsub(".csv", "", names)
  data <- purrr::map(files, readr::read_csv,
    show_col_types = FALSE,
    .progress = TRUE
  )
  names(data) <- names
  return(data)
}
