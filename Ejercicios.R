#### Ejercicios Capítulo 2 ####
# Ejercicios sugeridos del libro "Ciencia de Datos para gente sociable"

# Descargué datos de la página del Banco Mundial
# https://databank.bancomundial.org/source/gender-statistics/preview/on#
# Este archivo tiene información sobre el porcentaje de participación femenina en la fuerza de trabajo de cada país

library(readr) # Paquete para leer archivos
library(tidyverse)

# Para levantar un archivo hay que especificar toda la ubicación
participacion <- read_csv("C:/Users/Usuario/Documents/R/Clu_de_R/Ratio_Participacion_Laboral_Femenina.csv")

# Pero si el archivo lo guardamos en la carpeta del proyecto solo ponemos el nombre del archivo
part_femenina <- read_csv("Ratio_Participacion_Laboral_Femenina.csv")

# El ejercicio nos pide relevar algunos datos del dataset
dim(part_femenina)
names(part_femenina)
glimpse(part_femenina)
str(part_femenina)
part_femenina <- as_tibble(part_femenina)
str(part_femenina)

# Seleccionamos columnas
part_fem <- select(part_femenina, `país Name`:`2019 [YR2019]`)
str(part_fem)


# Una forma de solucionarlo por fuerza bruta (columna por columna)
part_fem$`2010 [YR2010]` <- as.numeric(part_fem$`2010 [YR2010]`)
glimpse(part_fem)


str(part_fem)

#### Ejercicios Capítulo 3 ####
# Ejercicios sugeridos del libro "Ciencia de Datos para gente sociable"

# Como tenemos datos que son texto y otros numéricos, los dividimos para transformarlos
cols_char <- part_fem %>% select(1:2) %>%
  mutate_if(is.character, as.factor)

# Solución provista por Pablo de Innocentis
# Usando la función mutate_if() cambia todo lo que sea character (chr) a numerico
part_fem2 <- part_fem %>% select(3:12) %>%
  mutate_if(is.character, as.numeric) %>% 
  cbind(cols_char) %>% # Esta función une las columnas de ambos data frames
  select('país Name', 'país Code', everything()) # Reorganiza el dataset poniendo los nombres por delante

str(part_fem2)
names(part_fem2)

# Elijo los países del Cono Sur y los últimos 5 años de informe
conosur <- part_fem2 %>%
  select("país Name", "2015 [YR2015]":"2019 [YR2019]") %>%
  rename("Country" = "país Name",
         '2015'='2015 [YR2015]',
         '2016'='2016 [YR2016]',
         '2017'="2017 [YR2017]",
         '2018'="2018 [YR2018]", 
         '2019'="2019 [YR2019]") %>%
  filter(Country %in% c("Argentina","Chile", "Brazil", "Uruguay", "Paraguay", 'Peru')) %>%
  pivot_longer(-Country, names_to = 'Year', values_to = "Female Ratio")

conosur

# Hago un gráfico de barras para comparar la participación femenina en la fuerza de trabajo por país.
# Este link es muy útil (http://www.cookbook-r.com/Graphs/Bar_and_line_graphs_(ggplot2)/) para tener de refeencia

# Gráfico de barras
conosur %>%
  group_by(Country) %>%
  summarise(Avg_Ratio = mean(`Female Ratio`)) %>%
  ggplot(aes(x = Country, y = Avg_Ratio))+
  geom_col()

# Cambiemos el orden del gráfico y hagamóslo más legible
conosur %>%
  group_by(Country) %>%
  summarise(Avg_Ratio = mean(`Female Ratio`)) %>%
  ggplot(aes(x = reorder(Country, Avg_Ratio), y = Avg_Ratio))+
  geom_col() +
  coord_flip() 
  
# Mejoro el aspecto del gráfico
conosur %>%
  group_by(Country) %>%
  summarise(Avg_Ratio = mean(`Female Ratio`)) %>%
  ggplot(aes(x = reorder(Country, Avg_Ratio), y = Avg_Ratio))+
  geom_col(fill="#5499C7") +
  coord_flip() +
  theme(panel.background = element_blank(),
        panel.grid.major.y = element_line(colour = "#F4F6F6"),
        axis.title = element_blank(),
        axis.line = element_line(colour = "grey"))

#Asigno las configuración del gráfico a un objeto
estilo <- theme(panel.background = element_blank(),
                panel.grid.major.y = element_line(colour = "#F4F6F6"),
                axis.title = element_blank(),
                axis.line = element_line(colour = "grey"))

# Para analizar la evolución por país en los últimos 5 años.
conosur %>%
  group_by(Country) %>%
  ggplot(aes(x= factor(Year), y= `Female Ratio`, group=Country, color = Country))+
  geom_line(size = 1) +
  estilo

# Hagamos un gráfico separado por país
conosur %>%
  group_by(Country) %>%
  ggplot(aes(x= factor(Year), y= `Female Ratio`, group=Country, color = Country))+
  geom_line(size = 1) +
  estilo + theme(axis.text.x = element_text(angle=90)) +
  facet_wrap(~Country)
