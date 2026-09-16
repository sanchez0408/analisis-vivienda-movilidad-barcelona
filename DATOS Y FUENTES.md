# Datos y fuentes

---

El proyecto utiliza principalmente datos públicos procedentes de organismos oficiales.

## Alquiler — Generalitat de Catalunya / INCASÒL

Los datos proceden de la explotación estadística de las **fianzas de alquiler depositadas en INCASÒL** y permiten analizar el precio medio mensual de los contratos registrados por barrio.

Por este motivo, los valores representan alquileres contractuales registrados y no deben interpretarse como precios actuales de oferta del mercado inmobiliario.

[Consultar Precio medio (€) del alquiler de viviendas](https://portaldades.ajuntament.barcelona.cat/es/estad%C3%ADsticas/b37xv8wcjh)

---

## Renta disponible — Ajuntament de Barcelona

Se utiliza la **Renta Disponible de los Hogares per cápita (RDLpc)** publicada por el Ajuntament de Barcelona.

El último año oficial utilizado a nivel de barrio es **2023**. Los valores posteriores utilizados en la página «¿Dónde vivir?» son estimaciones propias y se identifican explícitamente como tales.

[Consultar Renta disponible de los hogares per cápita (RDLpc, €)](https://portaldades.ajuntament.barcelona.cat/es/estad%C3%ADsticas/nzjnewo7n6)

Para la estimación de 2025 también se utiliza la evolución trimestral de la Renta Disponible de los Hogares de Barcelona publicada por la Oficina Municipal de Dades (OMD).

[Consultar informe RDL Barcelona — 4º trimestre 2025](https://bcnroc.ajuntament.barcelona.cat/jspui/bitstream/11703/147552/1/Informe_RDL_BCN_4rt_Trimestre_25.pdf)

---

## Coste de vida — Idescat

El análisis parte de la **Despesa anual per grups de despesa ECOICOP/EPF (3 dígits) de Catalunya, 2023** publicada por Idescat.

Al no disponer de una desagregación equivalente para los 73 barrios de Barcelona, los datos de **Catalunya se utilizan como referencia territorial**.

Los gastos relacionados con la vivienda se excluyen del cálculo para evitar una doble contabilización con el alquiler.

[Consultar EPF 2023 — Idescat](https://www.idescat.cat/pub/?id=edcl&n=9433&lang=es)

---

## IPC 2024-2025 — Idescat / INE

Índice de Precios de Consumo de Catalunya por grupos de consumo, utilizado para actualizar las categorías de gasto de 2024 a 2025.

[Consultar IPC 2024 por grupos de consumo](https://www.idescat.cat/indicadors/?id=aec&n=15361&lang=es&t=202400)

[Consultar IPC 2025 por grupos de consumo](https://www.idescat.cat/indicadors/?id=aec&n=15361&lang=es)

---

## Movilidad — Autoritat del Transport Metropolità (ATM)

La oferta de transporte se construye a partir de datos **GTFS 2026 de la Autoritat del Transport Metropolità (ATM)**.

El modelo procesa rutas, viajes, paradas, horarios y calendarios para estimar la oferta programada de autobús TMB y Metro/FGC por barrio.

Los indicadores representan **servicios programados**, no demanda de viajeros, puntualidad ni servicio realmente ejecutado.

**Fuente: Autoritat del Transport Metropolità (ATM), datos GTFS 2026. Elaboración propia.**

---

## Geografía — Open Data Barcelona

Geometrías y unidades administrativas oficiales utilizadas para representar los **73 barrios de Barcelona**.

**Fuente: Ajuntament de Barcelona — Open Data BCN / CartoBCN, “Unidades administrativas de la ciudad de Barcelona”.**

[Consultar límites administrativos de barrios](https://opendata-ajuntament.barcelona.cat/data/es/dataset/20170706-districtes-barris)
