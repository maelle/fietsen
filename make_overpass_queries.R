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

# then depending on the category calculate the total distance / the number of nodes&ways