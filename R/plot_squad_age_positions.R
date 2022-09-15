plot_squad_age_positions <- function(team_name, season) {
  df_age <- player_by_game |>
    filter(teamName == team_name & year == season) |>
    group_by(playerId, Player) |>
    summarise(
      Age = max(Age)
    ) |>
    ungroup() |>
    filter(!(is.na(Age)) & Age > 0)

  df_position <- player_by_game |>
    filter(teamName == team_name & year == season) |>
    group_by(playerId, Position) |>
    summarise(
      Min = sum(Min)
    ) |>
    group_by(playerId) |>
    slice_max(order_by = Min, n = 1, with_ties = FALSE) |>
    ungroup() |>
    select(playerId, Position)

  df <- df_age |>
    left_join(df_position, by = "playerId") |>
    get_positions_codes(Position)

  peak_ages <- get_peak_ages() |>
    filter(position_code %in% df$position_code) |>
    mutate(position_code = fct_drop(position_code))

  df <- df |>
    left_join(peak_ages) |>
    mutate(
      dist = Age - peak_age,
      label = NA
    )
  
  first_player <- df |> 
    filter(position_code == "GK") |> 
    slice_max(order_by = Age, n = 1) |>
    slice_min(order_by = Player, n = 1, with_ties = FALSE) |> 
    pull(playerId)
  
  df$label[df$playerId == first_player] <- "Peak Age"

  peak_age_dist <- round(mean(df$dist), 1)
  
  levels <- df |> 
    arrange(desc(Age), Player) |> 
    pull(Player)

  plot <- ggplot(df) +
    facet_grid(rows = vars(position_code), scales = "free_y", space = "free_y") +
    geom_rect(data = peak_ages, aes(x = NULL, y = NULL, xmin = peak_age_min, xmax = peak_age_max), ymin = -Inf, ymax = Inf, alpha = 0.25, fill = league_colours[3]) +
    geom_point(aes(x = Age, y = fct_rev(factor(Player, levels = levels))), colour = team_colours[[team_name]][2], fill = team_colours[[team_name]][1], shape = 21, size = 6 / .pt, stroke = 1 / .pt) +
    geom_text(aes(y = fct_rev(factor(Player, levels = levels)), label = label), x = 28, vjust = -1.25, family = "Oswald", color = league_colours[2], size = 30 / .pt) +
    coord_cartesian(clip = "off") +
    scale_x_continuous(
      breaks = seq.int(from = 16, to = 40, by = 2),
      labels = seq.int(from = 16, to = 40, by = 2),
      limits = c(
        min(c(16, min(df$Age))),
        max(c(40, max(df$Age)))
      )
    ) +
    labs(
      title = team_name,
        paste(team_name, season, "season age profile"),
      subtitle = paste("Age profile and depth |", season, "season | Squad years from peak age:", peak_age_dist),
      x = "Age",
      y = NULL,
      caption = caption,
      tag = tag
    ) +
    theme_canpl()
  
  path <- paste0("plots/", team_name, "_", season, "_season_squad_age_positions.png")
  ggsave(path, plot, width = 2048, height = 2048, units = "px")
  add_logos(path, team_image_id)
}