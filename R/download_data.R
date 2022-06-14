list_data_files <- function(email, url) {
  main_folder <- drive_ls(url, pattern = "Season")
  data_folders_urls <- paste0("https://drive.google.com/drive/folders/", main_folder$id)
  data_files <- map(data_folders_urls, drive_ls, pattern = "csv") |> 
    bind_rows()
}

download_data <- function(email, url) {
  if (!(dir.exists("data/"))) {
    dir.create("data/")
  }
  drive_auth(email = email)
  data_files <- list_data_files(email, url) |> 
    mutate(
      file = paste0("https://drive.google.com/file/d/", id),
      path = paste0("data/", name),
      overwrite = TRUE
    ) |> 
    select(file, path, overwrite)
  pwalk(data_files, drive_download)
  drive_deauth()
  data_files <- list_data_files(email, url) |> 
    drive_reveal("modified_time") |>
    select(id, modified_time)
  saveRDS(data_files, "data/data_files.rds")
}

update_data <- function(email, url) {
  data_files_old <- readRDS("data/data_files.rds")
  drive_auth(email = email)
  data_files_new <- list_data_files(email, url) |> 
    drive_reveal("modifiedTime") |> 
    left_join(data_files_old, by = "id") |> 
    filter(modified_time.x != modified_time.y) |> 
    mutate(
      file = paste0("https://drive.google.com/file/d/", id),
      path = paste0("data/", name),
      overwrite = TRUE
    ) |> 
    select(file, path, overwrite)
  message(paste0("Files to update: "), nrow(data_files_new))
  pwalk(data_files_new, drive_download)
  drive_deauth()
  data_files <- list_data_files(email, url) |> 
    drive_reveal("modified_time") |>
    select(id, modified_time)
  saveRDS(data_files, "data/data_files.rds")
}