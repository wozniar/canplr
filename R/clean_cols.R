clean_cols <- function(df) {
  # Create tibble with "broken" and "fixed" variables names
  new_names <- tibble(name = names(df)) |>
    mutate(new_name = str_remove(name, "\\...\\d*"))

  # Create a list of vectors with all variables that should be coalesced
  names_list <- vector("list", length(unique(new_names$new_name)))
  for (i in seq_along(unique(new_names$new_name))) {
    names_list[[i]] <- new_names |>
      filter(new_name == unique(new_names$new_name)[i]) |>
      pull(name)
  }
  names(names_list) <- unique(new_names$new_name)

  # Iterate over "fixed" names
  for (i in seq_along(unique(new_names$new_name))) {
    var_i <- unique(new_names$new_name)[i]
    if (length(names_list[[var_i]]) > 1) {
      # If there are two or more "broken" names linking to a "fixed" name then convert their types to character
      for (j in 1:length(names_list[[var_i]])) {
        var_j <- names_list[[var_i]][j]
        df <- df |>
          mutate(
            {{ var_j }} := as.character(!!sym(var_j))
          )
      }
      # If there are two or more "broken" names linking to a "fixed" name then coalesce their values
      df <- df |>
        mutate(
          {{ var_i }} := coalesce(!!!syms(names_list[[var_i]]))
        )
    }
  }

  df <- df |>
    select(-contains("...")) |>
    select(-contains("null"))
}