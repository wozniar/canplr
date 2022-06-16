plot_squad_age_minutes <- function(team_name, season, save = FALSE) {
  df <- data[[paste0("CPLPlayerByGame", season)]] |>
    filter(teamName == team_name) |>
    group_by(Player) |>
    summarise(
      Age = max(Age),
      Min = sum(Min)
    ) |>
    filter(!(is.na(Age)) & !(is.na(Min)))

  team_image_id <- data[[paste0("CPLPlayerByGame", season)]] |>
    filter(teamName == team_name) |>
    distinct(teamImageId) |>
    pull(teamImageId)

  mean_age <- round(weighted.mean(df$Age, df$Min), 1)

  plot <- ggplot(df, aes(x = Age, y = Min, label = Player)) +
    geom_rect(aes(xmin = 24, xmax = 29, ymin = 0, ymax = 2500), alpha = 0.01, fill = league_colours[3]) +
    annotate("text", x = 20, y = 1250, label = "YOUTH", angle = 90, size = 125 / .pt, colour = league_colours[2], alpha = 0.2) +
    annotate("text", x = 26.5, y = 1250, label = "PEAK", angle = 90, size = 125 / .pt, colour = league_colours[2], alpha = 0.2) +
    annotate("text", x = 34.5, y = 1250, label = "EXPERIENCE", angle = 90, size = 125 / .pt, colour = league_colours[2], alpha = 0.2) +
    geom_point(colour = team_colours[[team_name]][2], fill = team_colours[[team_name]][1], shape = 21, size = 2, stroke = 0.75) +
    geom_text_repel(colour = league_colours[2], family = "Oswald", size = 25 / .pt, max.overlaps = 30) +
    scale_x_continuous(
      breaks = seq.int(from = 16, to = 40, by = 4),
      labels = seq.int(from = 16, to = 40, by = 4),
      limits = c(
        min(c(16, min(df$Age))),
        max(c(40, max(df$Age)))
      )
    ) +
    scale_y_continuous(
      labels = number_format(big.mark = " ")
    ) +
    labs(
      title = paste(team_name, season, "season squad profile"),
      subtitle = paste("Players used:", nrow(df), "\nAverage age weighted by minutes played:", mean_age),
      x = "Age",
      y = "Minutes played",
      caption = "@CanPLdata | #CCdata | #CanPL"
    ) +
    theme(
      axis.text = element_text(colour = league_colours[2], family = "Oswald"),
      axis.ticks = element_blank(),
      axis.title = element_text(size = 30),
      axis.title.x = element_text(margin = unit(c(7.5, 0, 7.5, 0), "pt")),
      axis.title.y = element_text(margin = unit(c(0, 7.5, 7.5, 0), "pt")),
      panel.background = element_rect(fill = league_colours[4]),
      panel.grid.major = element_line(colour = league_colours[3], linetype = "dashed"),
      panel.grid.minor = element_blank(),
      plot.background = element_rect(fill = league_colours[4]),
      plot.margin = unit(c(5.5, 5.5, 75, 5.5), "pt"),
      plot.caption = element_text(size = 30),
      plot.title = element_text(color = league_colours[2], hjust = 0.5, margin = unit(c(7.5, 0, 7.5, 0), "pt"), size = 50),
      plot.title.position = "plot",
      plot.subtitle = element_text(color = league_colours[2], hjust = 0.5, lineheight = 0.3, margin = unit(c(0, 0, 10, 0), "pt"), size = 30),
      text = element_text(colour = league_colours[2], family = "Oswald", size = 25)
    )
  
  plot <- add_logos(plot, team_image_id)
  
  if (save == TRUE) {
    ggsave(paste0("plots/", team_name, "_", season, "_season_squad_age_minutes.png"), plot, width = 2048, height = 2048, units = "px")
  }

  return(plot)
}