theme_canpl <- function() {
  theme(
    axis.text = element_text(colour = league_colours[2], family = "Oswald", size = 25),
    axis.text.y = element_text(margin = unit(c(0, 2.2, 0, 2.2), "pt")),
    axis.ticks = element_blank(),
    axis.title = element_text(size = 30),
    axis.title.x = element_text(margin = unit(c(7.5, 0, 7.5, 0), "pt")),
    axis.title.y = element_text(margin = unit(c(0, 7.5, 7.5, 0), "pt")),
    panel.background = element_rect(fill = league_colours[4]),
    panel.grid.major = element_line(colour = league_colours[3], linetype = "dashed"),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = league_colours[4]),
    plot.caption = element_text(size = 30, vjust = 1),
    plot.caption.position = "plot",
    plot.margin = unit(c(5.5, 20, 75, 17.8), "pt"),
    plot.tag = element_text(color = league_colours[2], margin = unit(c(20, 0, 15, 0), "pt"), size = 30),
    plot.tag.position = c(0.5, 0.895),
    plot.title = element_text(color = league_colours[2], hjust = 0.5, margin = unit(c(7.5, 0, 5, 0), "pt"), size = 50),
    plot.title.position = "plot",
    plot.subtitle = element_text(color = league_colours[2], hjust = 0.5, lineheight = 0.3, margin = unit(c(0, 0, 15, 0), "pt"), size = 30),
    strip.background = element_rect(colour = league_colours[2], fill = league_colours[4]),
    strip.placement = "outside",
    strip.switch.pad.grid = unit(10, "pt"),
    strip.text.y = element_text(angle = 360, colour = league_colours[2], family = "Oswald", size = 25),
    text = element_text(colour = league_colours[2], family = "Oswald", size = 25)
  )
}
