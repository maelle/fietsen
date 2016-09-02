whatweget_streets <- as.list(cities$sp) %>%
  purrr::map(get_streets_city, natalie_streets_queries)

whatweget_streets <- dplyr::bind_rows(whatweget_streets)
whatweget_streets <- mutate_(whatweget_streets, city = lazyeval::interp(~cities$cityshort)) 

save(whatweget_streets, file = "data/whatweget_streets.RData")

whatweget_streets %>%
  function_street()  %>%
  dplyr::select(city, everything()) %>%
  write_csv(path = "tadaaa_streets.csv")