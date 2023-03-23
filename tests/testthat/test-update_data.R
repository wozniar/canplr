test_that("Download works", {
  skip_if_no_credentials()
  dir <- withr::local_tempdir()
  expect_error(
    update_data(
      Sys.getenv("drive_email"),
      Sys.getenv("drive_url"),
      dir
    )
  )
})
