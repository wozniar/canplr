get_positions_codes <- function(df, var) {
  df |>
    mutate(
      position_code = fct_drop(
        factor(
          case_when(
            {{ var }} == "Goalkeeper" ~ "GK",
            {{ var }} %in% c("Central Defender", "Left Centre Back", "Right Centre Back") ~ "CB",
            {{ var }} %in% c("Left Back", "Left Wing Back", "Right Back", "Right Wing Back") ~ "FB",
            {{ var }} %in% c("Central Midfielder", "Defensive Midfielder") ~ "CM",
            {{ var }} %in% c("Left Attacking Midfielder", "Left Midfielder", "Left Winger", "Right Attacking Midfielder", "Right Midfielder", "Right Winger") ~ "WM",
            {{ var }} %in% c("Centre Attacking Midfielder") ~ "AM",
            {{ var }} %in% c("Centre Forward", "Second Striker") ~ "ST"
          ),
          levels = c("GK", "CB", "FB", "CM", "WM", "AM", "ST")
        )
      )
    )
}

get_peak_ages <- function() {
  df <- tibble(
    position_code = factor(c("GK", "CB", "FB", "CM", "WM", "AM", "ST"), levels = c("GK", "CB", "FB", "CM", "WM", "AM", "ST")),
    peak_age = c(28, 27, 25, 25, 26, 26, 27),
    peak_age_min = c(26.5, 25.5, 23.5, 23.5, 24.5, 24.5, 25.5),
    peak_age_max = c(29.5, 28.5, 26.5, 26.5, 27.5, 27.5, 28.5)
  )
}

# https://stackoverflow.com/questions/44688623/adding-custom-images-to-ggplot-facets
# https://www.blopig.com/blog/2019/08/combining-inset-plots-with-facets-using-ggplot2/
annotation_custom2 <- function(grob, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf, data) {
    layer(
      data = data, stat = StatIdentity, position = PositionIdentity,
      geom = ggplot2:::GeomCustomAnn,
      inherit.aes = TRUE, params = list(
        grob = grob,
        xmin = xmin, xmax = xmax,
        ymin = ymin, ymax = ymax
      )
    )
  }