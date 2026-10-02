-- Builds one row per hour: averages of all 20-second readings,
-- with short, clean column names and the filled-in flag joined on.

CREATE OR REPLACE TABLE filled AS
SELECT * FROM read_csv('data/filled_hours.csv', header = true);

CREATE OR REPLACE TABLE hourly AS
SELECT
    r.date                                   AS hour,
    COUNT(*)                                 AS n_readings,
    AVG("% Iron Feed")                       AS iron_feed,
    AVG("% Silica Feed")                     AS silica_feed,
    AVG("Starch Flow")                       AS starch_flow,
    AVG("Amina Flow")                        AS amina_flow,
    AVG("Ore Pulp Flow")                     AS pulp_flow,
    AVG("Ore Pulp pH")                       AS pulp_ph,
    AVG("Ore Pulp Density")                  AS pulp_density,
    AVG("Flotation Column 01 Air Flow")      AS air_01,
    AVG("Flotation Column 02 Air Flow")      AS air_02,
    AVG("Flotation Column 03 Air Flow")      AS air_03,
    AVG("Flotation Column 04 Air Flow")      AS air_04,
    AVG("Flotation Column 05 Air Flow")      AS air_05,
    AVG("Flotation Column 06 Air Flow")      AS air_06,
    AVG("Flotation Column 07 Air Flow")      AS air_07,
    AVG("Flotation Column 01 Level")         AS level_01,
    AVG("Flotation Column 02 Level")         AS level_02,
    AVG("Flotation Column 03 Level")         AS level_03,
    AVG("Flotation Column 04 Level")         AS level_04,
    AVG("Flotation Column 05 Level")         AS level_05,
    AVG("Flotation Column 06 Level")         AS level_06,
    AVG("Flotation Column 07 Level")         AS level_07,
    AVG("% Iron Concentrate")                AS iron_conc,
    AVG("% Silica Concentrate")              AS silica_conc,
    ANY_VALUE(f.is_filled)                   AS is_filled
FROM raw r
LEFT JOIN filled f ON f.date = r.date
GROUP BY r.date
ORDER BY hour;