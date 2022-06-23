# DIRECTORY ----
if (!(dir.exists("plots"))) {
  dir.create("plots")
}

# LOGOS ----
cpl_logo <- image_read("graphics/Canadian_Premier_League_logo.png")
sp_logo <- image_read("graphics/StatsPerformLogo.png")

# FONTS ----
# Fonts as found here: https://canpl.ca/
if (!("Oswald" %in% font_installed())) {
  oswald <- google_fonts("Oswald")
  font_install(oswald)
}

if (!("Lato" %in% font_installed())) {
  lato <- google_fonts("Lato")
  font_install(lato)
}

showtext_auto()

# COLOURS ----
# League colours as found here:
# https://sportsfancovers.com/canadian-premier-league-color-codes/
# Team colours as found here:
# https://www.trucolor.net/portfolio/canadian-premier-league-official-colors-2019-through-present/
league_colours <- c("#A2C523", "#22356F", "#40BAED", "#FFFFFF")
team_colours <- vector("list", 8)
names(team_colours) <- c("Atlético Ottawa", "Cavalry", "Edmonton", "Forge", "HFX Wanderers", "Pacific", "Valour", "York United")
team_colours[["Atlético Ottawa"]] <- c("#E4002B", "#FFFFFF", "#1B365D")
team_colours[["Cavalry"]] <- c("#DA291C", "#010101", "#335525", "#FFFFFF")
team_colours[["Edmonton"]] <- c("#004C97", "#0C2340", "#FFFFFF")
team_colours[["Forge"]] <- c("#DC4405", "#53565A", "#FFFFFF")
team_colours[["HFX Wanderers"]] <- c("#41B6E6", "#002855", "#999999", "#FFFFFF")
team_colours[["Pacific"]] <- c("#582C83", "#00B7BD", "#FFFFFF")
team_colours[["Valour"]] <- c("#7C2629", "#010101", "#B9975B", "#FFFFFF")
team_colours[["York United"]] <- c("#046A38", "#003B5C", "#89764B", "#FFFFFF")
