library("overpass")
library("readr")
library("dplyr")
library("ggplot2")

bbox <- "(51.24,-0.61,51.73,0.41)"

fietsen <- read_csv2("fietsen.csv")



query <- paste0('[out:xml][timeout:1000];', '\n ',
'(', '\n ',
   fietsen$Query_string[1], bbox,';', '\n ',
   gsub("way\\[", "node\\[", fietsen$Query_string[1]), bbox,';', '\n ',
  fietsen$Query_string[2], bbox,';', '\n ',
  gsub("way\\[", "node\\[", fietsen$Query_string[2]), bbox,';', '\n ',
  ');', '\n ',
  'out body;', '\n ',
  '>;', '\n ',
  'out skel qt;')


test <- overpass_query(query)


gg <- ggplot()
gg <- gg + geom_path(data=fortify(test), 
                     aes(x=long, y=lat, group=group),
                     color="black", size=0.25)
gg <- gg + coord_quickmap()
gg <- gg + ggthemes::theme_map()
gg


gsub("way\\[", "node\\[", fietsen$Query_string[1])
