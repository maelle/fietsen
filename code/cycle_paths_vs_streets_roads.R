library("dplyr")
library("ggplot2")
library("viridis")
streets <- readr::read_csv("tadaaa_streets.csv")
cycles <- readr::read_csv("tadaaa.csv")


distances <- left_join(streets, cycles, by = "city")


p <- ggplot(distances) +
  geom_bar(aes(city, cycleway/streets,
               fill = city), stat = "identity") +
  scale_fill_viridis(discrete = TRUE) +
  theme(legend.position = "none") 
ggsave(p, file = "figures/cycleway_vs_streets.png", width = 8, height = 6)