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

# Update data ----
update_data(Sys.getenv("drive_email"), Sys.getenv("drive_url"))

# Read data ----
player_by_game <- read_player_by_game()
player_totals <- read_player_totals()
team_by_game <- read_team_by_game()
team_totals <- read_team_totals()

# Plots ----
plot_params <- team_totals |>
  select(team_name = Team, season = year) |>
  distinct()

pwalk(plot_params, plot_squad_age_minutes)
pwalk(plot_params, plot_squad_age_positions)
