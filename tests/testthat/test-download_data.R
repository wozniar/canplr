test_that("Download works", {
  dir <- withr::local_tempdir()
  download_data(
    Sys.getenv("drive_email"),
    Sys.getenv("drive_url"),
    dir
  )
  n_files <- length(list.files(dir))
  expect_gte(n_files, 16)
})
