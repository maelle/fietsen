############################################################
#                                                          #
#                    Antwerp - Belgium                     #
#                                                          #
############################################################
city_englishname <- "Antwerp"
city_realname <- "Antwerpen"
level <- 4
country <- "BEL"

adm <- getData("GADM", country = country, level = level)

city_sp_antwerp <- adm[adm$NAME_4 %in% city_realname,]
save(city_sp_antwerp, file = "data/city_sp_antwerp.RData")
file.remove(paste0("GADM_2.8_BEL_adm4.rds"))

############################################################
#                                                          #
#                    Barcelona - Spain                     #
#                                                          #
############################################################
city_englishname <- "Barcelona"
city_realname <- "Barcelona"
level <- 4
country <- "ESP"

adm <- getData("GADM", country = country, level = level)

city_sp_barcelona <- adm[adm$NAME_4 %in% city_realname,]
save(city_sp_barcelona, file = "data/city_sp_barcelona.RData")
file.remove(paste0("GADM_2.8_", country,"_adm", level, ".rds"))

############################################################
#                                                          #
#                       London - UK                        #
#                                                          #
############################################################
city_englishname <- "London"
city_realname <- cities$city[cities$cityshort == "london"][[1]]
level <- 2
country <- "GBR"

adm <- getData("GADM", country = country, level = level)

city_sp_london <- adm[adm$NAME_2 %in% city_realname,]
save(city_sp_london, file = "data/city_sp_london.RData")
file.remove(paste0("GADM_2.8_", country,"_adm", level, ".rds"))

############################################################
#                                                          #
#                    Oerebro -  Sweden                     #
#                                                          #
############################################################
dsn <- paste0(getwd(), "/Sweden_shapefile/ak_riks")
adm <- raster::shapefile(dsn)
adm <- adm[grepl(".rebro", adm$KOMMUNNAMN),]
#proj4string(adm) <- CRS("+init=epsg:32633 ") # WGS 84 / UTM zone 33N 
CRS.new <- CRS("+init=epsg:4326") # WGS 84
city_sp_orebro <- spTransform(adm, CRS.new)
save(city_sp_orebro, file = "data/city_sp_orebro.RData")

############################################################
#                                                          #
#                       Roma - Italy                       #
#                                                          #
############################################################
adm <- getData("GADM", country = "ITA", level = 3)

city_sp_roma <- adm[adm$NAME_3 == "Roma",]
save(city_sp_roma, file = "data/city_sp_roma.RData")
file.remove(paste0("GADM_2.8_", "ITA","_adm", 3, ".rds"))

############################################################
#                                                          #
#                     Vienna - Austria                     #
#                                                          #
############################################################
city_englishname <- "Vienna"
city_realname <- "Wien"
level <- 3
country <- "AUT"

adm <- getData("GADM", country = country, level = level)

city_sp_vienna <- adm[adm$NAME_2 == city_realname,]
save(city_sp_vienna, file = "data/city_sp_vienna.RData")
file.remove(paste0("GADM_2.8_", country,"_adm", level, ".rds"))

############################################################
#                                                          #
#                  Zuerich - Switzerland                   #
#                                                          #
############################################################

city_englishname <- "Zurich"
city_realname <- "Zürich"
level <- 3
country <- "CHE"

adm <- getData("GADM", country = country, level = level)

city_sp_zurich <- adm[adm$NAME_2 %in% city_realname,]
save(city_sp_zurich, file = "data/city_sp_zurich.RData")
file.remove(paste0("GADM_2.8_", country,"_adm", level, ".rds"))
