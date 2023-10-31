
### Clase teorica 31/10/23 ###

## Repaso NCDF ##
archivo <- "~/Documentos/Labo_Luca/air.mon.mean.nc" #donde esta el archivo
nc <- nc_open(archivo) #abro el archivo netCDF
nc

temp_aire <- ncvar_get(nc, "air")
class(temp_aire)
dim(temp_aire)
lats <- ncvar_get(nc, "lat")
lons <- ncvar_get(nc, "lon")
tiempos <- ncvar_get(nc, "time")
head(tiempos)

tiempos_1 <- as.Date(tiempos/24, origin="1800-01-01")
head(tiempos_1)
tail(tiempos_1)

head(months(tiempos_1))
datos_temp_marzo <- temp_aire[,,months(tiempos_1) == "marzo"]
dim(datos_temp_marzo)

install.packages("udunits2")
require(udunits2)
install.packages("metR")
require(metR)
install.packages("PCICt")
require(PCICt)

GlanceNetCDF(nc)
datos <- ReadNetCDF(archivo, vars = "air")
head(datos)  
dim(datos)

datos_region <- ReadNetCDF(archivo, vars = "air",
                           subset = list(lat = c(-65, -20), lon = c(280, 310)))

# Ejercicio #
archivo <- "~/Documentos/Labo_Luca/datos_u850.nc"
nc <- nc_open(archivo)  
nc  

viento <- ncvar_get(nc, "ua850")
dim(viento)
lats <- ncvar_get(nc, "lat")  
lons <- ncvar_get(nc, "lon")
tiempos <- ncvar_get(nc, "time")
tiempos1 <- as.Date(tiempos, origin = "1949-12-1 00:00:00")
dim(tiempos1)
head(tiempos1)
tail(tiempos1)

cuenca <- viento[which(lons == -64.25):which(lons == -51.25),
                       which(lats == -38.75):which(lats == -23.75),]
anios <- c(2005:2010)
medias_anuales <- c()
for (i in 1:length(anios)) {
  anio = anios[i]
  medias_anuales[i] <- round(mean(cuenca[,,year(tiempos1) == anio]),2)
}
medias_anuales

df_medias_cuenca <- data.frame("Anio" = anios, "Media anual" = medias_anuales)  
df_medias_cuenca
