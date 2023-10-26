
require(ncdf4)
require(lubridate)

OUTPUTS <- ("~/Documentos/Labo_Luca/")

lon <- seq(270,320,5)
lats <- seq(-10,-50,-5)
Months <- as.numeric(seq(as.Date("1979/1/1"), by = "month", length.out = 432))

dimX <- ncdim_def( "long", "degrees", lon)
dimY <- ncdim_def ( "lat", "degrees", lats )
dimT <- ncdim_def( "Time", "days", Months, unlim=TRUE )
var1d <- ncvar_def("mslp", units = "hPa", longname = "mean sea level pressure",
                   dim = list(dimX,dimY,dimT), missval = -999, prec ="double",
                   verbose = TRUE )

nc <- nc_create(paste(OUTPUTS, "mslp_hPa.nc", sep=""), list(var1d))
MSLP<-runif(42768)
ncvar_put(nc, var1d, MSLP)
nc_close(nc)

#### ABRIR lo que guardamos

nc <- nc_open("~/Documentos/Labo_Luca/mslp_hPa.nc")
nc
class(nc)

presion <- ncvar_get(nc,varid="mslp")
Longitud <- ncvar_get(nc,varid="long")
Latitud <- ncvar_get(nc,varid="lat")
Time <- ncvar_get(nc,varid="Time")

class(presion)
class(Longitud)
class(Latitud)
class(Time)

head(Time)
fecha <- ymd_hms("1970-1-1 00:00:00") + days(Time) 
head(fecha)
tail(fecha)

presion[2,2,3]

### Praticar solos ###

nc <- nc_open("~/Documentos/Labo_Luca/X157.92.28.55.252.12.27.10.nc")
nc

sst <- ncvar_get(nc, "sst")
longitud <- ncvar_get(nc, varid = "lon")
latitud <- ncvar_get(nc, varid = "lat")
Time <- ncvar_get(nc, varid = "time")
time <- ymd_hms("1800-1-1 00:00:00") + days(Time)

lat30 <- which(latitud == -30)
lat60 <- which(latitud == -60)
lon250 <- which(longitud ==  250)
lon320 <- which(longitud == 320)
fecha1 <- which(format(time, "$Y-$M-$D") == "1990-01-01")








