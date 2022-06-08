plot_squad_profile <- function(team, season) {
  df <- data[[paste0("CPLPlayerByGame", season)]] |>
    filter(teamName == team) |>
    group_by(Player) |>
    summarise(
      Age = max(Age),
      Min = sum(Min)
    )
  
  mean_age <- round(weighted.mean(df$Age, df$Min), 1)
  
  ggplot(df, aes(x = Age, y = Min, label = Player)) +
    geom_rect(aes(xmin = 24, xmax = 29, ymin = 0, ymax = 2500), alpha = 0.01, fill = "#FF0000") +
    geom_point(colour = "#FF0000", fill = "#FFFFFF", size = 3) +
    geom_text_repel(colour = "#FFFFFF") +
    scale_x_continuous(
      breaks = seq.int(from = 16, to = 40, by = 4),
      labels = seq.int(from = 16, to = 40, by = 4)
    ) +
    scale_y_continuous(
      labels = number_format(big.mark = " ")
    ) +
    labs(
      title = paste(team, season, "season squad profile"),
      subtitle = paste("Average age weighted by minutes played:", mean_age),
      x = "Age",
      y = "Minutes played"
    ) +
    theme(
      axis.ticks = element_blank(),
      panel.background = element_rect(fill = "#000000"),
      panel.grid.major = element_line(colour = "#D3D3D3", linetype = "dashed"),
      panel.grid.minor = element_blank(),
      plot.background = element_rect(fill = "#000000"),
      plot.title = element_text(color = "#FFFFFF"),
      plot.title.position = "plot",
      plot.subtitle = element_text(color = "#FFFFFF")
    )
}

