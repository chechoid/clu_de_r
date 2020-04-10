Ejercicios del Clú de R
================
Sergio García Mora

# Ejercicios Capítulo 2

Descargué datos de la página del Banco Mundial de este link
[link](https://databank.bancomundial.org/source/gender-statistics/preview/on#)
en formato csv. Los datos indican el ratio de participación femenina en
la fuerza laboral de cada país.

Luego uso un paquete para leer archivos (también podría usarlo para leer
archivos Excel)

``` r
library(readr)
library(tidyverse)
```

Para levantar un archivo hay dos opciones:

  - Especificar toda la ubicación

<!-- end list -->

``` r
participacion <- read_csv("C:/Users/Usuario/Documents/R/Clu_de_R/Ratio_Participacion_Laboral_Femenina.csv")
```

  - Pero si el archivo lo guardamos en la carpeta del proyecto solo
    ponemos el nombre del archivo

<!-- end list -->

``` r
part_fem <- read_csv("Ratio_Participacion_Laboral_Femenina.csv")
```

El ejercicio nos pide relevar algunos datos del dataset

``` r
dim(part_fem)
```

    ## [1] 222  14

``` r
names(part_fem)
```

    ##  [1] "serie Name"    "serie Code"    "país Name"     "país Code"    
    ##  [5] "2010 [YR2010]" "2011 [YR2011]" "2012 [YR2012]" "2013 [YR2013]"
    ##  [9] "2014 [YR2014]" "2015 [YR2015]" "2016 [YR2016]" "2017 [YR2017]"
    ## [13] "2018 [YR2018]" "2019 [YR2019]"

``` r
glimpse(part_fem)
```

    ## Observations: 222
    ## Variables: 14
    ## $ `serie Name`    <chr> "Ratio of female to male labor force participation ...
    ## $ `serie Code`    <chr> "SL.TLF.CACT.FM.ZS", "SL.TLF.CACT.FM.ZS", "SL.TLF.C...
    ## $ `país Name`     <chr> "Afghanistan", "Albania", "Algeria", "American Samo...
    ## $ `país Code`     <chr> "AFG", "ALB", "DZA", "ASM", "AND", "AGO", "ATG", "A...
    ## $ `2010 [YR2010]` <chr> "51.6722279216976", "72.5469959865247", "20.5279390...
    ## $ `2011 [YR2011]` <chr> "52.4590141977086", "73.1303625392493", "21.9304060...
    ## $ `2012 [YR2012]` <chr> "53.486820605636", "73.8176295714549", "23.44040050...
    ## $ `2013 [YR2013]` <chr> "54.6682696056433", "71.2735076319824", "24.0494612...
    ## $ `2014 [YR2014]` <chr> "55.8981079197497", "70.1120839770832", "22.7576188...
    ## $ `2015 [YR2015]` <chr> "57.1107456287743", "73.1664590939729", "22.5240571...
    ## $ `2016 [YR2016]` <chr> "58.1045390474797", "72.9453925014733", "22.2648627...
    ## $ `2017 [YR2017]` <chr> "59.0081285907901", "72.7921697877114", "22.0187957...
    ## $ `2018 [YR2018]` <chr> "59.244646865329", "72.7335765539295", "22.12334403...
    ## $ `2019 [YR2019]` <chr> "59.4791057905014", "72.7097264648987", "22.2093205...

Cuando ejecutamos glimpse vemos que datos numéricos aparecen como *chr*,
¿qué pasa si ejecutamos la función summary?

``` r
summary(part_fem)
```

    ##   serie Name         serie Code         país Name          país Code        
    ##  Length:222         Length:222         Length:222         Length:222        
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##  2010 [YR2010]      2011 [YR2011]      2012 [YR2012]      2013 [YR2013]     
    ##  Length:222         Length:222         Length:222         Length:222        
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##  2014 [YR2014]      2015 [YR2015]      2016 [YR2016]      2017 [YR2017]     
    ##  Length:222         Length:222         Length:222         Length:222        
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##  2018 [YR2018]      2019 [YR2019]     
    ##  Length:222         Length:222        
    ##  Class :character   Class :character  
    ##  Mode  :character   Mode  :character

Una forma posible de solucionarlo, y cuando vemos los 6 primeros
registros vemos que la columna que hace referencia al año 2010 aparece
como una columna numérica.

``` r
part_fem$`2010 [YR2010]` <- as.numeric(part_fem$`2010 [YR2010]`)
```

    ## Warning: NAs introducidos por coerción

``` r
glimpse(part_fem)
```

    ## Observations: 222
    ## Variables: 14
    ## $ `serie Name`    <chr> "Ratio of female to male labor force participation ...
    ## $ `serie Code`    <chr> "SL.TLF.CACT.FM.ZS", "SL.TLF.CACT.FM.ZS", "SL.TLF.C...
    ## $ `país Name`     <chr> "Afghanistan", "Albania", "Algeria", "American Samo...
    ## $ `país Code`     <chr> "AFG", "ALB", "DZA", "ASM", "AND", "AGO", "ATG", "A...
    ## $ `2010 [YR2010]` <dbl> 51.67223, 72.54700, 20.52794, NA, NA, 93.58976, NA,...
    ## $ `2011 [YR2011]` <chr> "52.4590141977086", "73.1303625392493", "21.9304060...
    ## $ `2012 [YR2012]` <chr> "53.486820605636", "73.8176295714549", "23.44040050...
    ## $ `2013 [YR2013]` <chr> "54.6682696056433", "71.2735076319824", "24.0494612...
    ## $ `2014 [YR2014]` <chr> "55.8981079197497", "70.1120839770832", "22.7576188...
    ## $ `2015 [YR2015]` <chr> "57.1107456287743", "73.1664590939729", "22.5240571...
    ## $ `2016 [YR2016]` <chr> "58.1045390474797", "72.9453925014733", "22.2648627...
    ## $ `2017 [YR2017]` <chr> "59.0081285907901", "72.7921697877114", "22.0187957...
    ## $ `2018 [YR2018]` <chr> "59.244646865329", "72.7335765539295", "22.12334403...
    ## $ `2019 [YR2019]` <chr> "59.4791057905014", "72.7097264648987", "22.2093205...

``` r
head(part_fem)
```

    ## # A tibble: 6 x 14
    ##   `serie Name` `serie Code` `país Name` `país Code` `2010 [YR2010]`
    ##   <chr>        <chr>        <chr>       <chr>                 <dbl>
    ## 1 Ratio of fe~ SL.TLF.CACT~ Afghanistan AFG                    51.7
    ## 2 Ratio of fe~ SL.TLF.CACT~ Albania     ALB                    72.5
    ## 3 Ratio of fe~ SL.TLF.CACT~ Algeria     DZA                    20.5
    ## 4 Ratio of fe~ SL.TLF.CACT~ American S~ ASM                    NA  
    ## 5 Ratio of fe~ SL.TLF.CACT~ Andorra     AND                    NA  
    ## 6 Ratio of fe~ SL.TLF.CACT~ Angola      AGO                    93.6
    ## # ... with 9 more variables: `2011 [YR2011]` <chr>, `2012 [YR2012]` <chr>,
    ## #   `2013 [YR2013]` <chr>, `2014 [YR2014]` <chr>, `2015 [YR2015]` <chr>, `2016
    ## #   [YR2016]` <chr>, `2017 [YR2017]` <chr>, `2018 [YR2018]` <chr>, `2019
    ## #   [YR2019]` <chr>

# Ejercicios Capítulo 3 del libro “Ciencia de Datos para gente sociable”

## Seleccionando y transformando datos

Cargo de nuevo los datos

``` r
library(readr)
library(tidyverse)
part_fem <- read_csv("Ratio_Participacion_Laboral_Femenina.csv")
```

Como tenemos datos que son texto y otros numéricos, separamos las
columnas numéricas de las columnas que contienen texto para
transformarlos

``` r
cols_char <- part_fem %>% select(3:4) %>%
  mutate_if(is.character, as.factor)
cols_char
```

    ## # A tibble: 222 x 2
    ##    `país Name`         `país Code`
    ##    <fct>               <fct>      
    ##  1 Afghanistan         AFG        
    ##  2 Albania             ALB        
    ##  3 Algeria             DZA        
    ##  4 American Samoa      ASM        
    ##  5 Andorra             AND        
    ##  6 Angola              AGO        
    ##  7 Antigua and Barbuda ATG        
    ##  8 Argentina           ARG        
    ##  9 Armenia             ARM        
    ## 10 Aruba               ABW        
    ## # ... with 212 more rows

Antes vimos que podíamos cambiar el tipo de variable columna por
columna, lo cual no es eficiente. [Pablo de
Innocentis](https://www.linkedin.com/in/padeinnocentiis/) aportó esta
solución.

Usando la función mutate\_if() cambia todo lo que sea character (chr) a
numerico

``` r
part_fem2 <- part_fem %>% select(5:14) %>%
  mutate_if(is.character, as.numeric) %>% 
  cbind(cols_char) %>% # Esta función une las columnas de ambos data frames
  select('país Name', 'país Code', everything()) # Reorganiza el dataset poniendo los nombres por delante
```

    ## Warning: NAs introducidos por coerción
    
    ## Warning: NAs introducidos por coerción
    
    ## Warning: NAs introducidos por coerción
    
    ## Warning: NAs introducidos por coerción
    
    ## Warning: NAs introducidos por coerción
    
    ## Warning: NAs introducidos por coerción
    
    ## Warning: NAs introducidos por coerción
    
    ## Warning: NAs introducidos por coerción
    
    ## Warning: NAs introducidos por coerción
    
    ## Warning: NAs introducidos por coerción

La función *cbind* lo que hace es unir los dos data frames que creamos
cuando separamos el data frame original para transformar las variables.
Lo que hace es pegar las columnas de un objeto, al lado de las columnas
del otro objeto. Por esta razón es importante verificar siempre que
ambos datasets tengan la misma cantidad de filas.

El último *select* que usamos en la función lo que hace es organizar el
nuevo conjunto de datos en el orden que querramos: en este caso pone
*‘Pais Name’* primero, luego *‘País Code’* y con la función
*everything()* le decimos a R que ponga todas las columnas que faltan a
continuación.

Veamos cómo quedó el dataset

``` r
glimpse(part_fem2)
```

    ## Observations: 222
    ## Variables: 12
    ## $ `país Name`     <fct> "Afghanistan", "Albania", "Algeria", "American Samo...
    ## $ `país Code`     <fct> AFG, ALB, DZA, ASM, AND, AGO, ATG, ARG, ARM, ABW, A...
    ## $ `2010 [YR2010]` <dbl> 51.67223, 72.54700, 20.52794, NA, NA, 93.58976, NA,...
    ## $ `2011 [YR2011]` <dbl> 52.45901, 73.13036, 21.93041, NA, NA, 93.53113, NA,...
    ## $ `2012 [YR2012]` <dbl> 53.48682, 73.81763, 23.44040, NA, NA, 93.55563, NA,...
    ## $ `2013 [YR2013]` <dbl> 54.66827, 71.27351, 24.04946, NA, NA, 93.65208, NA,...
    ## $ `2014 [YR2014]` <dbl> 55.89811, 70.11208, 22.75762, NA, NA, 93.76980, NA,...
    ## $ `2015 [YR2015]` <dbl> 57.11075, 73.16646, 22.52406, NA, NA, 93.90388, NA,...
    ## $ `2016 [YR2016]` <dbl> 58.10454, 72.94539, 22.26486, NA, NA, 93.97804, NA,...
    ## $ `2017 [YR2017]` <dbl> 59.00813, 72.79217, 22.01880, NA, NA, 94.10319, NA,...
    ## $ `2018 [YR2018]` <dbl> 59.24465, 72.73358, 22.12334, NA, NA, 94.16260, NA,...
    ## $ `2019 [YR2019]` <dbl> 59.47911, 72.70973, 22.20932, NA, NA, 94.22796, NA,...

Elijo los países del Cono Sur y los últimos 5 años de informe

``` r
conosur <- part_fem2 %>%
  select(`país Name`, `2015 [YR2015]`:`2019 [YR2019]`) %>%
  rename("Country" = `país Name`,
         "2015"=`2015 [YR2015]`,
         "2016"=`2016 [YR2016]`,
         "2017"=`2017 [YR2017]`,
         "2018"=`2018 [YR2018]`, 
         "2019"=`2019 [YR2019]`) %>%
  filter(Country %in% c("Argentina","Chile", "Brazil", "Uruguay", "Paraguay", 'Peru')) %>%
  pivot_longer(-Country, names_to = 'Year', values_to = "Female Ratio")
```

Veamos nuestro nuevo conjunto de datos

``` r
conosur
```

    ## # A tibble: 30 x 3
    ##    Country   Year  `Female Ratio`
    ##    <fct>     <chr>          <dbl>
    ##  1 Argentina 2015            65.2
    ##  2 Argentina 2016            66.3
    ##  3 Argentina 2017            67.3
    ##  4 Argentina 2018            67.2
    ##  5 Argentina 2019            67.2
    ##  6 Brazil    2015            70.8
    ##  7 Brazil    2016            71.1
    ##  8 Brazil    2017            72.6
    ##  9 Brazil    2018            72.6
    ## 10 Brazil    2019            72.6
    ## # ... with 20 more rows

# Ejercicios Capítulo 4 libro Ciencia de Datos para Gente Sociable

## Visualización

Hago un gráfico de barras para comparar la participación femenina en la
fuerza de trabajo por país. Este link es muy útil
(<http://www.cookbook-r.com/Graphs/Bar_and_line_graphs_(ggplot2)/>) para
tener de referencia.

Primero, hagamos un gráfico de barras:

``` r
conosur %>%
  group_by(Country) %>%
  summarise(Avg_Ratio = mean(`Female Ratio`)) %>%
  ggplot(aes(x = Country, y = Avg_Ratio))+
  geom_col()
```

![](ejercicios_clu_de_r_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

Ordenemos el gráfico con los países con mayor ratio hasta los de menor
ratio y rotemos los ejes para hacerlo más legible.

``` r
conosur %>%
  group_by(Country) %>%
  summarise(Avg_Ratio = mean(`Female Ratio`)) %>%
  ggplot(aes(x = reorder(Country, Avg_Ratio), y = Avg_Ratio))+
  geom_col() +
  coord_flip() 
```

![](ejercicios_clu_de_r_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

Esta es la versión “base” de ggplot2. Una de las ventajas que tiene este
paquete es que es posible customizar todo lo que queramos.

``` r
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
```

![](ejercicios_clu_de_r_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

**R** es un lenguaje por objetos. Por ejemplo, para cambiar el estilo
del gráfico tuvimos que escribir 4 líneas de código. Si tenemos que
escribir (o copiar o pegar) estas líneas cada vez que hacemos un gráfico
se vuelve tedioso y hace más difícil hacer el trabajo.

Imaginemos que presentamos un informe y la persona que lo recibe nos
pide que cambiemos el color. Si tenemos que revisar cada código de cada
gráfico nos llevaría mucho tiempo y salud mental. Por eso es una buena
práctica asignar los elementos del estilo a un objeto y usarlo en cada
gráfico. Esto hace que el código sea más elegante, y sea mucho más
sencillo corregir el estilo de ser necesario.

Asignemos entonces nuestro estilo (en lenguaje de R, el tema) a un
objeto.

``` r
estilo <- theme(panel.background = element_blank(),
        panel.grid.major.y = element_line(colour = "#F4F6F6"),
        axis.title = element_blank(),
        axis.line = element_line(colour = "grey"))
```

Para analizar la evolución por país en los últimos 5 años lo mejor es
usar un gráfico de líneas. Podemos utilizar nuestro objeto *estilo* para
formatear el gráfico. Probemos esto, separando los gráficos por país.

``` r
conosur %>%
  group_by(Country) %>%
  ggplot(aes(x= factor(Year), y= `Female Ratio`, group=Country, color = Country))+
  geom_line(size = 1) +
  estilo +
  facet_wrap(~Country)
```

![](ejercicios_clu_de_r_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

Por más que tengamos un estilo definido con un objeto, podemos hacer
cambios individuales con la función *theme*, por ejemplo, cambiar la
orientación de las etiquetas del eje ‘x’.

``` r
conosur %>%
  group_by(Country) %>%
  ggplot(aes(x= factor(Year), y= `Female Ratio`, group=Country, color = Country))+
  geom_line(size = 1) +
  estilo +
  theme(axis.text.x = element_text(angle=90))+
  facet_wrap(~Country, ncol=2)
```

![](ejercicios_clu_de_r_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->
