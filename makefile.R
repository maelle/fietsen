library("overpass")
library("geosphere")
library("dplyr")
library("purrr")
library("leaflet")
library("raster")
library("sp")
library("rgeos")
library("tibble")
library("maptools")
library("ggplot2")
library("readr")
library("htmltools")
library("ggmap")
library("rgdal")
library("htmlwidgets")

distance_function <- function(df){
  filtered <- dplyr::select(df, long, lat)
  filtered1 <- filtered[1:(nrow(filtered) - 1),]
  filtered2 <- filtered[2:nrow(filtered),]
  sum(distGeo(filtered1, filtered2))
}

############################################################
#                                                          #
# make the data.frame with basic information about cities  #
#                                                          #
############################################################

# source("make_cities_intial_shapefiles.R")
source("make_shapefiles.R")


############################################################
#                                                          #
#                         queries                          #
#                                                          #
############################################################

source("make_query_strings.R")
load("data/cities.RData")
load("data/natalie_queries.RData")
source("utils.R")
source("make_overpass_queries.R")
source("make_maps.R")