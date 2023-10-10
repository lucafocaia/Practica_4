
install.packages("gdata")

xlsfile <- file.path(path.package('gdata'),'xls','iris.xls')
xlsfile

iris <- read.xls(xlsfile)
iris1 <- read.xls(xlsfile,method="csv")
iris2 <- read.xls(xlsfile,method="tab")

class(iris)
class(iris1)
class(iris2)

head(iris)

exampleFile <- file.path(path.package('gdata'),'xls', 'ExampleExcelFile.xls')
exampleFile2007 <- file.path(path.package('gdata'),'xls', 'ExampleExcelFile.xlsx')

sheetCount(exampleFile)
if( 'XLSX' %in% xlsFormats())
sheetCount(exampleFile2007)

sheetNames(exampleFile)
if( 'XLSX' %in% xlsFormats())
sheetNames(exampleFile2007)

data <- read.xls(exampleFile)
data1 <- read.xls(exampleFile, sheet=2)
data2 <- read.xls(exampleFile, sheet="Sheet Second",v=TRUE) 

if( 'XLSX' %in% xlsFormats())
data3 <- read.xls(exampleFile2007, sheet="Sheet with initial text", skip=2)

###############################3

meteo <- file.path("datos.xls")

sheetCount(meteo)
sheetCount("datos.xls")

sheetNames(meteo)

meteo_0 <- read.xls(meteo, sheet = 2)
meteo_1 <- read.xls("datos.xls", sheet = 2)

class(meteo_0)
class(meteo_1)

correlacion <- cor(meteo_1[,1],meteo_1[,2])

meteo_2 <- read.xls(meteo, sheet= 3, skip = 1)
colnames(meteo_2) <- c("Año","Mes","T Max (°C)","T Min (°C)","PP (mm)")

plot(meteo_2[,3], type = "l")
plot(meteo_2[1:12,5], type = "h")

medias <- apply(meteo_2[,3:5],2,mean)

media_onda <- matrix(0, nrow = 12, ncol = 3)
for (i in 1:12) {
  a=which(meteo_2[,2]==i)
  media_onda[i,1:3] <- apply(meteo_2[a,3:5],2,mean)
}

plot(media_onda[,1],type="l",col="red",ylim=c(0,30))
lines(media_onda[,2],type="l",col="blue")

plot(meteo_1[,1],type="l",col="red")
lines(meteo_1[,2],type="l",col="violet")







