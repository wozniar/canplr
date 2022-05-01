# Load packages ----
library(tidyverse)
library(googledrive)

# Load functions ----
functions <- paste0("R/", list.files("R/"))
walk(functions, source)

# Download data ----
download_data()

# Run pipeline ----
data <- read_data() |> 
  map(distinct_cols)
