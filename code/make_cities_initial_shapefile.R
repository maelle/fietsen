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
file.remove(paste0("GADM_2.8_GBR_adm1.rds"))

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
city_realname <- cities$city[cities$cityshort == "London"][[1]]
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
dsn <- paste0(getwd(), "/Sweden_shapefile/my_riks")
adm <- raster::shapefile(dsn)
adm <- adm[adm$KKOD == 303 & adm$NAMN1 == "Örebro",]
#proj4string(adm) <- CRS("+init=epsg:32633 ") # WGS 84 / UTM zone 33N 
CRS.new <- CRS("+init=epsg:4326") # WGS 84
city_sp_orebro <- spTransform(adm, CRS.new)
save(city_sp_orebro, file = "data/city_sp_orebro.RData")

############################################################
#                                                          #
#                       Roma - Italy                       #
#                                                          #
############################################################
dsn <- paste0(getwd(), "/Italy_shapefile/Localita_11_WGS84")
adm <- raster::shapefile(dsn)
adm <- adm[adm$DENOMINAZI == "Roma",]
#proj4string(adm) <- CRS("+init=epsg:23032") # ED50 / UTM zone 32N
CRS.new <- CRS("+init=epsg:4326") # WGS 84
city_sp_roma <- spTransform(adm, CRS.new)
save(city_sp_roma, file = "data/city_sp_roma.RData")

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



city_englishname <- "Antwerp"
city_realname <- "Antwerpen"
level <- 4
country <- "BEL"

adm <- getData("GADM", country = country, level = level)

city_sp_antwerp <- adm[adm$NAME_4 %in% city_realname,]
save(city_sp_antwerp, file = "data/city_sp_antwerp.RData")
file.remove(paste0("GADM_2.8_", country,"_adm", level, ".rds"))