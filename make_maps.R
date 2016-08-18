load("data/whatweget.RData")

for (i in 1:7){
  sp <- whatweget$cycleway[i][[1]]
  m <- leaflet() %>% 
    addTiles()%>%
    addCircleMarkers(data=fortify(sp), col = "red",
                     popup = ~id,
                     stroke = FALSE, fillOpacity = 0.5,
                     radius = 3)
  saveWidget(m, file=paste0("m", i, ".html"))
}

