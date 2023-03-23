skip_if_no_credentials <- function() {
  if (Sys.getenv("drive_email") == "" || Sys.getenv("drive_url") == "") {
    testthat::skip("Credentials not available")
  }
}
