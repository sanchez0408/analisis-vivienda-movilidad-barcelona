-- ============================================================
-- Proyecto: Análisis de vivienda y movilidad en Barcelona
-- Archivo: 01_oferta_transporte_gtfs.sql
--
-- Objetivo:
-- Construir la oferta diaria programada de transporte público
-- por barrio a partir de los datos GTFS de la ATM.
--
-- Modos analizados:
--   - Autobús TMB
--   - Metro / FGC
--
-- Período:
--   05/08/2026 - 31/12/2026
--
-- Motor SQL:
--   GoogleSQL / BigQuery
-- ============================================================


CREATE OR REPLACE TABLE
  `mon-projet-bigquery-481616.proyecto_barcelona.movilidad_final_2026` AS

  
-- ------------------------------------------------------------
-- 1. Generación del calendario completo del período analizado
-- ------------------------------------------------------------

WITH fechas AS (
  SELECT fecha
  FROM UNNEST(
    GENERATE_DATE_ARRAY(
      DATE '2026-08-05',
      DATE '2026-12-31'
    )
  ) AS fecha
),

  
-- ------------------------------------------------------------
-- 2. Identificación de los servicios GTFS activos cada día
--
-- calendar_date se utiliza porque los servicios disponibles
-- en el dataset se definen mediante excepciones (type = 1).
-- ------------------------------------------------------------

servicios_activos AS (
  SELECT
    PARSE_DATE('%Y%m%d', date) AS fecha,
    service_id
  FROM
    `mon-projet-bigquery-481616.proyecto_barcelona.calendar_date`
  WHERE
    exception_type = 1
    AND PARSE_DATE('%Y%m%d', date)
        BETWEEN DATE '2026-08-05' AND DATE '2026-12-31'
),


-- ------------------------------------------------------------
-- 3. Cálculo de la oferta programada por barrio, fecha y modo
--
-- Un trip se contabiliza una sola vez por barrio aunque tenga
-- varias paradas dentro del mismo barrio gracias al DISTINCT.
-- ------------------------------------------------------------

oferta_diaria AS (
  SELECT
    sa.fecha,
    sb.barrio_id,
    sb.barrio_name,
    sb.district_id,
    CASE
      WHEN r.route_type = 3
           AND r.agency_id = 'TMB_'
        THEN 'Autobús'
      WHEN r.route_type = 1
        THEN 'Metro'
    END AS modo_transporte,
    COUNT(DISTINCT r.route_id) AS nb_lineas,
    COUNT(DISTINCT t.trip_id) AS nb_courses
  FROM
    servicios_activos sa
  JOIN
    `mon-projet-bigquery-481616.proyecto_barcelona.trips` t
      ON sa.service_id = t.service_id
  JOIN
    `mon-projet-bigquery-481616.proyecto_barcelona.routes` r
      ON t.route_id = r.route_id
  JOIN
    `mon-projet-bigquery-481616.proyecto_barcelona.stop_times` st
      ON t.trip_id = st.trip_id
  JOIN
    `mon-projet-bigquery-481616.proyecto_barcelona.stops_barrios` sb
      ON st.stop_id = sb.stop_id
  WHERE
       (r.route_type = 3 AND r.agency_id = 'TMB_')
       OR r.route_type = 1
  GROUP BY
    sa.fecha,
    sb.barrio_id,
    sb.barrio_name,
    sb.district_id,
    modo_transporte
),


-- ------------------------------------------------------------
-- 4. Lista de barrios presentes en la tabla espacial de paradas
-- ------------------------------------------------------------

barrios AS (
  SELECT DISTINCT
    barrio_id,
    barrio_name,
    district_id
  FROM
    `mon-projet-bigquery-481616.proyecto_barcelona.stops_barrios`
),

  
-- ------------------------------------------------------------
-- 5. Modos de transporte incluidos en el análisis
-- ------------------------------------------------------------

modos AS (
  SELECT 'Autobús' AS modo_transporte
  UNION ALL
  SELECT 'Metro'
)


-- ------------------------------------------------------------
-- 6. Construcción de la tabla final
--
-- CROSS JOIN genera todas las combinaciones:
-- barrio × fecha × modo.
--
-- El LEFT JOIN permite conservar también las combinaciones
-- sin servicio programado, asignándoles un valor 0.
-- ------------------------------------------------------------

SELECT
  b.barrio_id,
  b.barrio_name,
  b.district_id,
  f.fecha,
  CASE
    WHEN EXTRACT(DAYOFWEEK FROM f.fecha) = 7 THEN 'Sábado'
    WHEN EXTRACT(DAYOFWEEK FROM f.fecha) = 1 THEN 'Domingo'
    ELSE 'Semana'
  END AS tipo_dia,
  m.modo_transporte,
  COALESCE(o.nb_lineas, 0) AS nb_lineas,
  COALESCE(o.nb_courses, 0) AS nb_courses
FROM
  barrios b
CROSS JOIN
  fechas f
CROSS JOIN
  modos m
LEFT JOIN
  oferta_diaria o
    ON b.barrio_id = o.barrio_id
    AND f.fecha = o.fecha
    AND m.modo_transporte = o.modo_transporte;
