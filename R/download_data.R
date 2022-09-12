download_data <- function(email, url) {
  if (!(dir.exists("data_raw/"))) {
    dir.create("data_raw/")
  }
  drive_auth(email = email)
  main_folder <- drive_ls(url, pattern = "Season")
  data_folders_urls <- paste0("https://drive.google.com/drive/folders/", main_folder$id)
  data_files <- map(data_folders_urls, drive_ls, pattern = "csv") |>
    bind_rows() |>
    drive_reveal("modified_time") |>
    mutate(
      file = paste0("https://drive.google.com/file/d/", id),
      path = paste0("data_raw/", name),
      overwrite = TRUE
    ) |>
    select(file, path, overwrite)
  message(paste0("Files to download: "), nrow(data_files))
  pwalk(data_files, drive_download)
  drive_deauth()
  clean_data()
}

update_data <- function(email, url) {
  drive_auth(email = email)
  main_folder <- drive_ls(url, pattern = "Season")
  data_folders_urls <- paste0("https://drive.google.com/drive/folders/", main_folder$id)
  data_files <- map(data_folders_urls, drive_ls, pattern = "csv") |>
    bind_rows() |>
    drive_reveal("modified_time") |>
    mutate(
      file = paste0("https://drive.google.com/file/d/", id),
      path = paste0("data_raw/", name),
      overwrite = TRUE,
      local_modified_time = with_tz(file.info(paste0("data_raw/", name))$mtime, tzone = "UTC")
    ) |>
    filter(modified_time > local_modified_time) |>
    select(file, path, overwrite)
  to_update <- nrow(data_files)
  message(paste0("Files to update: "), to_update)
  pwalk(data_files, drive_download)
  drive_deauth()
  if (to_update > 0) {
    clean_data()
  }
}
