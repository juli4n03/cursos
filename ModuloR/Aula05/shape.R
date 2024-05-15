library(sfarrow)
library(ggplot2)
library(sf)

nc <- sf::read_sf(system.file("shape/nc.shp", package = "sf"))
nc %>%
  ggplot() +
  geom_sf()

print(nc)

st_write_parquet(obj = nc, dsn = file.path(tempdir(), "nc.parquet"))
nc_p <- st_read_parquet(file.path(tempdir(), "nc.parquet"))

plot(sf::st_geometry(nc_p))
print(nc_p)
