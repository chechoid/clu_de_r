s <- livecode::serve_file()

# Cargar paquete
library(tidyverse)

# Cargar el dataset
atencion_ciudadano <- read.csv("http://bitsandbricks.github.io/data/gcba_suaci_comunas.csv")        

# Agrupa los datos por comuna y saca la suma de trámites por comuna, en miles

contactos_por_comuna <- atencion_ciudadano %>% 
  group_by(COMUNA) %>% 
  summarise(miles_contactos = sum(total) / 1000 )

contactos_por_comuna

# Cargar los habitantes por comuna

habitantes <- read.csv("http://bitsandbricks.github.io/data/gcba_pob_comunas_17.csv")

habitantes

# Uniendo los datasets por Comuna

contactos_por_comuna <- contactos_por_comuna %>%
  left_join(habitantes)

contactos_por_comuna

ggplot(contactos_por_comuna)
plot(contactos_por_comuna)

ggplot(contactos_por_comuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos))

# Agregamos color al gráfico
ggplot(contactos_por_comuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos, color = factor(COMUNA)))

# cambio el color por la etiqueta de la comuna
ggplot(contactos_por_comuna) +
  geom_label(aes(x = POBLACION, y = miles_contactos, label = factor(COMUNA)))

# Grafica los puntos por tamaño representa la cantidad de contactos
ggplot(contactos_por_comuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos, size = miles_contactos))


# Cambiar el color de los puntos
ggplot(contactos_por_comuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos), color = "blue")

ggplot(contactos_por_comuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos), color = "darkolivegreen4")

# Cambiar el color por un código HEX de colores, recordar siempre las comillas y el símbolo #
ggplot(contactos_por_comuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos,size= miles_contactos), color = "#7F00FF" )

# Cambiar el tamaño de la burbuja
ggplot(contactos_por_comuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos), size = 5)

# Cambiar la forma de los puntos
ggplot(contactos_por_comuna) + 
  geom_point(aes(x = POBLACION, y = miles_contactos), 
             size = 9, color = "chocolate3", shape = 0)


#### Facetado ####

summary(atencion_ciudadano)

contactos_por_comuna_y_tipo <- atencion_ciudadano %>% 
  group_by(COMUNA, TIPO_PRESTACION) %>% 
  summarise(miles_contactos = sum(total) / 1000 ) %>% 
  left_join(habitantes)

head(contactos_por_comuna_y_tipo)

# Gráfico
ggplot(contactos_por_comuna_y_tipo) + 
  geom_point(aes(x = POBLACION, y = miles_contactos)) +
  facet_wrap(~TIPO_PRESTACION)

#### Gráfico de Barras ####
ggplot(atencion_ciudadano) +
  geom_bar(aes(x = BARRIO, weight = total))

ggplot(atencion_ciudadano) +
  geom_bar(aes(x = BARRIO, weight = total)) +
  coord_flip()


# Ordenando el gráfico de barras
ggplot(atencion_ciudadano) +
  geom_bar(aes(x = reorder(BARRIO, total), weight = total)) +
  coord_flip()

head(atencion_ciudadano)

# Hacemos una transformación para ordenar los datos agrupados por barrio
ate_ciu <- atencion_ciudadano %>%
  group_by(BARRIO) %>%
  summarise(todos = sum(total))

# Hacemos el gráfico ordenado
ggplot(ate_ciu) +
  geom_bar(aes(x=reorder(BARRIO,todos), weight= todos))+
  coord_flip()

# Agregamos color por tipo de trámite
ggplot(atencion_ciudadano) +
  geom_bar(aes(x = BARRIO, weight = total, fill = TIPO_PRESTACION)) +
  coord_flip()


# Cambiando las categorias del gráfico
ggplot(atencion_ciudadano) +
  geom_bar(aes(x = TIPO_PRESTACION, weight = total)) 

# Hay que tener mucho cuidado a qué le asignamos los colores
ggplot(atencion_ciudadano) +
  geom_bar(aes(x = TIPO_PRESTACION, weight = total, fill = BARRIO)) 

ggplot(atencion_ciudadano) +
  geom_bar(aes(x = TIPO_PRESTACION, weight = total)) +
  facet_wrap(~BARRIO)

####Histogramas ####

contactos_por_mes <- atencion_ciudadano %>% 
  group_by(PERIODO) %>% 
  summarise(gran_total = sum(total))

head(contactos_por_mes)

ggplot(contactos_por_mes) + 
  geom_histogram(aes(x = gran_total,color = "blue"), bins = 10 )

mean(contactos_por_mes$gran_total)


#### Compartiendo o publicando gráficos ####
options(scipen = 999) # Cambia la notación científica de los gráficos

ggplot(atencion_ciudadano) +
  geom_bar(aes(x = BARRIO, weight = total, fill = TIPO_PRESTACION)) +
  coord_flip() +
  labs(title = "Contactos realizados al Sistema Único de Atención Ciudadana",
       subtitle = "Ciudad Autónoma de Buenos Aires, 2013 - 2015",
       caption = "Fuente: portal de datos abiertos de la Ciudad - http://data.buenosaires.gob.ar",
       x = "barrio",
       y = "cantidad",
       fill = "Motivo del contacto")
