Clú de R
================
Sergio García Mora
28/3/2020

``` r
# s <- livecode::serve_file()
```

# Sesión 1 del Clú de R

Estos son ejercicios tomados del libro **Ciencia de datos para gente
sociable** que escribió <Antonio Vazquez Brust>[Antonio Vazquez
Brust](https://www.linkedin.com/in/avazquez/?originalSubdomain=ar) y que
se puede leer gratis en la <web del libro>[web del
libro](https://bitsandbricks.github.io/ciencia_de_datos_gente_sociable/)
y encontrar en su <blog personal>[blog
personal](https://bitsandbricks.github.io/).

Elegimos este libro primero porque está en español, y segundo porque
para introducir el lenguaje R comienza con un ejemplo muy entrenido y
cercano, mucho más comprensible que los clásicos datasets *iris* o
*mtcars*.

# Empezando

Para instalar paquetes en R

*install.packages(“ggplot2”)*

Luego, se carga el paquete para poder usarlo

``` r
library(ggplot2)
```

Con el símbolo **“\<-”** (como una flecha hacia la izquierda) se asignan
cosas a los objetos. Luego ejecuto el nombre con las teclas Ctrl+Enter y
veo el resultado de lo que asigné.

``` r
tipico <- "Hola Mundo"
tipico
```

    ## [1] "Hola Mundo"

También se puede usar el signo igual, aunque puede confundir después
cuando tipeamos código

``` r
tipica = "Hola Mundo"

tipica
```

    ## [1] "Hola Mundo"

Dos signos iguales se usan para analizar si dos cosas son iguales

``` r
tipico == tipica
```

    ## [1] TRUE

Para más información, ver los operadores relacionales en este
<link>[link](https://bookdown.org/jboscomendoza/r-principiantes4/operadores-relacionales.html).

Se usa el numeral o hashtag (\#) para hacer comentarios

*\#library(tidyverse)*

# Libro Ciencia de Datos Capítulo 2

Cargo los datos que vamos a usar de esta url y lo asigno al objeto
mortalidad

``` r
mortalidad <- read.csv('https://bitsandbricks.github.io/data/mortalidad_infantil_caba_2016.csv')
```

A partir de ahora, cada vez necesite estos datos, sólo invoco el nombre
del objeto

``` r
mortalidad
```

    ##    Comuna Tasa2016
    ## 1       1      9.5
    ## 2       2      3.6
    ## 3       3      8.0
    ## 4       4     11.9
    ## 5       5      8.5
    ## 6       6      2.4
    ## 7       7      8.5
    ## 8       8      9.7
    ## 9       9     10.1
    ## 10     10      3.6
    ## 11     11      6.2
    ## 12     12      7.1
    ## 13     13      4.5
    ## 14     14      3.2
    ## 15     15      6.4

Funciones para explorar datasets

``` r
dim(mortalidad) # De dimensión, nos dice la cantidad de columnas y de filas
```

    ## [1] 15  2

``` r
names(mortalidad) # Nos da los nombres de las variables, muy útil cuando tenemos muchas columnas
```

    ## [1] "Comuna"   "Tasa2016"

``` r
head(mortalidad) # Te muestra las primeras 6 filas
```

    ##   Comuna Tasa2016
    ## 1      1      9.5
    ## 2      2      3.6
    ## 3      3      8.0
    ## 4      4     11.9
    ## 5      5      8.5
    ## 6      6      2.4

``` r
tail(mortalidad) # Te muestra las últimas 6 filas
```

    ##    Comuna Tasa2016
    ## 10     10      3.6
    ## 11     11      6.2
    ## 12     12      7.1
    ## 13     13      4.5
    ## 14     14      3.2
    ## 15     15      6.4

``` r
head(mortalidad, 10) # Tanto con head() como con tail() puedo indicar la cantidad de columnas que quiero ver
```

    ##    Comuna Tasa2016
    ## 1       1      9.5
    ## 2       2      3.6
    ## 3       3      8.0
    ## 4       4     11.9
    ## 5       5      8.5
    ## 6       6      2.4
    ## 7       7      8.5
    ## 8       8      9.7
    ## 9       9     10.1
    ## 10     10      3.6

``` r
library(tidyverse)
```

    ## -- Attaching packages ------------------------------------------------------------------ tidyverse 1.3.0 --

    ## v tibble  2.1.3     v dplyr   0.8.5
    ## v tidyr   1.0.2     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.5.0
    ## v purrr   0.3.3

    ## -- Conflicts --------------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
glimpse(mortalidad) # Indica la cantidad de observaciones, variables, los nombres de columnas, tipo de variables, y una muestra de los primeros registros
```

    ## Observations: 15
    ## Variables: 2
    ## $ Comuna   <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    ## $ Tasa2016 <dbl> 9.5, 3.6, 8.0, 11.9, 8.5, 2.4, 8.5, 9.7, 10.1, 3.6, 6.2, 7...

La función **summary** nos da las principales medidas estadísticas de
las variables numéricas

  - Min y Max (Mínimo y Máximo valor)
  - 1st y 3rd Qu. (Primer y tercer cuartil)
  - Mean y Median (Promedio y mediana)

<!-- end list -->

``` r
summary(mortalidad)
```

    ##      Comuna        Tasa2016    
    ##  Min.   : 1.0   Min.   : 2.40  
    ##  1st Qu.: 4.5   1st Qu.: 4.05  
    ##  Median : 8.0   Median : 7.10  
    ##  Mean   : 8.0   Mean   : 6.88  
    ##  3rd Qu.:11.5   3rd Qu.: 9.00  
    ##  Max.   :15.0   Max.   :11.90

## Nuestro primer gráfico con el paquete ggplot2 (Grammar of graphics plot)

``` r
ggplot(mortalidad, aes(x = factor(Comuna), y = Tasa2016)) +
  geom_col()
```

![](Sesión-1_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

¿Qué pasa si no uso la función factor()

``` r
ggplot(mortalidad, aes(x = Comuna, y = Tasa2016)) +
  geom_col()
```

![](Sesión-1_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

# Análisis geográfico

Carguemos la librería *sf* para análisis espaciales.

``` r
library(sf)
```

    ## Linking to GEOS 3.6.1, GDAL 2.2.3, PROJ 4.9.3

Cargo un dataset con información geográfica de los barrios y comunas de
la Ciudad Autónoma de Buenos Aires

``` r
comunas <- st_read('https://bitsandbricks.github.io/data/CABA_comunas.geojson')
```

    ## Reading layer `CABA_comunas' from data source `https://bitsandbricks.github.io/data/CABA_comunas.geojson' using driver `GeoJSON'
    ## Simple feature collection with 15 features and 4 fields
    ## geometry type:  MULTIPOLYGON
    ## dimension:      XY
    ## bbox:           xmin: -58.53152 ymin: -34.70529 xmax: -58.33514 ymax: -34.52754
    ## CRS:            4326

Exploro el dataset

``` r
names(comunas)
```

    ## [1] "barrios"   "perimetro" "area"      "comunas"   "geometry"

``` r
head(comunas)
```

    ## Simple feature collection with 6 features and 4 fields
    ## geometry type:  MULTIPOLYGON
    ## dimension:      XY
    ## bbox:           xmin: -58.4627 ymin: -34.6625 xmax: -58.33514 ymax: -34.56935
    ## CRS:            4326
    ##                                                                        barrios
    ## 1 CONSTITUCION - MONSERRAT - PUERTO MADERO -  RETIRO - SAN NICOLAS - SAN TELMO
    ## 2                                                                     RECOLETA
    ## 3                                                    BALVANERA - SAN CRISTOBAL
    ## 4                           BARRACAS - BOCA - NUEVA POMPEYA - PARQUE PATRICIOS
    ## 5                                                              ALMAGRO - BOEDO
    ## 6                                                                    CABALLITO
    ##   perimetro     area comunas                       geometry
    ## 1  35572.65 17802807       1 MULTIPOLYGON (((-58.36854 -...
    ## 2  21246.61  6140873       2 MULTIPOLYGON (((-58.39521 -...
    ## 3  10486.26  6385991       3 MULTIPOLYGON (((-58.41192 -...
    ## 4  36277.44 21701236       4 MULTIPOLYGON (((-58.3552 -3...
    ## 5  12323.47  6660526       5 MULTIPOLYGON (((-58.41287 -...
    ## 6  10990.96  6851029       6 MULTIPOLYGON (((-58.43061 -...

Hago un gráfico para ver la Ciudad Autónoma de Buenos Aires

``` r
ggplot(comunas) +
  geom_sf()
```

![](Sesión-1_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

Le asigno un color por Comuna

``` r
ggplot(comunas) +
  geom_sf(aes(fill = comunas))
```

![](Sesión-1_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

Agrega Av. Rivadavia que divide a la ciudad en 2

``` r
rivadavia <- st_read('https://bitsandbricks.github.io/data/avenida_rivadavia.geojson')
```

    ## Reading layer `avenida_rivadavia' from data source `https://bitsandbricks.github.io/data/avenida_rivadavia.geojson' using driver `GeoJSON'
    ## Simple feature collection with 1 feature and 1 field
    ## geometry type:  LINESTRING
    ## dimension:      XY
    ## bbox:           xmin: -58.53014 ymin: -34.63946 xmax: -58.37017 ymax: -34.60711
    ## CRS:            4326

Combino los gráficos de Comuna, incluyendo a la Av. Rivadavia

``` r
ggplot(comunas) +
  geom_sf(aes(fill = comunas)) +
  geom_sf(data = rivadavia, color = "red")
```

![](Sesión-1_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

## Agregar nueva columna

Creamos un vector con la región a la que pertenece cada comuna

``` r
nueva_columna <- c("Sur", "Norte", "Sur", "Sur", "Sur", "Norte", "Sur", "Sur", 
                   "Sur", "Norte", "Norte", "Norte", "Norte", "Norte", "Norte")
```

La función mutate agrega columnas

``` r
comunas <- mutate(comunas, ubicacion = nueva_columna) # "ubicacion" es el nombre de la columna nueva
```

Acá podemos ver que la columna ubicacion se añadió al final de la tabla
comunas

``` r
glimpse(comunas)
```

    ## Observations: 15
    ## Variables: 6
    ## $ barrios   <fct> CONSTITUCION - MONSERRAT - PUERTO MADERO -  RETIRO - SAN ...
    ## $ perimetro <dbl> 35572.65, 21246.61, 10486.26, 36277.44, 12323.47, 10990.9...
    ## $ area      <dbl> 17802807, 6140873, 6385991, 21701236, 6660526, 6851029, 1...
    ## $ comunas   <fct> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    ## $ geometry  <MULTIPOLYGON [°]> MULTIPOLYGON (((-58.36854 -..., MULTIPOLYGON...
    ## $ ubicacion <chr> "Sur", "Norte", "Sur", "Sur", "Sur", "Norte", "Sur", "Sur...

Ahora actualizamos el mapa, coloreando las comunas del Sur y del Norte

``` r
ggplot(comunas) +
  geom_sf(aes(fill = ubicacion)) + 
  geom_sf(data = rivadavia, color = "red")
```

![](Sesión-1_files/figure-gfm/unnamed-chunk-22-1.png)<!-- -->

Agregamos a la tabla de mortalidad la ubicación

``` r
mortalidad <- mutate(mortalidad, ubicación = nueva_columna)

head(mortalidad)
```

    ##   Comuna Tasa2016 ubicación
    ## 1      1      9.5       Sur
    ## 2      2      3.6     Norte
    ## 3      3      8.0       Sur
    ## 4      4     11.9       Sur
    ## 5      5      8.5       Sur
    ## 6      6      2.4     Norte

# Analizar la mortalidad por zona de la ciudad

Graficamos para analizar la mortalidad infantil por Comuna

``` r
ggplot(comunas) +
  geom_sf(aes(fill = mortalidad$Tasa2016)) + # Con el símbolo $ se elige la columna específica a graficar
  geom_sf(data = rivadavia, color = "red") +
  scale_fill_distiller(palette = "Spectral")
```

![](Sesión-1_files/figure-gfm/unnamed-chunk-24-1.png)<!-- -->

Si bien los mapas son llamativos, a veces los gráficos de barra son más
claros

``` r
ggplot(mortalidad) +
  geom_col(aes(x = Comuna, y = Tasa2016, fill = ubicación)) +
  labs(title = "Mortalidad infantil en la Ciudad Autónoma de Buenos Aires", # con esta función le agregamos un título al gráfico
       subtitle = "Año 2016",
       y = "tasa") 
```

![](Sesión-1_files/figure-gfm/unnamed-chunk-25-1.png)<!-- -->

Dividimos los datos por zona

``` r
comunas_al_sur <- filter(mortalidad, ubicación == "Sur")

comunas_al_norte <- filter(mortalidad, ubicación == "Norte")
```

Calculamos la diferencia entre el promedio de mortalidad de unas y
otras.

``` r
mean(comunas_al_sur$Tasa2016) / mean(comunas_al_norte$Tasa2016)
```

    ## [1] 2.044788
