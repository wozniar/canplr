download_data <- function(email, url) {
  if (!(dir.exists("data/"))) {
    dir.create("data/")
  }
  drive_auth(email = email)
  main_folder <- drive_ls(url, pattern = "Season")
  data_folders_urls <- paste0("https://drive.google.com/drive/folders/", main_folder$id)
  data_files <- map(data_folders_urls, drive_ls, pattern = "csv") |> 
    bind_rows() |> 
    mutate(
      file = paste0("https://drive.google.com/file/d/", id),
      path = paste0("data/", name),
      overwrite = TRUE
    ) |> 
    select(file, path, overwrite)
  pwalk(data_files, drive_download)
  drive_deauth()
}

