
rm(list=ls())

archivo <- "~/Documentos/Labo_Luca/boya.txt"

datos <- read.table(archivo)
tail(datos)
head(datos)
dim(datos)

archivo2 <- "~/Documentos/Labo_Luca/boya_2.txt"

datos2 <- read.table(archivo2, header=T, sep=",")
head(datos2)

############

#EJERCICIO

datos <- read.table("datos_estaciones.txt", header = T)

#Cantidad de datos faltantes
datos[datos==-999] <- NA

faltantes <- 0

for (i in 1:nrow(datos)) {
  for (j in 1:ncol(datos)) {
    if (is.na(datos[i,j])==T) {
      faltantes <- faltantes + 1
    }
  }
}

faltantes

#Valor maximo de temperatura, humedad y presion
which.max(datos[,3])
estacion_tmax <- as.character(datos[40,8])
estacion_tmax
hora_tmax <- as.character(datos[40,2])
hora_tmax

which.max(datos[,4])
estacion_hmax <- as.character(datos[32,8])
estacion_hmax
hora_hmax <- as.character(datos[32,2])
hora_hmax

which.max(datos[,5])
estacion_pmax <- as.character(datos[12,8])
estacion_pmax
hora_pmax <- as.character(datos[12,2])
hora_pmax

#Promedio y ds para cada estacion
tmedia.aeroparque <- mean(datos[1:24,3], na.rm = T)
ds.aeroparque <- sd(datos[1:24,3], na.rm = T)

tmedia.resistencia <- mean(datos[25:48,3], na.rm = T)
ds.resistencia <- sd(datos[25:48,3], na.rm = T)

tmedia.tucuman <- mean(datos[49:72,3], na.rm = T)
ds.tucuman <- sd(datos[49:72,3], na.rm = T)

tmedia.viedma <- mean(datos[73:96,3], na.rm = T)
ds.viedma <- sd(datos[73:96,3], na.rm = T)

#Creo el archivo .txt
estaciones <- c("AEROPARQUE","RESISTENCIA","TUCUMAN","VIEDMA")
medias <- c(17.94,18.70,16.47,12.13)
ds <- c(2.52,4.38,4.84,6.55)
datos.salida <- data.frame("ESTACIONES"=estaciones, "MEDIAS"=medias, "DESVIOS"=ds)

archivo.salida <- "~/Documentos/Labo_Luca/datos_promedio_ds.txt"
write.table(datos.salida, file = archivo.salida, quote = F, row.names = F)






