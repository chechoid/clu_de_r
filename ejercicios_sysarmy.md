Clú de R
================

# Introducción

Sysarmy es una comunidad que es *“el soporte de quienes dan soporte”*.
Además de un podcast y de organizar actividades para la comunidad de IT,
son conocidos por realizar dos veces por año, una encuesta abierta de
sueldos del mercado de tecnología.

En el Clú de R, esta vez vamos a utilizar la encuesta de sueldos
publicada en su
[blog](%22https://sysarmy.com/blog/posts/resultados-de-la-encuesta-de-sueldos-2020-1/%22)
para ejercitar con datos relacionados con RRHH.

## La encuesta

Sysarmy difunde la encuesta en una hoja de cáculo de Google.
![](EncuestaSysArmy.png)

Para cargar este archivo vamos a usar las librerías *googlesheets4* y
*gargle*. Así que el primer paso es instalarlas. Como es de suponer,
*googlesheets4* nos permite cargar los archivos de Google, mientras que
*gargle* nos ayuda a que sea legible los caracteres especiales del
español (la letra “ñ” o las vocales con tilde por ejemplo).

``` r
install.packages("googlesheets4")
install.packages("gargle")
```

Una vez instaladas, cargamos ambas librerías junto con *tidyverse* para
poder realizar las transformaciones y limpiezas de datos.

``` r
library(googlesheets4)
library(gargle)
library(tidyverse)
```

Antes de cargar los datos de la encuesta salarial, observemos en la
imagen que recién en la fila 10 aparecen los encabezados de las
columnas. Con lo cual, cuando carguemos la hoja de cálculo, tendremos
que tener en cuenta esto.

Para ver más opciones de carga del paquete *googlesheets4* pueden
revisar la [página del
desarrollador](%22https://googlesheets4.tidyverse.org/articles/articles/find-identify-sheets.html%22)

``` r
encuesta_sysarmy <- sheets_read("1_db6zEAMvr-1GQjJb4hV-rSQfJ9w6GmezbqKJ2JJn7I", skip = 9)
```

    ## Reading from '2020.1 - sysarmy - Encuesta de remuneración salarial Argentina'

    ## Range "10:5000000"

Antes de avanzar, ¿de dónde sale lo que ponemos dentro de
**sheets\_read()**? Esto sale de la url de la hoja de cálculo.

> <https://docs.google.com/spreadsheets/d/1_db6zEAMvr-1GQjJb4hV-rSQfJ9w6GmezbqKJ2JJn7I/edit#gid=281592228>

Si copias y pegas esa url, vas a acceder a la hoja de cáculo con los
resultados de la encuesta de Sysarmy.

Toda esta esta parte de la url
(1\_db6zEAMvr-1GQjJb4hV-rSQfJ9w6GmezbqKJ2JJn7I) representa el ID de la
hoja de cálculo, y eso es lo que ponemos dentro de la función
**sheets\_read()**. O sea que cuando uses una hoja de cálculo de Google
tené en cuenta que el ID se encuentra dentro de la url.

> <https://docs.google.com/spreadsheets/d/>**SPREADSHEET\_ID**/edit\#gid=SHEET\_ID

El parámetro *skip = 9* lo que está diciendo es que omita las primeras 9
filas de la hoja de cálculo, porque los títulos de la columna están
recién en la fila 10. Cuando hagamos esta carga, va a demorar un poco,
así que aprovechen para hacer una pausa.

## Empecemos el análisis

Exploremos la estructura de los datos con la función *glimpse*:

``` r
glimpse(encuesta_sysarmy)
```

    ## Observations: 5,982
    ## Variables: 48
    ## $ `Me identifico`                                                                                      <chr> ...
    ## $ Tengo                                                                                                <dbl> ...
    ## $ `Dónde estás trabajando`                                                                             <chr> ...
    ## $ `Años de experiencia`                                                                                <list> ...
    ## $ `Años en la empresa actual`                                                                          <dbl> ...
    ## $ `Años en el puesto actual`                                                                           <dbl> ...
    ## $ `¿Gente a cargo?`                                                                                    <dbl> ...
    ## $ `Nivel de estudios alcanzado`                                                                        <chr> ...
    ## $ Estado                                                                                               <chr> ...
    ## $ Carrera                                                                                              <chr> ...
    ## $ Universidad                                                                                          <chr> ...
    ## $ `Realizaste cursos de especialización`                                                               <chr> ...
    ## $ `¿Contribuís a proyectos open source?`                                                               <chr> ...
    ## $ `¿Programás como hobbie?`                                                                            <chr> ...
    ## $ `Trabajo de`                                                                                         <chr> ...
    ## $ Plataformas                                                                                          <chr> ...
    ## $ `Lenguajes de programación`                                                                          <chr> ...
    ## $ `Frameworks, herramientas y librerías`                                                               <chr> ...
    ## $ `Bases de datos`                                                                                     <chr> ...
    ## $ `QA / Testing`                                                                                       <chr> ...
    ## $ IDEs                                                                                                 <chr> ...
    ## $ `¿Qué SO usás en tu laptop/PC para trabajar?`                                                        <chr> ...
    ## $ `¿Y en tu celular?`                                                                                  <chr> ...
    ## $ `¿Tenés guardias?`                                                                                   <chr> ...
    ## $ `Cuánto cobrás por guardia`                                                                          <dbl> ...
    ## $ `¿Porcentaje, bruto o neto?`                                                                         <chr> ...
    ## $ `Tipo de contrato`                                                                                   <chr> ...
    ## $ `Salario mensual BRUTO (en tu moneda local)`                                                         <dbl> ...
    ## $ `Salario mensual NETO (en tu moneda local)`                                                          <dbl> ...
    ## $ `¿Qué tan conforme estás con tu sueldo?`                                                             <dbl> ...
    ## $ `Cómo creés que está tu sueldo con respecto al último semestre`                                      <dbl> ...
    ## $ `Recibís algún tipo de bono`                                                                         <chr> ...
    ## $ `A qué está atado el bono`                                                                           <chr> ...
    ## $ `¿Tuviste ajustes por inflación en 2019?`                                                            <chr> ...
    ## $ `¿De qué % fue el ajuste total?`                                                                     <list> ...
    ## $ `¿En qué mes fue el último ajuste?`                                                                  <list> ...
    ## $ `¿Sufriste o presenciaste situaciones de violencia laboral?`                                         <chr> ...
    ## $ `Orientación sexual`                                                                                 <chr> ...
    ## $ `¿Tenés algún tipo de discapacidad?`                                                                 <chr> ...
    ## $ `¿Sentís que esto te dificultó el conseguir trabajo?`                                                <chr> ...
    ## $ `¿A qué eventos de tecnología asististe en el último año?`                                           <list> ...
    ## $ `Cantidad de empleados`                                                                              <chr> ...
    ## $ `Actividad principal`                                                                                <chr> ...
    ## $ `¿La recomendás como un buen lugar para trabajar?`                                                   <dbl> ...
    ## $ `¿Cómo calificás las políticas de diversidad e inclusión?`                                           <dbl> ...
    ## $ `¿A cuántos kilómetros de tu casa queda la oficina?`                                                 <dbl> ...
    ## $ `Beneficios extra`                                                                                   <chr> ...
    ## $ `¿Cuáles considerás que son las mejores empresas de IT para trabajar en este momento, en tu ciudad?` <chr> ...

En primer lugar vemos que tenemos un data frame con 48 variables
(columnas) y 5.982 observaciones. Este archivo nos va a traer un montón
de desafíos porque hay muchos campos libres en donde la gente tuvo la
libertad de poner lo que quisieran… y varios aprovecharon esa libertad.

Empecemos con un primer análisis de los sueldos brutos y de los puestos.
Seleccionemos las variables de puestos y de sueldo bruto.

``` r
analisis_1 <- encuesta_sysarmy %>%
  select("Trabajo de", `Salario mensual BRUTO (en tu moneda local)`)

head(analisis_1)
```

    ## # A tibble: 6 x 2
    ##   `Trabajo de`            `Salario mensual BRUTO (en tu moneda local)`
    ##   <chr>                                                          <dbl>
    ## 1 HelpDesk                                                       41000
    ## 2 SysAdmin / DevOps / SRE                                        60000
    ## 3 Architect                                                     180000
    ## 4 Developer                                                     150000
    ## 5 Networking                                                     25200
    ## 6 Developer                                                     150000

Ahora cambiemos los nombres de las variables para trabajar más cómodos

``` r
analisis_1 <- analisis_1 %>%
  rename("Puesto" = "Trabajo de",
         "Sueldo_Bruto" = `Salario mensual BRUTO (en tu moneda local)`)
```

El primer parámetro de la función *rename* indica el nuevo nombre de la
variable, y luego del signo “=” ponemos el nombre original de la
variable. Ahora tenemos una tabla más prolija para trabajar.

``` r
head(analisis_1)
```

    ## # A tibble: 6 x 2
    ##   Puesto                  Sueldo_Bruto
    ##   <chr>                          <dbl>
    ## 1 HelpDesk                       41000
    ## 2 SysAdmin / DevOps / SRE        60000
    ## 3 Architect                     180000
    ## 4 Developer                     150000
    ## 5 Networking                     25200
    ## 6 Developer                     150000

Probemos algo básico, analicemos la distribución de los sueldos IT de
Argentina.

``` r
ggplot(analisis_1, aes(x = Sueldo_Bruto))+
  geom_histogram()
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](ejercicios_sysarmy_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

¿Qué pasó? Tenemos 5.981 casos agrupados cerca del 0 en el eje X y un
caso que cobra como AR$ 6 cuatrillones (¿recuerdan la libertad que les
mencioné?). Veamos que pasa con las variables, explorándolas con la
función *summary*

``` r
summary(analisis_1)
```

    ##     Puesto           Sueldo_Bruto          
    ##  Length:5982        Min.   :            1  
    ##  Class :character   1st Qu.:        46419  
    ##  Mode  :character   Median :        72000  
    ##                     Mean   :   1133123425  
    ##                     3rd Qu.:       110000  
    ##                     Max.   :6777729990110

Veamos los resultados que arroja la función summary:

  - Min. es el valor mínimo de la variable. En este caso es 1.
  - 1st. Qu. representa el primer cuartil.
  - Median representa a la mediana
  - Mean representa al promedio
  - 3rd. Qu. es el valor que está en el tercer cuartil.
  - Max es el máximo valo de la variable.

Acá vemos que el sueldo mínimo es de $1, y el sueldo máximo es de ARS
6.777.729.990.110, lo cual en ambos casos es ridículo. Usaremos la
función *between* para filtrar los valores entre los márgenes que
indiquemos, por ejemplo entre ARS 20.000 y 1.000.000.

``` r
analisis_1 <- analisis_1 %>%
  filter(between(Sueldo_Bruto, 20000, 1000000))
summary(analisis_1)
```

    ##     Puesto           Sueldo_Bruto   
    ##  Length:5673        Min.   : 20000  
    ##  Class :character   1st Qu.: 50000  
    ##  Mode  :character   Median : 75000  
    ##                     Mean   : 94194  
    ##                     3rd Qu.:111120  
    ##                     Max.   :900007

Ahora tenemos valores más razonables para analizar. Noten como la
**mediana** en ambos análisis quedó con valores muy similares, mientras
que el promedio cambió notoriamente ya que la mediana nos da el valor
que está en el medio de los datos, y el promedio es muy sensible a los
valores extremos. Con los datos un poco más limpios podemos probar
nuevamente de nuestro histograma:

``` r
ggplot(analisis_1, aes(x = Sueldo_Bruto)) + 
  geom_histogram()
```

![](ejercicios_sysarmy_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

Podemos observar en este gráfico que aproximadamente más de 4.500
personas tienen un sueldo bruto entre $ 20.000 y 125.000 por mes.

Otro gráfico muy usado en análisis estadístico es el **boxplot**, que
nos brinda información sobre los cuartiles 1 y 3 (los extremos de la
caja), la mediana es la línea gruesa dentro de la caja, y los famosos
**outliers** o valores extremos.

``` r
ggplot(analisis_1, aes(x = Sueldo_Bruto)) +
  geom_boxplot() +
  coord_flip()
```

![](ejercicios_sysarmy_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

### Análisis por puestos

Lo interesante es poder hacer análisis por distintos puestos. Para
simplificarlo, vamos a recortar los sueldos de análisis hasta AR$
100.000. Vamos a seleccionar nuevamente los puestos, el sueldo bruto e
incluyamos los años de experiencia.

``` r
analisis_2 <- encuesta_sysarmy %>%
  select("Trabajo de", "Años de experiencia", `Salario mensual BRUTO (en tu moneda local)`) %>%
  rename("Puesto" = "Trabajo de",
         "Experiencia" = "Años de experiencia",
         "Sueldo_Bruto" = `Salario mensual BRUTO (en tu moneda local)`) %>%
  filter(between(Sueldo_Bruto, 20000, 100000))

head(analisis_2)
```

    ## # A tibble: 6 x 3
    ##   Puesto                  Experiencia Sueldo_Bruto
    ##   <chr>                   <list>             <dbl>
    ## 1 HelpDesk                <dbl [1]>          41000
    ## 2 SysAdmin / DevOps / SRE <dbl [1]>          60000
    ## 3 Networking              <dbl [1]>          25200
    ## 4 SysAdmin / DevOps / SRE <dbl [1]>          57000
    ## 5 Developer               <dbl [1]>          46000
    ## 6 Developer               <dbl [1]>          37000

Los datos en experiencia nos quedaron con un formato de *lista*, lo cual
nos va a impedir hacer algunos análisis. Por suerte, unos minutos de
navegación en Stack Overflow nos permite hallar una rápida y sencilla
solución.

``` r
analisis_2$Experiencia <- as.numeric(unlist(analisis_2$Experiencia))

head(analisis_2)
```

    ## # A tibble: 6 x 3
    ##   Puesto                  Experiencia Sueldo_Bruto
    ##   <chr>                         <dbl>        <dbl>
    ## 1 HelpDesk                         15        41000
    ## 2 SysAdmin / DevOps / SRE          15        60000
    ## 3 Networking                        4        25200
    ## 4 SysAdmin / DevOps / SRE          14        57000
    ## 5 Developer                         3        46000
    ## 6 Developer                         2        37000

Probemos hacer un gráfico de barras agrupado por puesto. Rotemos el
gráfico para que sea más legible las etiquetas:

``` r
analisis_2 %>%
  group_by(Puesto) %>%
  ggplot(aes(x = reorder(Puesto, Sueldo_Bruto), y = Sueldo_Bruto)) +
  geom_col() +
  coord_flip()
```

![](ejercicios_sysarmy_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

Nuevamente, al dejar los campos como texto abierto, varios completaron
lo que les pareció. Este es tal vez el caso más llamativo

> *“Lucho constantemente contra el desorden en los repositorios de pibes
> que no saben usar Git ni el framework con el que laburamos”*

Todo lo que es limpieza de texto lo vamos a dejar para otra sesión, pero
podemos hacer una comparación de algunos puestos. Primero, fijémonos
cuáles son los puestos con mayor cantidad de respuestas.

``` r
analisis_2 %>%
  group_by(Puesto) %>%
  tally(sort = TRUE) %>%
  top_n(5)
```

    ## Selecting by n

    ## # A tibble: 5 x 2
    ##   Puesto                        n
    ##   <chr>                     <int>
    ## 1 Developer                  1660
    ## 2 SysAdmin / DevOps / SRE     396
    ## 3 QA / Tester                 207
    ## 4 HelpDesk                    194
    ## 5 BI Analyst / Data Analyst   150

*Developers*, *SysAdmins*, y *QA/Tester* son los puestos más frecuentes,
así que elijamos estos tres para analizar.

``` r
analisis_puestos <- analisis_2 %>%
  filter(Puesto %in% c("Developer", "SysAdmin / DevOps / SRE", "QA / Tester"))
```

Veamos los sueldos promedios de cada posición:

``` r
analisis_puestos %>%
  group_by(Puesto) %>%
  summarise(Sueldo_Promedio = mean(Sueldo_Bruto)) %>%
  ggplot(aes(x = Puesto, y = Sueldo_Promedio)) +
  geom_col()
```

![](ejercicios_sysarmy_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->
