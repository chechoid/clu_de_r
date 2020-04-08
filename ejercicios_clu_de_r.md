Ejercicios del Clú de R
================
Sergio García Mora


# Ejercicios Capítulo 2

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
