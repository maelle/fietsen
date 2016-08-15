natalie_queries <- read_csv2("data/fietsen_natalie_tags.csv")
names(natalie_queries) <- c("fiets_category", "category", "query_string", "object_type", "wanted")
natalie_queries <- dplyr::filter(natalie_queries, wanted == 1)
natalie_queries <- dplyr::select(natalie_queries, category, query_string, object_type)

# for queries with only ways we need to add a line with nodes
# because otherwise the overpass package will not be able to process them somehow
for (category in c("cycleway", "streets")){
  subset <- dplyr::filter(natalie_queries, category == category)
  newdata <- NULL
  for (j in 1:nrow(subset)){
    newdata <- rbind(newdata,
                     data.frame(category = category,
                     query_string = gsub("way\\[", "node\\[", subset$query_string[j]),
                     object_type = "node"))
  }
  natalie_queries <- dplyr::bind_rows(natalie_queries, newdata)
}

natalie_queries <- dplyr::arrange(natalie_queries, category)


# then do queries by category, might need a long time

# for each city do the 5 queries, each query -> a spatial object to be stored as a list in a column of the cities data.frame

summarize_city <- function(natalie_queries, city_sp){
  bbox <- paste0("(", extent(city_sp)[1], ",", extent(city_sp)[3], ",",
                 extent(city_sp)[2], ",", extent(city_sp)[4], ")")
  dplyr::group_by(natalie_queries, category) %>%
    summarize(query = gsub(toString(query_string)))
    map_purr::overpass_fiets(city_sp)
}


find_infrastructure <- function(categories, city_sp){ 
  
  lapply(categories, characterize_category, city_sp)
  
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
  
}

characterize_category <- function(category)


# then depending on the category calculate the total distance / the number of nodes&ways