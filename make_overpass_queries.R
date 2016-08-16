source("utils.R")


whatweget <- as.list(cities$sp[1:2]) %>%
  purrr::map(get_info_city, natalie_queries)

lala <- tibble::as_tibble(test)
lala <- rbind(lala, lala)
lala <- mutate_(lala, city = lazyeval::interp(~c("city1", "city2"))) 

#distances and sums
function_street <- function(df){
  df %>%
    group_by_(~city) %>%
    mutate_(streets = ~fortify(streets[[1]])  %>%
              slice_rows("group") %>%
              by_slice(distance_function,
                       .collate = "rows",
                       .to = "distance") %>% list()) %>%
    mutate_(streets = lazyeval::interp(~sum(streets[[1]]$"distance")/1000))
}

function_cycleway <- function(df){
  df %>%
    group_by_(~city) %>%
    mutate_(cycleway = ~fortify(cycleway[[1]])  %>%
              slice_rows("group") %>%
              by_slice(distance_function,
                       .collate = "rows",
                       .to = "distance") %>% list()) %>%
    mutate_(cycleway = lazyeval::interp(~sum(cycleway[[1]]$"distance")/1000))
}

function_parkingrental <- function(df){
  df %>%
    mutate_(renting_rental = lazyeval::interp(~length(renting_rental[[1]])))
}

function_barrier <- function(df){
  df %>%
    mutate_(barrier = lazyeval::interp(~length(barrier[[1]])))
}

function_shop <- function(df){
  df %>%
    mutate_(shop = lazyeval::interp(~length(shop[[1]])))
}

whatweget <- whatweget %>%
  function_street() %>%
  function_cycleway() %>%
  function_parkingrental() %>%
  function_barrier() %>%
  function_shop()

# figures
make_maps <- function(sp){
  map <- get_map(location = c(extent(city_sp)[1],
                              extent(city_sp)[3],
                              extent(city_sp)[2],
                              extent(city_sp)[4]),
                 zoom = 10)
  gg <- ggmap(map)
  if(class(sp) == "SpatialLinesDataFrame"){
    df <- fortify(sp)
    gg <- gg + geom_path(data=df, 
                         aes(x=long, y=lat, group=group),
                         color="red", size=0.25)
  }else{
    df <- as.data.frame(coordinates(sp))
    gg <- gg + geom_point(data=df, 
                         aes(x=lon, y=lat),
                         color="red", size=0.25)
  }
  gg <- gg + coord_quickmap()
  gg <- gg + ggthemes::theme_map()
  gg
  
  
}