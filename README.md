# Barcelona — Análisis de vivienda, renta, coste de vida y movilidad

### Análisis comparativo de los 73 barrios de Barcelona con Power BI

Este proyecto analiza las diferencias económicas y de movilidad entre los **73 barrios de Barcelona** con el objetivo de ayudar a identificar qué zonas pueden adaptarse mejor a diferentes presupuestos y prioridades.

El análisis integra datos oficiales sobre **alquiler, renta disponible, coste de vida y transporte público**, combinando diferentes periodos y fuentes públicas en un único modelo de Power BI.

> **Periodo analizado:** 2019–2026  
> **Ámbito geográfico:** 73 barrios de Barcelona  
> **Herramientas:** Excel · Power BI · Power Query · DAX · BigQuery / SQL  
> **Fuentes principales:** Ajuntament de Barcelona · Generalitat de Catalunya / INCASÒL · Idescat · ATM


### Dashboard interactivo

 **[Explorar el informe en Power BI](https://app.powerbi.com/view?r=eyJrIjoiODRhMDIxYTktMmEwZC00OWFlLTkxMzgtYzg4MDRjNzZhZjhiIiwidCI6IjRmNTk4MmIyLWQ1MzgtNDVkMC05OWFiLTdkZWIyMjU2ODFkYSJ9)**

---

## El proyecto en pocas palabras

| Dimensión | Datos utilizados | Periodo |
|---|---|---|
|  Alquiler | Contratos de alquiler registrados | 2019–2026* |
|  Renta disponible | Renta disponible de los hogares per cápita | 2019–2023 |
|  Coste de vida | Encuesta de Presupuestos Familiares | 2023 |
|  Movilidad | Oferta programada TMB y Metro / FGC | 2026* |

\* Los datos de alquiler de 2026 corresponden a un periodo parcial.
\* Periodo actual, GTFS ATM, periodo analizado: 05/08/2026–31/12/2026.

Para la página **¿Dónde vivir?**, el proyecto construye además una comparación homogénea para **2025**, utilizando el alquiler oficial de 2025 y estimaciones de renta disponible y coste de vida basadas en datos oficiales y tendencias recientes.

---

##  Objetivo del análisis

Barcelona presenta fuertes diferencias entre barrios en términos de **precio del alquiler, renta disponible, coste de vida y acceso al transporte público**.

El objetivo de este proyecto es analizar conjuntamente estas dimensiones para responder a una pregunta principal:

> **¿Cómo cambian las condiciones económicas y de movilidad entre los 73 barrios de Barcelona y qué barrios pueden adaptarse mejor a diferentes perfiles y presupuestos?**

Para responder a esta pregunta, el análisis se estructura en cuatro dimensiones:

-  **Vivienda:** evolución y diferencias del precio medio del alquiler.
-  **Renta:** distribución de la renta disponible y esfuerzo económico asociado al alquiler.
-  **Coste de vida:** estructura de los gastos mensuales por persona y estimación de su evolución, excluyendo la vivienda.
-  **Movilidad:** oferta programada de transporte público y conexiones directas entre barrios.

El proyecto no pretende identificar un único «mejor barrio», sino proporcionar indicadores que permitan comparar diferentes alternativas según las prioridades de cada usuario.

---

## Estructura del dashboard

El informe está organizado como un recorrido progresivo: parte de los principales indicadores económicos de los barrios, analiza la movilidad y termina con una herramienta interactiva de comparación.

### Alquiler
Analiza la evolución del precio medio del alquiler por barrio entre **2019 y 2026**, utilizando datos oficiales de contratos registrados.

Permite identificar diferencias territoriales, tendencias históricas y barrios con niveles de alquiler especialmente altos o bajos.

> **Nota:** los datos de 2026 son parciales y no representan un año completo.

###  Renta
Estudia la **renta disponible de los hogares per cápita** en los 73 barrios de Barcelona durante el periodo oficial disponible **2019–2023**.

Permite comparar niveles de renta y su evolución territorial.

### Accesibilidad a la vivienda
Relaciona el alquiler mensual con la renta disponible mensual mediante la **carga del alquiler**:

`Carga del alquiler (%) = Alquiler mensual / Renta disponible mensual × 100`

Este indicador permite evaluar qué proporción de la renta disponible representa el alquiler en cada barrio.

### Coste de vida

Analiza el **gasto medio mensual por persona** a partir de la **Despesa anual per grups de despesa ECOICOP/EPF (3 dígits) de Catalunya, 2023**, utilizando su mayor nivel de detalle para excluir los componentes asociados a la vivienda y evitar una doble contabilización con el alquiler.

Los gastos se agrupan en tres categorías:

**Esencial · Necesario variable · Discrecional**

### Oferta de transporte público
Analiza la oferta programada de **autobús TMB y Metro/FGC**

Permite comparar la intensidad del servicio entre barrios y observar diferencias entre días laborables y fines de semana.

### Conectividad entre barrios
Analiza qué barrios están conectados directamente mediante al menos una línea de autobús TMB o Metro/FGC.

La conectividad representa **conexiones directas sin transbordo**, no tiempos de viaje ni demanda real.

### ¿Dónde vivir?
Integra vivienda, renta, coste de vida y movilidad en una página interactiva orientada a la toma de decisiones.

La comparación económica se homogeneiza en **2025** mediante:

- alquiler oficial 2025
- renta disponible estimada 2025
- coste de vida estimado 2025
- red de transporte GTFS (actual)

El usuario puede seleccionar diferentes categorías de gasto y comparar cómo cambian el coste mensual total, la renta restante y los indicadores de movilidad según el barrio.

---

## Metodología y estimaciones

Algunas dimensiones del proyecto no disponen todavía de datos oficiales para un mismo año de referencia.

Para construir una comparación económica coherente en la página **«¿Dónde vivir?»**, se utiliza **2025 como año de referencia** y se estiman únicamente las variables necesarias que todavía no están disponibles oficialmente con la granularidad requerida.

> Las estimaciones forman parte del modelo analítico y no deben interpretarse como datos oficiales.

### Estimación de la renta disponible 2025

El último dato oficial disponible utilizado a nivel de barrio corresponde a **2023**.

La estimación se construye en dos etapas:

**1. Estimación 2024**

Se aplica a cada barrio la evolución anual observada para el conjunto de Barcelona:

`Renta estimada 2024 = Renta oficial 2023 × 1,09`

El crecimiento del **9,0 %** se aplica de forma homogénea. De esta manera, 2024 funciona como una transición macroeconómica sin introducir diferencias territoriales adicionales no observadas directamente.

**2. Estimación 2025**

La evolución reciente de la renta disponible de Barcelona durante 2025 se utiliza como referencia macroeconómica.

Las variaciones interanuales trimestrales utilizadas son:

`T1 +5,7 % · T2 +6,3 % · T3 +3,9 % · T4 +5,2 %`

Su media simple proporciona una referencia de:

`5,275 %`

Esta referencia no constituye una tasa anual oficial de RDLpc 2025, sino un **anclaje del modelo** construido a partir de la evolución trimestral disponible.

Para conservar parte de la dinámica territorial observada entre barrios, la tasa se ajusta mediante la evolución histórica de cada barrio durante **2021–2023**.

El ajuste se normaliza, limita y recentra para evitar que las diferencias históricas produzcan proyecciones excesivas.

La tasa final estimada por barrio se sitúa aproximadamente entre:

`+4,85 % y +6,85 %`

Finalmente:

`Renta estimada 2025 = Renta estimada 2024 × (1 + tasa estimada 2025 del barrio)`

Este método mantiene la tendencia general de Barcelona como referencia y utiliza la evolución histórica de los barrios únicamente como una **modulación controlada**, no como una extrapolación directa.

### Estimación del coste de vida 2024–2025

El modelo utiliza como punto de partida una estructura detallada de gasto por persona correspondiente a **2023**.

Se mantiene esta base debido a que su mayor nivel de desagregación permite identificar con mayor precisión los componentes del gasto y excluir los costes asociados a la vivienda, evitando su doble contabilización con el alquiler.

Los importes se actualizan posteriormente en dos etapas:

**1. Estimación 2024**

Cada categoría de gasto de 2023 se actualiza mediante la variación del IPC correspondiente a su grupo de consumo.

`Coste 2024 = Coste 2023 × (1 + IPC 2024 de la categoría)`

**2. Estimación 2025**

Los valores obtenidos para 2024 se actualizan nuevamente utilizando la **variación media anual del IPC 2025 por grupo de consumo**.

`Coste 2025 = Coste estimado 2024 × (1 + IPC medio anual 2025 de la categoría)`

Este procedimiento permite conservar una estructura de gasto más detallada que la disponible en las tablas agregadas posteriores y aplicar una evolución de precios diferente según el tipo de consumo.

Los resultados deben interpretarse como **estimaciones**, no como valores oficiales observados para 2024 o 2025.

### Comparación final 2025

La página **«¿Dónde vivir?»** combina:

`Alquiler oficial 2025 + Renta estimada 2025 + Coste de vida estimado 2025`

con los indicadores de movilidad derivados de la red **GTFS 2026**.

De esta forma, las variables económicas se comparan sobre una misma referencia temporal, mientras que la movilidad representa la estructura más reciente de transporte utilizada en el proyecto.

---

## Principales resultados

El análisis muestra que las diferencias entre barrios de Barcelona no se explican únicamente por el precio del alquiler. La renta disponible, el coste relativo de la vivienda y la conectividad modifican de forma importante la lectura de cada zona.

### Fuertes diferencias en el mercado del alquiler

El precio medio del alquiler presenta una elevada heterogeneidad entre los 73 barrios.

Los barrios con alquileres más bajos no son necesariamente los más accesibles económicamente: un alquiler reducido puede estar acompañado de una renta disponible también más baja.

Además, los datos corresponden a **contratos registrados**, por lo que barrios pequeños o con pocas operaciones pueden presentar una mayor volatilidad.

### La accesibilidad depende de la relación entre alquiler y renta

Para evaluar mejor la presión económica de la vivienda, el proyecto utiliza la **carga del alquiler** en lugar de analizar únicamente el precio absoluto.

En 2023 se observan diferencias muy importantes entre barrios:

- **Torre Baró:** alrededor del **40 %** de carga del alquiler.
- **La Marina del Prat Vermell:** alrededor del **91 %**.

Esto muestra que comparar únicamente los precios de alquiler puede producir conclusiones incompletas.

### La evolución también importa

Entre 2019 y 2023, algunos barrios presentan cambios importantes en su nivel de esfuerzo económico.

**Pedralbes** registra una de las mayores mejoras relativas de la carga del alquiler, mientras que **La Marina del Prat Vermell** presenta un fuerte deterioro durante el periodo.

Estos resultados deben interpretarse junto con la evolución de la renta, del alquiler y el volumen de observaciones disponible en cada barrio.

### El alquiler no representa todo el presupuesto

La actualización de la estructura detallada de gasto de 2023 mediante el IPC por categoría proporciona una estimación para 2024 de aproximadamente:

**892 € por persona y mes, excluyendo la vivienda.**

La actualización posterior mediante la variación media anual del IPC 2025 por categoría sitúa la estimación de 2025 alrededor de:

**913 € por persona y mes**, seleccionando todas las categorías de gasto.

Incorporar estos gastos permite pasar de una comparación centrada únicamente en vivienda a una aproximación más completa del presupuesto mensual.

### La oferta de transporte es muy desigual

Los datos GTFS muestran diferencias importantes en la intensidad de la oferta programada entre barrios.

Para el conjunto de Barcelona analizado, el modelo obtiene aproximadamente:

- **1.539 servicios programados diarios de media**
- **1.666 en días laborables**
- **1.347 los sábados**
- **1.088 los domingos**

La oferta programada durante el fin de semana es aproximadamente un **27 % inferior** a la observada en días laborables.

### Precio y conectividad deben analizarse conjuntamente

La conectividad directa permite añadir una dimensión que el precio del alquiler no refleja: la capacidad de desplazarse hacia otros barrios sin transbordo.

El análisis muestra que dos barrios con condiciones económicas similares pueden ofrecer niveles de conectividad muy diferentes.

> **El barrio más adecuado depende del equilibrio entre presupuesto, renta disponible, gastos personales y necesidades de movilidad.**

---

## ¿Dónde vivir? — Herramienta interactiva de decisión

La página **«¿Dónde vivir?»** constituye la síntesis del proyecto.

En lugar de analizar cada dimensión de forma aislada, combina los principales indicadores económicos y de movilidad para ofrecer una visión global de cada barrio.

### ¿Qué puede analizar el usuario?

Al seleccionar un barrio, el dashboard muestra:

-  **Renta disponible mensual estimada**
-  **Precio medio del alquiler**
-  **Carga del alquiler**
-  **Coste de vida seleccionado**
-  **Coste mensual total con alquiler**
-  **Renta restante estimada**
-  **Oferta diaria de transporte público**
-  **Número de líneas disponibles**
-  **Número de barrios conectados directamente**

### Un coste de vida adaptable al usuario

El coste de vida no se trata como una cantidad fija.

El usuario puede seleccionar las categorías de gasto que desea incluir:

**Esencial · Necesario variable · Discrecional**

El dashboard recalcula automáticamente:

`Coste de vida seleccionado`

`Coste total mensual = Alquiler + Coste de vida seleccionado`

`Renta restante = Renta estimada - Coste total mensual`

Esto permite comparar barrios bajo diferentes hipótesis de gasto y adaptar el análisis a distintos perfiles.

### Interpretación

Un barrio con alquiler bajo puede presentar una renta disponible menor, mientras que otro más caro puede ofrecer una mejor relación entre renta, vivienda y movilidad.

Por ello, **«¿Dónde vivir?» funciona como una herramienta de comparación y exploración**, dejando que las prioridades del usuario determinen qué combinación resulta más adecuada.

---

### Flujo de trabajo

Fuentes oficiales
→ Excel (preparación inicial)
→ Power Query / SQL (transformación y procesamiento)
→ Modelo de datos
→ DAX
→ Power BI
→ Dashboard interactivo

---

## Limitaciones del análisis

El proyecto busca mantener una separación clara entre datos observados y estimaciones. Sin embargo, existen varias limitaciones que deben tenerse en cuenta al interpretar los resultados:

- **Alquiler:** los datos corresponden a contratos registrados y no a precios actuales de oferta. Los barrios con pocas operaciones pueden presentar mayor volatilidad.
- **Renta:** los datos oficiales por barrio terminan en 2023. Los valores 2024–2025 son estimaciones propias y no estadísticas oficiales.
- **Coste de vida:** la EPF utiliza Catalunya como referencia territorial debido a la ausencia de datos equivalentes para los 73 barrios de Barcelona.
- **Estimación 2025:** la evolución futura de cada barrio puede diferir de la dinámica histórica utilizada en el modelo.
- **Movilidad:** GTFS representa servicios programados, no demanda real, puntualidad ni servicios efectivamente realizados.
- **Conectividad:** una conexión indica la existencia de al menos una línea directa entre dos barrios; no mide tiempo de viaje, frecuencia, distancia ni necesidad de caminar.
- **Comparación temporal:** los indicadores económicos de «¿Dónde vivir?» utilizan 2025, mientras que la red de transporte utilizada corresponde a GTFS 2026.

Estas limitaciones no invalidan la comparación, pero definen el alcance dentro del cual deben interpretarse los resultados.

---

## Líneas de análisis futuras

El proyecto permite identificar barrios que presentan niveles especialmente elevados de carga del alquiler y evoluciones atípicas a lo largo del periodo analizado.

Una posible extensión del análisis consistiría en estudiar con mayor profundidad las **causas de la presión del alquiler** en estos barrios, considerando factores como:

- la evolución relativa del alquiler y de la renta disponible;
- la transformación del parque residencial;
- el volumen y la composición de los contratos registrados;
- el peso del alquiler temporal y turístico;
- los procesos de transformación urbana y residencial.

Barrios como **la Marina del Prat Vermell, la Bordeta, el Raval, el Barri Gòtic o la Verneda i la Pau** presentan patrones que podrían justificar un análisis específico.

Este análisis requeriría incorporar nuevas fuentes de datos y contrastar cada hipótesis antes de establecer relaciones causales.

---

## Conclusión

Este proyecto muestra cómo diferentes fuentes públicas pueden integrarse para analizar una pregunta urbana concreta:

> **¿Cómo cambian las condiciones para vivir entre los diferentes barrios de Barcelona?**

El análisis demuestra que evaluar un barrio únicamente por el precio del alquiler ofrece una visión incompleta.

La relación entre **alquiler, renta disponible, coste de vida y movilidad** permite construir una comparación más amplia y entender mejor los compromisos existentes entre presupuesto y accesibilidad.

El objetivo final no es determinar un único «mejor barrio», sino proporcionar una herramienta transparente y explorable que permita comparar los **73 barrios de Barcelona** desde diferentes perspectivas.

---

### Autor

**Guillaume Sánchez**

Proyecto desarrollado con:

**Excel · Power BI · Power Query · DAX · SQL · BigQuery**
 
Barcelona — Análisis de datos urbanos

