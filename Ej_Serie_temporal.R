
### Ejercicio series temporales ###

#Cargo las librerias
require(ncdf4)
require(ggplot2)
require(lubridate)

#Abro el archivo ncdf
archivo = "~/PracticasLabo/air.mon.mean.nc"
nc = nc_open(archivo)
nc

#Cargo las variables
var = ncvar_get(nc, "air")
lats = ncvar_get(nc, "lat")
lons = ncvar_get(nc, "lon")
time = ncvar_get(nc, "time")

#Ecribo bien el tiempo
tiempo = as.Date(time/24, "1800-01-01 00:00:00")
head(tiempo)
tail(tiempo)

#Calculo el promedio anual
anios <- c(1948:2021)
medias_anuales <- c()
for (i in 1:length(anios)) {
  anio = anios[i]
  medias_anuales[i] <- round(mean(var[,,year(tiempo) == anio]),2)
}
medias_anuales

#Acomodo los datos en un data frame
df_medias = data.frame("Anio" = anios, "Media_anual" = medias_anuales)
df_medias

#Armo el grafico de la serie temporal
 #Hago el grafico
grafico = ggplot(data = df_medias, mapping = aes(x = Anio, y = Media_anual))
 #Agrego las lineas y los puntos
grafico = grafico + geom_line(color = "black")
grafico = grafico + geom_point(color = "black")
 #Agrego la linea de tendencia lineal
grafico = grafico + geom_smooth(method = "lm", color = "darkgrey", se = F)
 #Le pongo titulo y nombres a los ejes
grafico = grafico + labs(title = "Temperatura del aire",
                         subtitle = "Periodo 1948-2021",
                         x = "Año",
                         y = "Media de la temperatura del aire (°C)")

#Veo el grafico terminado
grafico
