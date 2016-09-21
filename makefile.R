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



############################################################
#                                                          #
# make the data.frame with basic information about cities  #
#                                                          #
############################################################
rm(list=ls())
source("code/make_shapefiles.R")


############################################################
#                                                          #
#                         queries                          #
#                                                          #
############################################################

source("code/make_query_strings.R")

load("data/natalie_queries.RData")
source("code/utils.R")
load("data/cities.RData")
source("code/make_overpass_queries.R")

load("data/cities.RData")
load("data/natalie_streets_queries.RData")
source("code/make_overpass_streets_queries.R")
#source("code/make_maps.R")