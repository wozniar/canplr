plot_squad_age_positions <- function(team_name, season) {
  df_age <- data[[paste0("CPLPlayerByGame", season)]] |>
    filter(teamName == team_name) |>
    group_by(playerId, Player) |>
    summarise(
      Age = max(Age),
      Min = sum(Min)
    ) |>
    ungroup() |>
    filter(!(is.na(Age)) & !(is.na(Min)))

  df_position <- data[[paste0("CPLPlayerByGame", season)]] |>
    filter(teamName == team_name) |>
    group_by(playerId, Position) |>
    count() |>
    group_by(playerId) |>
    slice_max(order_by = n, n = 1, with_ties = FALSE) |>
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
    mutate(dist = Age - peak_age)
  
  peak_age_dist <- round(mean(df$dist), 1)

  plot <- ggplot(df, aes(x = Age, y = fct_reorder(Player, Age, max))) +
    facet_grid(rows = vars(position_code), scales = "free_y", space = "free_y") +
    geom_rect(data = peak_ages, aes(x = NULL, y = NULL, xmin = peak_age_min, xmax = peak_age_max), ymin = -Inf, ymax = Inf, alpha = 0.25, fill = league_colours[3]) +
    geom_point(colour = team_colours[[team_name]][2], fill = team_colours[[team_name]][1], shape = 21, size = 2, stroke = 0.75) +
    scale_x_continuous(
      breaks = seq.int(from = 16, to = 40, by = 2),
      labels = seq.int(from = 16, to = 40, by = 2),
      limits = c(
        min(c(16, min(df$Age))),
        max(c(40, max(df$Age)))
      )
    ) +
    labs(
      title = paste(team_name, season, "season squad profile"),
      subtitle = paste("Squad years from peak age:", peak_age_dist),
      x = "Age",
      y = NULL,
      caption = "@CanPLdata | #CCdata | #CanPL",
      tag = "Peak Age"
    ) +
    theme_canpl() +
    theme(
      plot.caption = element_text(hjust = 1.096),
      plot.subtitle = element_text(color = league_colours[2], hjust = 0.5, lineheight = 0.3, margin = unit(c(0, 0, 15, 0), "pt"), size = 30)
    )

  path <- paste0("plots/", team_name, "_", season, "_season_squad_age_positions.png")
  ggsave(path, plot, width = 2048, height = 2048, units = "px")
  add_logos(path, team_image_id)
}
