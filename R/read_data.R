read_player_by_game <- function() {
  readRDS("data/CPLPlayerByGame.rds")
}

read_player_totals <- function() {
  readRDS("data/CPLPlayerTotals.rds")
}

read_team_by_game <- function() {
  readRDS("data/CPLTeamByGame.rds")
}

read_team_totals <- function() {
  readRDS("data/CPLTeamTotals.rds")
}