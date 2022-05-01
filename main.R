# Load packages ----
library(tidyverse)
library(googledrive)

# Load functions ----
functions <- list.files("R/", full.names = TRUE)
walk(functions, source)

# Download data ----
download_data()

# Run pipeline ----
data <- read_data() |> 
  map(distinct_cols)
