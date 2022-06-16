distinct_cols <- function(df) {
  new_names <- tibble(name = names(df)) |> 
    mutate(ellipsis_position = asplit(str_locate(name, "\\..."), 1)) |> 
    unnest_wider(ellipsis_position) |> 
    mutate(new_name = ifelse(is.na(start), name, str_sub(name, 1, start - 1))) |> 
    group_by(new_name) |> 
    mutate(occurence = row_number()) |> 
    ungroup() |> 
    mutate(name = ifelse(occurence == 1, new_name, name)) |> 
    pull(name)
  names(df) <- new_names
  df <- df |> 
    select(-contains("..."))
  if ("null" %in% names(df)) {
    df <- df |> 
      select(-null)
  }
  return(df)
}
