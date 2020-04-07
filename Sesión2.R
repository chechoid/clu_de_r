s <- livecode::serve_file()
usethis::use_git()


#### Sesión 2 Limpieza de Datos ####

# Cargar librería
library(tidyverse)

# Cargar los datos
atencion_ciudadano <- read.csv("http://bitsandbricks.github.io/data/gcba_suaci_barrios.csv")


# Exploración de los datos

str(atencion_ciudadano) # Explorar la estructura del dataset

summary(atencion_ciudadano)

# Explora los niveles de las variables de tipo factor
levels(atencion_ciudadano$BARRIO)

# Agregar dataset de comunas para sumarlo al dataset de atencion_ciudano
barrios_comunas <- read.csv("http://bitsandbricks.github.io/data/barrios_comunas.csv")

# Unión de los datasets
atencion_ciudadano <- left_join(atencion_ciudadano, barrios_comunas)

str(atencion_ciudadano)

# Para guardar el dataset nuevo como archivo
write.csv(atencion_ciudadano, "atencion_ciudadano.csv", row.names = FALSE)


#### Seleccionando datos ####

names(atencion_ciudadano)

# Seleccion de columnas por el nombre
seleccion <- select(atencion_ciudadano, PERIODO, total)

seleccion

seleccion_2 <- atencion_ciudadano %>%
  select(PERIODO, total)

seleccion_2

# Eleccion de datos por rango de columnas
seleccion <- select(atencion_ciudadano, RUBRO:BARRIO)

head(seleccion)

# Elegir todas las variables excepto la columna "Rubro"
seleccion <- select(atencion_ciudadano, -RUBRO)

head(seleccion)

# Omitir varias columnas CONTIGUAS
seleccion <- select(atencion_ciudadano, -(TIPO_PRESTACION:total))

head(seleccion)

# Seleccionar todo menos las columnas Rubro y Barrio
seleccion <- select(atencion_ciudadano, -RUBRO, -BARRIO)

head(seleccion)

##### Filtrando datos ####
seleccion <- filter(atencion_ciudadano, BARRIO == "RETIRO", PERIODO == 201401)
head(seleccion)

seleccion <- filter(atencion_ciudadano, total > 100)
head(seleccion)

seleccion <- filter(atencion_ciudadano, PERIODO == 201508,  RUBRO == "SALUD")

head(seleccion)

seleccion <- filter(atencion_ciudadano, BARRIO == "RETIRO", BARRIO == "PALERMO")

head(seleccion)

seleccion <- filter(atencion_ciudadano, BARRIO == "RETIRO" | BARRIO == "PALERMO")

head(seleccion)

filter(atencion_ciudadano, TIPO_PRESTACION == "TRAMITE" & !(RUBRO == "REGISTRO CIVIL"))

seleccion <- filter(atencion_ciudadano, !(TIPO_PRESTACION == "DENUNCIA" & RUBRO == "SEGURIDAD E HIGIENE"))

head(seleccion)

##### Summarise ####
agrupado <- group_by(atencion_ciudadano, PERIODO)

sumario <- summarise(agrupado, promedio = mean(total))

head(sumario)

agrupado <- atencion_ciudadano %>%
  group_by(PERIODO) %>%
  summarise(promedio = mean(total))
head(agrupado)

