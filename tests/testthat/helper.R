skip_if_no_credentials <- function() {
  if (Sys.getenv("drive_email") == "" | Sys.getenv("drive_url") == "") {
    skip("Credentials not available")
  }
}
