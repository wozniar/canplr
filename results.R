# Load packages ----
library(tidyverse)
library(googledrive)
library(lubridate)
library(ggrepel)
library(scales)
library(showtext)
library(magick)
library(grid)
library(rlang)
library(readxl)

# Load functions ----
functions <- list.files("R/", full.names = TRUE)
walk(functions, source)

# Read data ----
player_by_game <- read_player_by_game()
player_totals <- read_player_totals()
team_by_game <- read_team_by_game()
team_totals <- read_team_totals()
metric_definitions <- get_metric_definitions(Sys.getenv("drive_email"), Sys.getenv("metric_defitions_url"))

results <- team_by_game |>
  group_by(year, Date, Home, teamFullName, opponentFullName) |>
  summarise(
    GoalCncd = sum(GoalCncd)
  ) |>
  mutate(
    home_team = ifelse(Home == TRUE, teamFullName, opponentFullName),
    away_team = ifelse(Home == FALSE, teamFullName, opponentFullName),
    home_goals = ifelse(Home == TRUE, NA, GoalCncd),
    away_goals = ifelse(Home == FALSE, NA, GoalCncd)
  ) |> 
  group_by(year, Date, home_team, away_team) |> 
  summarise(
    across(ends_with("_goals"), ~ sum(.x, na.rm = TRUE))
  ) |> 
  mutate(
    home_pts = ifelse(home_goals > away_goals, 3, ifelse(home_goals == away_goals, 1, 0)),
    away_pts = ifelse(home_goals < away_goals, 3, ifelse(home_goals == away_goals, 1, 0))
  )
