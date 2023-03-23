test_that("Data is read", {
  skip_if_no_credentials()
  dir <- withr::local_tempdir()
  download_data(
    Sys.getenv("drive_email"),
    Sys.getenv("drive_url"),
    dir
  )
  data <- read_data(dir)
  expect_gte(length(data), 16)
})
