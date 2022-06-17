read_data <- function(data) {
  files <- list.files("data/", pattern = data, full.names = TRUE)
  list <- map(files, read_csv)
  names(list) <- str_extract(files, "\\d+")
  return(list)
}

read_player_by_game <- function() {
  read_data("CPLPlayerByGame") |> 
    bind_rows(.id = "season") |> 
    mutate(season = as.numeric(season)) |> 
    distinct_cols()
}

read_player_totals <- function() {
  read_data("CPLPlayerTotals") |> 
    bind_rows(.id = "season") |> 
    mutate(season = as.numeric(season)) |> 
    distinct_cols()
}

read_team_by_game <- function() {
  read_data("CPLTeamByGame") |> 
    map(~ .x |> mutate(xGPerShot = as.numeric(xGPerShot))) |>
    map(~ .x |> mutate(Date = as.Date(Date, tryFormats = c("%Y-%m-%d", "%m/%d/%Y")))) |>
    bind_rows(.id = "season") |> 
    mutate(season = as.numeric(season)) |> 
    distinct_cols()
}

read_team_totals <- function() {
  read_data("CPLTeamTotals") |> 
    bind_rows(.id = "season") |>
    mutate(season = as.numeric(season)) |> 
    distinct_cols()
}