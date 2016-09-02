whatweget <- as.list(cities$sp) %>%
  purrr::map(get_info_city, natalie_queries)

whatweget <- dplyr::bind_rows(whatweget)
whatweget <- mutate_(whatweget, city = lazyeval::interp(~cities$cityshort)) 

save(whatweget, file = "data/whatweget.RData")

whatweget %>%
 # function_street() %>%
  function_cycleway() %>%
  function_parkingrental() %>%
  function_barrier() %>%
  function_shop() %>%
  dplyr::select(city, everything()) %>%
  write_csv(path = "tadaaa.csv")