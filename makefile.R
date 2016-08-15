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

############################################################
#                                                          #
# make the data.frame with basic information about cities  #
#                                                          #
############################################################

# source("make_cities_intial_shapefiles.R")
source("make_shapefiles.R")


############################################################
#                                                          #
#                         queries                          ####
#                                                          #
############################################################
load("data/cities.RData")
