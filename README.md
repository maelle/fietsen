Finding cycle paths and tracks in 7 cities
==========================================

In this repo I store the code I used for finding cycle paths and tracks
in 7 cities.

-   I have defined [a bunch of functions](code/utils.R) for making the
    Overpass queries and computing distances or numbers of given nodes.

-   The whole process is described in [a sort of make file](makefile.R).

-   Initial shapefiles for cities were prepared as [shown
    here](code/make_initial_shapefile.R). For some cities it simply
    involved queries to GADM, for other I had to use shapefiles from
    official sources in the country. This data is not included in
    the repository.

-   I prepared a data frame with cities shapefiles and minimal and
    maximal latitude and longitude [in this
    file](code/make_shapefiles.R). The queries to Overpass are done for
    a rectangle defined with minimal and maximal latitude and longitude
    and then I filtered results within the city boundaries.

-   I prepared the query strings [in this
    code](code/make_query_strings.R).

-   I made the queries and calculations
    [here](code/make_overpass_queries.R). The results are [in this file
    with a stupid name](tadaaa.csv).

-   I also produced a few maps thanks to [this code](code/make_maps.R)
    The maps are in the [maps folder](maps/).
