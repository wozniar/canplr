#' Download Canadian Premier League Centre Circle Data
#'
#' @param email E-mail associated with Google account.
#' @param url Link to the Centre Circle Data Google Drive folder.
#' @param dir Folder in which the data will be saved.
#'
#' @return CSV files saved in given directory.
#' @export
#'
#' @examples
#' \dontrun{
#' download_data(
#'   "first.last@example.com",
#'   "https://drive.google.com/drive/folders/abc123",
#'   "~/cpl_data/"
#' )
#' }
download_data <- function(email, url, dir) {
  if (dir.exists(dir) == FALSE) {
    dir.create(dir)
  }
  googledrive::drive_auth(email = email)
  main_folder <- googledrive::drive_ls(url, pattern = "Season")
  data_folders_urls <- paste0(
    "https://drive.google.com/drive/folders/",
    main_folder$id
  )
  data_files <- purrr::map_df(data_folders_urls, googledrive::drive_ls,
    pattern = "csv"
  ) |>
    dplyr::mutate(
      file = paste0("https://drive.google.com/file/d/", id),
      path = paste0(dir, "/", name),
      overwrite = TRUE
    ) |>
    dplyr::select(file, path, overwrite)
  message("Downloading data...")
  purrr::pwalk(data_files, googledrive::drive_download, .progress = TRUE)
  message("Data downloaded successfully.")
  googledrive::drive_deauth()
}

#' Update Canadian Premier League Centre Circle Data
#'
#' @param email E-mail associated with Google account.
#' @param url Link to the Centre Circle Data Google Drive folder.
#' @param dir Folder containing the data.
#'
#' @return CSV files saved in given directory.
#' @export
#'
#' @examples
#' #'
#' \dontrun{
#' update_data(
#'   "first.last@example.com",
#'   "https://drive.google.com/drive/folders/abc123",
#'   "~/cpl_data/"
#' )
#' }
update_data <- function(email, url, dir) {
  if (dir.exists(dir) == FALSE) {
    stop(paste0(dir, " doesn't exist.
                Choose an existing directory or use download_data()."),
      call. = FALSE
    )
  }
  googledrive::drive_auth(email = email)
  main_folder <- googledrive::drive_ls(url, pattern = "Season")
  data_folders_urls <- paste0(
    "https://drive.google.com/drive/folders/",
    main_folder$id
  )
  data_files <- purrr::map_df(data_folders_urls, googledrive::drive_ls,
    pattern = "csv"
  ) |>
    googledrive::drive_reveal("modified_time") |>
    dplyr::mutate(
      file = paste0("https://drive.google.com/file/d/", id),
      path = paste0(dir, "/", name),
      overwrite = TRUE,
      local_modified_time = lubridate::with_tz(
        file.info(paste0(dir, "/", name))$mtime,
        tzone = "UTC"
      )
    )
  if (any(is.na(data_files$local_modified_time))) {
    stop("Some files are missing. Use download_data() instead.")
  }
  data_files <- data_files |>
    dplyr::filter(modified_time > local_modified_time) |>
    dplyr::select(file, path, overwrite)
  to_update <- nrow(data_files)
  if (to_update > 0) {
    message(paste0("Files to update: "), to_update)
  } else {
    message("All files are up-to-date.")
  }
  purrr::pwalk(data_files, googledrive::drive_download, .progress = TRUE)
  googledrive::drive_deauth()
}
