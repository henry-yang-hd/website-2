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

billboard_plot <- ggplot(top_songs, aes(x = week, y = rank, color = track)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2) +
  scale_y_reverse(limits = c(100, 1), breaks = c(1, 10, 25, 50, 75, 100)) +
  scale_color_brewer(palette = "Set1") +
  labs(
    title = "Billboard Rank Over Time (2000)",
    subtitle = "Weekly rank trajectory for selected top singles",
    x = "Week",
    y = "Rank (1 is Top)",
    color = "Track"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )
ggsave("billboard.png", billboard_plot)
