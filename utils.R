get_info_city <- function(city_sp, natalie_queries){
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
    as.list() %>%
    unlist() %>%
    purrr::map(make_query) %>% 
    purrr::map(filter_sp, sp2 = city_sp) %>%
    setNames(c("barrier", "renting_rental", "shop", "cycleway", "streets"))
}

make_query <- function(query){
  Sys.sleep(10)
  overpass_query(query)
}

filter_sp <- function(sp, sp2){
  crs(sp) <- crs(sp2)
  list(sp[sp2,])
}

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