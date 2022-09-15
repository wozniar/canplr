add_logos <- function(path, team_image_id) {
  # team_logo <- image_read(
  #   paste0("https://omo.akamai.opta.net/image.php?secure=true&h=omo.akamai.opta.net&sport=football&entity=team&description=badges&dimensions=150&id=", team_image_id)
  # )
  # LOGOS ----
  cpl_logo <- image_read("graphics/Canadian_Premier_League_logo.png")
  sp_logo <- image_read("graphics/StatsPerformLogo.png")
  tt_logo <- image_read("graphics/Twitter social icons - circle - blue.png")
  gh_logo <- image_read("graphics/GitHub-Mark-64px.png")
  plot <- image_read(path)
  plot <- image_composite(plot, image_scale(sp_logo, geometry = "26.775%x26.775%"), offset = "+40+1793.8")
  plot <- image_composite(plot, image_scale(cpl_logo, geometry = "18%x18%"), offset = "+1792+1793.8")
  plot <- image_composite(plot, image_scale(tt_logo, geometry = "16%x16%"), offset = "+1665+1685")
  plot <- image_composite(plot, image_scale(gh_logo, geometry = "100%x100%"), offset = "+1745+1685")
  image_write(plot, path)
}