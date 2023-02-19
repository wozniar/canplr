# df <- player_totals |>
#   filter(year == 2019) |>
#   select(playerId, Player, teamId, teamName, Min) |>
#   slice_max(Min, n = 20) |>
#   mutate(
#     player_label = paste0(Player, " (", teamName, ")"),
#     player_label = fct_reorder(player_label, Min, min)
#   )
# 
# plot <- ggplot(df, aes(x = player_label, y = Min)) +
#   geom_col(colour = league_colours[3], fill = league_colours[2]) +
#   geom_text(aes(label = Min), colour = league_colours[4], family = "Oswald", hjust = 1.5, size = 25 / .pt) +
#   coord_flip() +
#   labs(
#     title = "Players with most minutes played",
#     subtitle = "2019 season",
#     x = NULL,
#     y = "Minutes",
#     caption = caption,
#     tag = tag
#   ) +
#   theme_canpl()
# 
# path <- "plots/test.png"
# ggsave(path, plot, width = 2048, height = 2048, units = "px")
# add_logos(path, "")
