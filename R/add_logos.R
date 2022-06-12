add_logos <- function(plot, team_image_id) {
  # team_logo <- image_read(
  #   paste0("https://omo.akamai.opta.net/image.php?secure=true&h=omo.akamai.opta.net&sport=football&entity=team&description=badges&dimensions=150&id=", team_image_id)
  # )
  
  ggdraw() +
    draw_plot(plot) +
    # draw_image(team_logo, x = -0.47, y = 0.45, scale = 0.15) +
    draw_image(sp_logo, x = -0.3, y = -0.42, scale = 0.15) +
    draw_image(cpl_logo, x = 0.3, y = -0.42, scale = 0.10)
}