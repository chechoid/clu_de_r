#### Análisis Encuesta Sysarmy ####
library(googlesheets4) # Para leer las hojas de cálculo de Google
# devtools::install_github("r-lib/gargle")
library(gargle)
library(tidyverse)
options(scipen = 999) # Cambia la notación científica de los gráficos

# Carga el archivo desde google sheets. El parámetro 'skip' indica que omita las primeras nueve filas
encuesta_sysarmy <- sheets_read("1_db6zEAMvr-1GQjJb4hV-rSQfJ9w6GmezbqKJ2JJn7I", skip = 9)
             
glimpse(encuesta_sysarmy)

# Analicemos primero puestos y sueldos brutos
analisis_1 <- encuesta_sysarmy %>%
  select("Trabajo de", `Salario mensual BRUTO (en tu moneda local)`)
head(analisis_1)

# Cambiemos el nombre de las variables para hacerlo más cómodo para trabajar
analisis_1 <- analisis_1 %>%
  rename("Puesto" = "Trabajo de",
         "Sueldo_Bruto" = `Salario mensual BRUTO (en tu moneda local)`)

head(analisis_1)

# Analicemos la distribución de los sueldos con un histograma
ggplot(analisis_1, aes(x = Sueldo_Bruto)) +
  geom_histogram()

# Evidentemente hay un problema con los datos porque nos aparecen casi todos agrupados cerca del 0.
# Exploremos los datos

summary(analisis_1)

# Hay un problema con los sueldos. Tenemos respuestas que van desde $ 1 hasta 6 cuatrillones de pesos.
# Hagamos un filtro de los sueldos entre $ 20.000 y $ 1.000.000

analisis_1 <- analisis_1 %>%
  filter(between(Sueldo_Bruto, 20000, 1000000))

summary(analisis_1)

# Realicemos nuevamente el histograma
ggplot(analisis_1, aes(x = Sueldo_Bruto)) +
  geom_histogram()

# Otro tipo de gráfico utilizado en análisis estadístico es el boxplot
ggplot(analisis_1, aes(x = Sueldo_Bruto)) +
  geom_boxplot() +
  coord_flip()

# Hagamos un análisis de los puestos con sueldos entre $ 20.000 y $ 200.000 e incluyamos los años de experiencia
analisis_2 <- encuesta_sysarmy %>%
  select("Trabajo de", "Años de experiencia", `Salario mensual BRUTO (en tu moneda local)`) %>%
  rename("Puesto" = "Trabajo de",
         "Experiencia" = "Años de experiencia",
         "Sueldo_Bruto" = `Salario mensual BRUTO (en tu moneda local)`) %>%
  filter(between(Sueldo_Bruto, 20000, 200000))

head(analisis_2)

# Por alguna razón los datos en "Experiencia" se importaron como lista. Así que debemos hacer una transformación previa
analisis_2$Experiencia <- as.numeric(unlist(analisis_2$Experiencia))

head(analisis_2)

analisis_2 %>%
  group_by(Puesto) %>%
  ggplot(aes(x = reorder(Puesto, Sueldo_Bruto), y = Sueldo_Bruto)) +
  geom_col() +
  coord_flip()

# Hay mucha basura en los datos, así que filtremos los puestos que tienen mayor cantidad de respuestas.
analisis_2 %>%
  group_by(Puesto) %>%
  tally(sort = TRUE) %>%
  top_n(5)

# Creemos un data frame con los 3 puestos más frecuentes:
analisis_puestos <- analisis_2 %>%
  filter(Puesto %in% c("Developer", "SysAdmin / DevOps / SRE", "QA / Tester"))

# Veamos cuál es el sueldo promedio de cada posición
analisis_puestos %>%
  group_by(Puesto) %>%
  summarise(Sueldo_Promedio = mean(Sueldo_Bruto)) %>%
  ggplot(aes(x = reorder(Puesto, Sueldo_Promedio), y = Sueldo_Promedio)) +
  geom_col()

# Por último hagamos un scatterplot, que nos permite analizar los datos por dos variables numéricas
ggplot(analisis_puestos, aes(x=Sueldo_Bruto, y = Experiencia, color=Puesto))+
  geom_point(alpha=0.4)

# Separemos los gráficos por puesto
ggplot(analisis_puestos, aes(x=Sueldo_Bruto, y = Experiencia, color=Puesto))+
  geom_point(alpha=0.4) +
  facet_wrap(~Puesto, ncol = 1)
