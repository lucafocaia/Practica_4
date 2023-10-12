
### Clase practica 12/10/23 ###

setwd("~/Documentos/Labo_Luca")

require(readxl)

archivo_ejemplo <- "datos.xls"
cantidad_hojas <- length(excel_sheets(archivo_ejemplo))
print(paste("El archivo tiene",cantidad_hojas,"hojas"))

nombre_hojas <- excel_sheets(archivo_ejemplo)
print("Estas hojas se llaman:")
print(nombre_hojas)

abro_archivo_ejemplo <- read_excel(archivo_ejemplo, sheet = 3)
head(abro_archivo_ejemplo)
class(abro_archivo_ejemplo)


### Ejercicio

rm(list = ls())

datos <- "Historicos_Estacion_3316.xlsx"
cant_hojas <- length(read_excel(datos))
read_excel(datos)

require(lubridate)
library(lubridate)

datos_altura <- read_excel(datos)
head(datos_altura)

tiempos <- dmy_hm(datos_altura$"Fecha y Hora")
anios <- year(tiempos)
meses <- month(tiempos)
dias <- day(tiempos)

#Armo el data frame
datos_altura_1 <- data.frame("Años"=anios,"Mes"=meses,"Dia"=dias,"Altura"=datos_altura$`Altura [m]`)
head(datos_altura_1)

#Calculo el promedio de los eneros de cada anio entre 1981 y 2021
medias_eneros <- c()
anios_1981_2021 <- c(1981:2021)
for (i in 1:length(anios_1981_2021)) {
  anio <- anios_1981_2021[i]
  datos_anio <- datos_altura_1[datos_altura_1$Años == anio,]
  enero <- datos_anio[datos_anio$Mes == 1,]
  media_enero <- mean(enero$Altura, rm.na = TRUE)
  medias_eneros[i] <- media_enero
}
print(medias_eneros)

#Calculo el minimo y el anio en que se dio
altura_minima <- min(medias_eneros, na.rm = TRUE)
anio_minima <- anios_1981_2021[which(medias_eneros == altura_minima)]

print(paste("La altura minima media de enero fue de: ", round(altura_minima,2), " en el año: ", anio_minima))

#Armo funcion
media_mensual <- function(df,mes) {
  medias_mensuales <- c()
  anios_1981_2021 <- c(1981:2021)
  for (i in 1:length(anios_1981_2021)) {
    anio <- anios_1981_2021[i]
    datos_anio <- df[df$Año == anio,]
    datos_mes <- datos_anio[datos_anio$Mes == mes,]
    media_mensual <- mean(datos_mes$Altura, na.rm = T)
    medias_mensuales[i] <- media_mensual
  }
  return(list(medias_mensuales,anios_1981_2021))
}

#Calculo, guardo en un dataframe y genero archivos
meses <- c(1:12)
medias_min <- c()
anios_min <- c()
for (mes in meses){
  print(mes)
  medias_mensuales_anios_temp <- media_mensual(datos_altura_1,mes)
  medias_mensuales_temp <- medias_mensuales_anios_temp[[1]]
  anios_temp <- medias_mensuales_anios_temp[[2]]
  media_min_temp <- min(medias_mensuales_temp,na.rm=T)
  medias_min <- c(medias_min,media_min_temp)
  anios_min <- c(anios_min,anios_temp[which(medias_mensuales_temp==media_min_temp)])
}

mi_data_frame_min_medias_mensuales <- data.frame("Anio" = anios_min, 
                                                 "Mes" = meses, 
                                                 "Medias mensuales altura" = medias_min)

install.packages("writexl")
require(writexl)
library(writexl)
write_xlsx(mi_data_frame_min_medias_mensuales, "data_frame_min_mensuales.xlsx")
write.csv(mi_data_frame_min_medias_mensuales, "data_frame_min_mensuales.csv")


