
### Clase Practica 3/10/23 ###

nlat <- 181 
nlon <- 360 
ntiempos<- 348 
nnivel<- 1 
nvar <- 1 
dato_faltante<- -999

N <-nlat*nlon*ntiempos*nnivel*nvar

archivo <- "~/Documentos/Labo_Luca/data.r4"
datos <- readBin(archivo, "numeric", n=N ,endian = "big",
                 size = 4)

length(datos)

datos[which(datos==dato_faltante)] <- NA

datos_array <- array(data = datos, dim = c(nlon,nlat,ntiempos))
dim(datos_array)

latitudes <- seq(-90,90,1)
length(latitudes)

longitudes <- seq(0,359,1)
length(longitudes)

which(longitudes==285)
which(longitudes==310)
which(latitudes==-55)
which(latitudes==-20)

datos_array_arg <- datos_array[286:311,36:71,]
dim(datos_array_arg)

datos_array_arg2 <- array(datos_array_arg, dim = c(26,36,12,29))
dim(datos_array_arg2)

media_anual_arg <- apply(datos_array_arg2,c(1,2,4),mean)
dim(media_anual_arg)

###########################

nlat <- 181 
nlon <- 360 
ntiempos <- 6
nnivel <- 1 
nvar <- 4 
dato_faltante <- 9.999E+20

N <-nlat*nlon*ntiempos*nnivel*nvar

archivo <- "~/Documentos/Labo_Luca/SepIC_nmme_tmpsfc_anom_stdanom.dat"
datos <- readBin(archivo, "numeric", n=N ,endian = "little",
                 size = 4)

datos_array <- array(data = datos, dim = c(nlon,nlat,ntiempos,nvar))
dim(datos_array)

anom_arg_dic_2020 <- datos_array[286:311,36:71,4,3]
dim(anom_arg_dic_2020)
anom_arg_dic_2020

