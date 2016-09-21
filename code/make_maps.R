############################################################
#                                                          #
#                       cycle tracks                       #
#                                                          #
############################################################


load("data/whatweget.RData")

for (i in 1:7){
  sp <- whatweget$cycleway[i][[1]]
  m <- leaflet() %>% 
    addTiles()%>%
    addCircleMarkers(data=fortify(sp), col = "red",
                     popup = ~id,
                     stroke = FALSE, fillOpacity = 0.5,
                     radius = 3)
  saveWidget(m, file=paste0(getwd(),"/maps/m", i, ".html"))
}

############################################################
#                                                          #
#                         streets                          #
#                                                          #
############################################################


load("data/whatweget_streets.RData")

for (i in 1:7){
  sp <- whatweget_streets$streets[i][[1]]
  m <- leaflet() %>% 
    addTiles()%>%
    addCircleMarkers(data=fortify(sp), col = "red",
                     popup = ~id,
                     stroke = FALSE, fillOpacity = 0.5,
                     radius = 3)
  saveWidget(m, file=paste0(getwd(),"/maps_streets/m", i, ".html"))
}
