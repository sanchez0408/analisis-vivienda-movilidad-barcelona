-- ============================================================
-- Proyecto: Análisis de vivienda y movilidad en Barcelona
-- Archivo: 03_conectividad_barrios.sql
--
-- Objetivo:
-- Identificar las conexiones directas entre barrios a partir
-- de las líneas de transporte público que comparten.
--
-- Definición:
-- Dos barrios se consideran conectados directamente cuando
-- comparten al menos una línea de Autobús TMB o Metro / FGC,
-- sin necesidad de transbordo.
--
-- Motor SQL:
-- GoogleSQL / BigQuery
-- ============================================================


CREATE OR REPLACE TABLE
  `mon-projet-bigquery-481616.proyecto_barcelona.conectividad_barrios_2026` AS


-- ------------------------------------------------------------
-- 1. Lista única de líneas presentes en cada barrio
-- ------------------------------------------------------------

WITH lineas_barrios AS (
  SELECT DISTINCT
    barrio_id,
    barrio_name,
    route_id
  FROM
    `mon-projet-bigquery-481616.proyecto_barcelona.movilidad_lineas_2026`
),


-- ------------------------------------------------------------
-- 2. Identificación de conexiones directas entre barrios
--
-- Self-join:
-- dos barrios están conectados cuando comparten un route_id.
--
-- Se excluye la conexión de un barrio consigo mismo.
--
-- nb_lineas_conectadas indica cuántas líneas distintas
-- comparten el barrio de origen y el barrio de destino.
-- ------------------------------------------------------------

conexiones AS (
  SELECT
    a.barrio_id AS barrio_origine_id,
    b.barrio_id AS barrio_destination_id,
    a.barrio_name AS barrio_origine,
    b.barrio_name AS barrio_destination,
    COUNT(DISTINCT a.route_id) AS nb_lineas_conectadas
  FROM
    lineas_barrios a
  INNER JOIN
    lineas_barrios b
      ON a.route_id = b.route_id
      AND a.barrio_id != b.barrio_id
  GROUP BY
    a.barrio_id,
    b.barrio_id,
    a.barrio_name,
    b.barrio_name
),


-- ------------------------------------------------------------
-- 3. Número total de barrios conectados directamente
--    desde cada barrio de origen
-- ------------------------------------------------------------

barrios_conectados AS (
  SELECT
    barrio_origine_id,
    barrio_origine,
    COUNT(DISTINCT barrio_destination_id)
      AS nb_barrios_conectados
  FROM
    conexiones
  GROUP BY
    barrio_origine_id,
    barrio_origine
)


-- ------------------------------------------------------------
-- 4. Tabla final para el modelo de Power BI
-- ------------------------------------------------------------

SELECT
  c.barrio_origine_id,
  c.barrio_destination_id,
  c.barrio_origine,
  c.barrio_destination,
  c.nb_lineas_conectadas,
  bc.nb_barrios_conectados
FROM
  conexiones c
LEFT JOIN
  barrios_conectados bc
    ON c.barrio_origine_id = bc.barrio_origine_id;
