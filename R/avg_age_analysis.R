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

# Analysis ----

mean_age <- player_by_game |> 
  group_by(year) |> 
  summarise(
    mean_age = weighted.mean(Age, Min, na.rm = TRUE)
  )

plot <- ggplot(mean_age) +
  geom_line(aes(year, mean_age), colour = league_colours[2], size = 5 / .pt) +
  geom_point(aes(year, mean_age), colour = league_colours[2], size = 40 / .pt) +
  geom_text(aes(year, mean_age, label = round(mean_age, 1)), colour = league_colours[4], family = "Oswald", size = 30 / .pt) +
  scale_y_continuous(
    limits = c(24, 27)
    ) +
  labs(
    title = "No spadło",
    subtitle = "Average age weighted by minutes played",
    x = "Season",
    y = "Age",
    caption = caption,
    tag = tag
  ) +
  theme_canpl(base_size = 30)

path <- "plots/mean_age.png"
ggsave(path, plot, width = 2048, height = 2048, units = "px")
add_logos(path)

team_mean_age <- player_by_game |> 
  group_by(year, Team) |> 
  summarise(
    mean_age = weighted.mean(Age, Min, na.rm = TRUE)
  ) |> 
  mutate(
    Team = ifelse(Team == "Atlético Ottawa", "Atlético Ottawa (entered CPL in 2020)", Team)
  )

plot <- ggplot() +
  geom_line(data = mean_age, aes(year, mean_age), colour = league_colours[3]) +
  geom_line(data = team_mean_age, aes(year, mean_age), colour = league_colours[2]) +
  scale_y_continuous(limits = c(23.25, 27.75)) +
  labs(
    title = "xxx",
    subtitle = "xxx",
    x = "Season",
    y = "Age",
    caption = caption,
    tag = tag
  ) +
  facet_wrap(vars(Team)) +
  theme_canpl()

path <- "plots/mean_age_teams.png"
ggsave(path, plot, width = 2048, height = 2048, units = "px")
add_logos(path)

pos_mean_age <- player_by_game |> 
  get_positions_codes(Position) |> 
  group_by(year, position_code) |> 
  summarise(
    mean_age = weighted.mean(Age, Min, na.rm = TRUE)
  )

plot <- ggplot() +
  geom_line(data = mean_age, aes(year, mean_age), colour = league_colours[3]) +
  geom_line(data = pos_mean_age, aes(year, mean_age), colour = league_colours[2]) +
  scale_y_continuous(limits = c(NA, NA)) +
  labs(
    title = "xxx",
    subtitle = "xxx",
    x = "Season",
    y = "Age",
    caption = caption,
    tag = tag
  ) +
  facet_wrap(vars(position_code)) +
  theme_canpl()

path <- "plots/mean_age_positions.png"
ggsave(path, plot, width = 2048, height = 2048, units = "px")
add_logos(path)
