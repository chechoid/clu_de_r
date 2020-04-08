Ejercicios del Clú de R
================
Sergio García Mora


# Ejercicios Capítulo 2
## Exploración de dataset

Descargué datos de la página del Banco Mundial de este link [link](https://databank.bancomundial.org/source/gender-statistics/preview/on#) en formato csv. Los datos indican el ratio de participación femenina en la fuerza laboral de cada país.

Luego uso un paquete para leer archivos (también podría usarlo para leer archivos de Excel)

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

    ## Parsed with column specification:
    ## cols(
    ##   `serie Name` = col_character(),
    ##   `serie Code` = col_character(),
    ##   `país Name` = col_character(),
    ##   `país Code` = col_character(),
    ##   `2010 [YR2010]` = col_character(),
    ##   `2011 [YR2011]` = col_character(),
    ##   `2012 [YR2012]` = col_character(),
    ##   `2013 [YR2013]` = col_character(),
    ##   `2014 [YR2014]` = col_character(),
    ##   `2015 [YR2015]` = col_character(),
    ##   `2016 [YR2016]` = col_character(),
    ##   `2017 [YR2017]` = col_character(),
    ##   `2018 [YR2018]` = col_character(),
    ##   `2019 [YR2019]` = col_character()
    ## )

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

Una forma posible de solucionarlo

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
    
    # Ejercicios Capítulo 3 del libro "Ciencia de Datos para gente sociable"
## Seleccionando y transformando datos

Cargo de nuevo los datos
```{r echo=TRUE, message=FALSE}
library(readr)
library(tidyverse)
part_fem <- read_csv("Ratio_Participacion_Laboral_Femenina.csv")
```

Como tenemos datos que son texto y otros numéricos, separamos las columnas numéricas de las columnas que contienen texto para transformarlos
```{r echo=TRUE}
cols_char <- part_fem %>% select(1:2) %>%
  mutate_if(is.character, as.factor)
```

Antes vimos que podíamos cambiar el tipo de variable columna por columna, lo cual no es eficiente. [Pablo de Innocentis](https://www.linkedin.com/in/padeinnocentiis/) aportó esta solución.

Usando la función mutate_if() cambia todo lo que sea character (chr) a numerico
```{r echo=TRUE}
part_fem2 <- part_fem %>% select(3:12) %>%
  mutate_if(is.character, as.numeric) %>% 
  cbind(cols_char) %>% # Esta función une las columnas de ambos data frames
  select('país Name', 'país Code', everything()) # Reorganiza el dataset poniendo los nombres por delante
```
La función *cbind* lo que hace es unir los dos data frames que creamos cuando separamos el data frame original para transformar las variables. Lo que hace es pegar las columnas de un objeto, al lado de las columnas del otro objeto. Por esta razón es importante verificar siempre que ambos datasets tengan la misma cantidad de filas.

El último *select* que usamos en la función lo que hace es organizar el nuevo conjunto de datos en el orden que querramos: en este caso pone *'Pais Name'* primero, luego *'País Code'* y con la función *everything()* le decimos a R que ponga todas las columnas que faltan a continuación.

Veamos cómo quedó el dataset
```{r echo = TRUE}
glimpse(part_fem2)
```

Elijo los países del Cono Sur y los últimos 5 años de informe
```{r echo=TRUE}
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
```{r echo=TRUE}
conosur
```

# Ejercicios Capítulo 4 libro Ciencia de Datos para Gente Sociable
## Visualización
Hago un gráfico de barras para comparar la participación femenina en la fuerza de trabajo por país.
Este link es muy útil (http://www.cookbook-r.com/Graphs/Bar_and_line_graphs_(ggplot2)/) para tener de refeencia
```{r echo=TRUE}
conosur %>%
  group_by(Country) %>%
  summarise(Avg_Ratio = mean(`Female Ratio`)) %>%
  ggplot(aes(x = reorder(Country, Avg_Ratio), y = Avg_Ratio))+
  geom_col() +
  coord_flip() 
```

Esta es la versión "base" de ggplot2. Una de las ventajas que tiene es que es posible customizar todo lo que queramos.
```{r echo=TRUE}
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

Para analizar la evolución por país en los últimos 5 años lo mejor es usar un gráfico de líneas
```{r echo = TRUE}
conosur %>%
  group_by(Country) %>%
  ggplot(aes(x= factor(Year), y= `Female Ratio`, group=Country, color = Country))+
  geom_line(size = 1) +
  theme(panel.background = element_blank(),
        panel.grid.major.y = element_line(colour = "#F4F6F6"),
        axis.title = element_blank(),
        axis.line = element_line(colour = "grey"))
```

Hagamos un gráfico independiente por país
```{r echo=TRUE}
conosur %>%
  group_by(Country) %>%
  ggplot(aes(x= factor(Year), y= `Female Ratio`, group=Country, color = Country))+
  geom_line(size = 1) +
  theme(panel.background = element_blank(),
        panel.grid.major.y = element_line(colour = "#F4F6F6"),
        axis.title = element_blank(),
        axis.line = element_line(colour = "grey"),
        axis.text.x = element_text(angle=90)) +
  facet_wrap(~Country)
```
