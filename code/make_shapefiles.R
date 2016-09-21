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
source("code/make_cities_initial_shapefile.R")
############################################################
#                                                          #
#                         add info                         #
#                                                          #
############################################################
for(i in 1:nrow(cities)){

  name <- cities$cityshort[i]
  load(paste0("data/city_sp_", name, ".RData"))
  assign("city_sp",get(paste0("city_sp_", name)))
  
  
  if(name == "london"){
    city_sp <- crop(city_sp, extent(-0.61, 0.41, 51.24, 51.73))
    assign("city_sp_london", get("city_sp"))
    save(city_sp_london, file = "data/city_sp_london.RData")
  }
  
  cities$sp[i] <- list(city_sp)
  
  
}


save(cities, file = "data/cities.RData")
rm(list = ls())
