## Install the tidycensus package if you haven't yet
#install.packages("tidycensus")

library(tidycensus)
library(ggplot2)
## setup cenus api key
## signup your census api key at http://api.census.gov/data/key_signup.html
census_api_key("5dda234cf583d7fa7e3212d3743a4c03012d11ac", install=TRUE) # 
portland_tract_medhhinc <- get_acs(geography = "tract", 
                                   year = 2016, # 2012-2016
                                   variables = "B19013_001",  # Median Household Income in the Past 12 Months
                                   state = "OR", 
                                   county = c("Multnomah County", "Washington County", "Clackamas County"),
                                   geometry = TRUE) # load geometry/gis info


ggplot(portland_tract_medhhinc) + 
  geom_sf(aes(fill = estimate)) +
  coord_sf(datum = NA) + theme_minimal()


## Install the mapview package if you haven't yet
#install.packages("mapview")
library(sf)


library(mapview)

mapview(portland_tract_medhhinc %>% select(estimate), 
        col.regions = sf.colors(10), alpha = 0.1)


library(sf)
library(readr)
# read 1994 Metro TAZ shape file
taz_sf <- st_read("data/taz1260.shp", crs=2913)


# read geocode.raw file that contains X and Y coordinates
portland94_df <- read_csv("data/portland94_geocode.raw.zip", col_names=c("uid", "X", "Y", "case_id", 
                                                                         "freq", "rtz", "sid", 
                                                                         "totemp94", "retemp94"))


portland94_df <- portland94_df %>% 
  filter(X!=0, Y!=0) %>% 
  sample_n(500)

# create a point geometry with x and y coordinates in the data frame
portland94_sf <- st_as_sf(portland94_df, coords = c("X", "Y"), crs = 2913)

# spatial join to get TAZ for observations in portland94_sf
portland94_sf <- st_join(portland94_sf, taz_sf)
head(portland94_sf)


ggplot() +
  geom_sf(data = taz_sf, aes(alpha=0.9)) +
  geom_sf(data = portland94_sf)

#BLAHBLAHBLAH
