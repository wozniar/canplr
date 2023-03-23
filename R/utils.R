check_if_dir_exists <- function(dir) {
  if (dir.exists(dir) == FALSE) {
    stop(dir, " doesn't exist.
         Choose an existing directory or use download_data().")
  }
}
