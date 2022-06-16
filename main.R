# Load packages ----
library(tidyverse)
library(googledrive)
library(lubridate)
library(ggrepel)
library(scales)
library(showtext)
library(cowplot)
library(magick)

# Load functions ----
functions <- list.files("R/", full.names = TRUE)
walk(functions, source)

# Download data ----
download_data(Sys.getenv("drive_email"), Sys.getenv("drive_url"))

# Update data ----
update_data(Sys.getenv("drive_email"), Sys.getenv("drive_url"))

# Run pipeline ----
data <- read_data() |> 
  map(distinct_cols)
