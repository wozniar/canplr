get_metric_definitions <- function(email, url) {
  file <- "Metric Definitions.xlsx"
  if (!(file.exists(file))) {
    message("Downloading metric defitions")
    drive_auth(email = email)
    drive_download(url)
    drive_deauth()
  }
  read_excel(file)
}