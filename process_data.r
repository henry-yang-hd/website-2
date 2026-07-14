library(tidyverse)
# Tidy the billboard data: pivot the week columns and convert them to numeric values
billboard_long <- billboard |> 
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE
  ) |> 
  mutate(week = parse_number(week))

# Filter for specific popular tracks from the year 2000
top_songs <- tracks_to_plot <- billboard_long |> 
  filter(track %in% c("Try Again", "Say My Name", "Kryptonite", "With Arms Wide Open"))

write_rds(top_songs, file = "clean_data.rds")
