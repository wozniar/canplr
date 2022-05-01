download_data <- function() {
  drive_auth(email = Sys.getenv("drive_email"))
  main_folder <- drive_ls(Sys.getenv("drive_url"))
  data_folders_urls <- paste0("https://drive.google.com/drive/folders/", main_folder$id[str_detect(main_folder$name, "Season")])
  data_files <- map(data_folders_urls, drive_ls) |> 
    bind_rows() |> 
    filter(str_detect(name, "csv")) |> 
    mutate(
      file = paste0("https://drive.google.com/file/d/", id),
      path = paste0("data/", name),
      overwrite = TRUE
    ) |> 
    select(file, path, overwrite)
  pwalk(data_files, drive_download)
}

