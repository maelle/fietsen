# placeholder, probably there is a better way to do this :-)

placeholder <- getData("GADM", country = "GBR", level = 1)
file.remove("GADM_2.8_GBR_adm1.rds")
############################################################
#                                                          #
#                          table                           #
#                                                          #
############################################################


cities <- tibble(cityshort = c("antwerp",
                               "barcelona", "london",
                               "orebro", "roma",
                               "vienna", "zurich"),
                 city_englishname = c("Antwerp",
                                      "Barcelona", "London",
                                      "Oerebro", "Roma",
                                      "Vienna", "Zurich"),
                 city = c(list("Antwerpen"),
                          list("Barcelona"),
                          list(c("Barking and Dagenham",
                                 "Barnet",
                                 "Bexley",
                                 "Brent",
                                 "Bromley",
                                 "Camden",
                                 "London",
                                 "Croydon",
                                 "Ealing",
                                 "Enfield",
                                 "Greenwich",
                                 "Hackney",
                                 "Hammersmith and Fulham",
                                 "Haringey",
                                 "Harrow",
                                 "Havering",
                                 "Hillingdon",
                                 "Hounslow",
                                 "Islington",
                                 "Kensington and Chelsea",
                                 "Kingston upon Thames",
                                 "Lambeth",
                                 "Lewisham",
                                 "Merton",
                                 "Newham",
                                 "Redbridge",
                                 "Richmond upon Thames",
                                 "Southwark",
                                 "Sutton",
                                 "Tower Hamlets",
                                 "Waltham Forest",
                                 "Wandsworth",
                                 "Westminster")), 
                          list("Örebro"),
                          list("Roma"), 
                          list("Wien"),
                          list("Zürich")),
                 country = c("Belgium", "Spain",
                             "United Kingdom", "Sweden",
                             "Italy", "Austria",
                             "Switzerland"),
                 countrycode = c("BEL", "ESP",
                                 "GBR", "SWE",
                                 "ITA", "AUT",
                                 "CHE"),
                 sp = list(placeholder),
                 min_longitude = 0,
                 max_longitude = 0,
                 min_latitude = 0,
                 max_latitude = 0)

############################################################
#                                                          #
#                         add info                         #
#                                                          #
############################################################
for(name in cities$cityshort){
  load(paste0("data/city_sp_", name, ".RData"))
  assign("city_sp",get(paste0("city_sp_", name)))
  i <- which(cities$cityshort == name)
  cities$sp[i] <- list(city_sp)
  cities$min_longitude[i] <- extent(city_sp)[1]
  cities$max_longitude[i] <- extent(city_sp)[2]
  cities$min_latitude[i] <- extent(city_sp)[3]
  cities$max_latitude[i] <- extent(city_sp)[4]
}


save(cities, file = "data/cities.RData")
rm(list = ls())
