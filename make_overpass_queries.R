natalie_queries <- read_csv2("data/fietsen_natalie_tags.csv")
names(natalie_queries) <- c("fiets_category", "category", "query_string", "object_type", "wanted")
natalie_queries <- dplyr::filter(natalie_queries, wanted == 1)
natalie_queries <- dplyr::select(natalie_queries, category, query_string, object_type)

# for queries with only ways we need to add a line with nodes
# because otherwise the overpass package will not be able to process them somehow
for (categori in c("cycleway", "streets")){
  subset <- dplyr::filter(natalie_queries, category == categori)
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
  bbox <- paste0("(", extent(city_sp)[3], ",", extent(city_sp)[1], ",",
                 extent(city_sp)[4], ",", extent(city_sp)[2], ")")
  
  dplyr::group_by_(natalie_queries, ~category) %>%
    summarize_(query = lazyeval::interp(~gsub(", ", 
                           paste(bbox, '; \n '),
                           toString(query_string)))) %>%
    mutate_(query = lazyeval::interp(~paste0("[out:xml][timeout:100];\n (\n ",
                                             query,
                                             bbox,";\n\n );\n out body;\n >;\n out skel qt;"))) %>%
    dplyr::select(query) %>%
    purrr::by_row(make_query) %>%
    purrr::map(filter_sp, sp2 = city_sp)
}

make_query <- function(query){
  overpass_query(query$query)
}

filter_sp <- function(sp1, sp2){
  crs(sp1) <- crs(sp2)
  sp1[sp2,]
}