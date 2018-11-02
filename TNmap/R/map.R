#' Map of Tunisia
#'
#' takes data of tunisia and make a map
#' @param dataname the dataframe object
#' @return Map by governorate
#' @export

library(devtools)
library("tmap")
library("tmaptools")
library("sf")
library("leaflet")

tunmap <- function(dataname, varname){

  tnshape <- "~/TNmap/TUN.shp"
  tngeo <- read_shape(file=tnshape, as.sf = TRUE)
  tngeo$ADM2 <- as.character(tngeo$ADM2)
  tngeo <- tngeo[order(tngeo$ADM2),]
  tngeo$ADM2[3] <- "Beja"
  tngeo$ADM2[6] <- "Gabes"
  tngeo$ADM2[21] <- "Sidi Bouzid"
  tngeo$ADM2[1] <- "Kef"
  tngeo$ADM2[13] <- "Mannouba"

  tnmap <- append_data(tngeo, dataname, key.shp = "ADM2", key.data="REGION", ignore.duplicates=TRUE)

  tm <- tm_shape(tnmap) +
    tm_fill(varname, title="Carte", palette = "Blues") +
    tm_borders(alpha=.5) +
    tm_text("ADM2", size=0.5)

  tmap_leaflet(tm)

}

