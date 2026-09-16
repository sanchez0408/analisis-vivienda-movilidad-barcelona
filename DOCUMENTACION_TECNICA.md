# Arquitectura técnica y herramientas

El proyecto combina Excel, Power Query, DAX, SQL/BigQuery y Power BI para la preparación, transformación, modelado, análisis y visualización de los datos.

## Excel — Preparación y estructuración inicial

Excel se utiliza como etapa inicial para organizar y estructurar determinados conjuntos de datos antes de su importación en Power BI.

Entre las principales tareas realizadas:

- revisión y organización de los datos descargados de las fuentes oficiales;
- selección de variables relevantes para el análisis;
- estructuración de tablas y columnas;
- homogeneización inicial de formatos;
- preparación de archivos de trabajo antes de su transformación en Power Query.

Esta etapa permite disponer de una estructura de datos clara antes de realizar las transformaciones, relaciones y cálculos dentro del modelo de Power BI.

## Power Query — Preparación de datos

Power Query se utiliza para transformar y estructurar las diferentes fuentes antes de integrarlas en el modelo.

Entre las principales transformaciones:

- limpieza y tipado de datos;
- normalización de identificadores de barrios;
- transformación de datos históricos de alquiler y renta;
- creación de tablas intermedias para el cálculo de evoluciones;
- estimación de la renta disponible 2024–2025;
- actualización del coste de vida 2025 mediante IPC;
- preparación de dimensiones y tablas para el modelo analítico.

## DAX — Indicadores y lógica analítica

Las medidas DAX permiten construir indicadores dinámicos y sensibles al contexto de filtros del dashboard.

Entre ellos:

- precio medio del alquiler;
- renta disponible mensual;
- carga del alquiler;
- variaciones interanuales;
- coste de vida seleccionado;
- coste mensual total;
- renta restante estimada;
- oferta diaria de transporte;
- número de líneas disponibles;
- número de barrios conectados.

La página **«¿Dónde vivir?»** utiliza además medidas dinámicas para recalcular los resultados según el barrio y las categorías de gasto seleccionadas.

## BigQuery / SQL — Procesamiento de GTFS

Los datos GTFS requieren un tratamiento específico debido al volumen y a la estructura relacional de los archivos.

BigQuery y SQL se utilizan para procesar principalmente:

`routes · trips · stops · stop_times · calendar · calendar_dates`

El procesamiento permite:

1. identificar los servicios activos;
2. asociar rutas, viajes, horarios y paradas;
3. distinguir autobús TMB y Metro/FGC;
4. calcular la oferta programada por barrio;
5. identificar las líneas disponibles;
6. construir las conexiones directas entre barrios.

Para la conectividad, los barrios que comparten una misma línea se relacionan entre sí mediante SQL, permitiendo calcular el número de barrios directamente accesibles desde cada zona.

## Power BI — Modelo y visualización

Power BI centraliza el modelo final y la experiencia interactiva del proyecto.

El modelo relaciona los datos económicos, geográficos y de movilidad alrededor de la dimensión **Barrio**, permitiendo que los filtros se propaguen entre los diferentes análisis.

El informe utiliza:

- KPIs dinámicos;
- mapas por barrio;
- series temporales;
- comparaciones territoriales;
- segmentadores interactivos;
- formato condicional;
- navegación entre páginas;
- medidas dependientes del contexto de selección.
