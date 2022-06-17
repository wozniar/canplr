add_logos <- function(path, team_image_id) {
  # team_logo <- image_read(
  #   paste0("https://omo.akamai.opta.net/image.php?secure=true&h=omo.akamai.opta.net&sport=football&entity=team&description=badges&dimensions=150&id=", team_image_id)
  # )
  plot <- image_read(path)
  plot <- image_composite(plot, image_scale(sp_logo, geometry = "18%x18%"), offset = "+40+1864")
  plot <- image_composite(plot, image_scale(cpl_logo, geometry = "18%x18%"), offset = "+1792+1793.8")
  image_write(plot, path)
}