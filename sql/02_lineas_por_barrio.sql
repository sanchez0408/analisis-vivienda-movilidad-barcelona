-- ============================================================
-- Proyecto: Análisis de vivienda y movilidad en Barcelona
-- Archivo: 02_lineas_por_barrio.sql
--
-- Objetivo:
-- Identificar las líneas de transporte público disponibles
-- en cada barrio y fecha a partir de los datos GTFS de la ATM.
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
  `mon-projet-bigquery-481616.proyecto_barcelona.movilidad_lineas_2026` AS


-- ------------------------------------------------------------
-- 1. Identificación de los servicios GTFS activos cada día
-- ------------------------------------------------------------

WITH servicios_activos AS (
  SELECT
    PARSE_DATE('%Y%m%d', date) AS fecha,
    service_id
  FROM
    `mon-projet-bigquery-481616.proyecto_barcelona.calendar_date`
  WHERE
    exception_type = 1
    AND PARSE_DATE('%Y%m%d', date)
        BETWEEN DATE '2026-08-05' AND DATE '2026-12-31'
)


-- ------------------------------------------------------------
-- 2. Asociación de cada línea con los barrios que atraviesa
--
-- La cadena de joins conecta:
-- servicio → viaje → línea → parada → barrio.
--
-- DISTINCT evita duplicar una misma línea dentro de un barrio
-- cuando un viaje contiene varias paradas en ese territorio.
-- ------------------------------------------------------------

SELECT DISTINCT
  sb.barrio_id,
  sb.barrio_name,
  sb.district_id,
  sa.fecha,
  CASE
    WHEN EXTRACT(DAYOFWEEK FROM sa.fecha) = 7 THEN 'Sábado'
    WHEN EXTRACT(DAYOFWEEK FROM sa.fecha) = 1 THEN 'Domingo'
    ELSE 'Semana'
  END AS tipo_dia,
  CASE
    WHEN r.route_type = 3
         AND r.agency_id = 'TMB_'
      THEN 'Autobús'
    WHEN r.route_type = 1
      THEN 'Metro'
  END AS modo_transporte,
  r.route_id,
  r.route_short_name
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
     OR r.route_type = 1;
