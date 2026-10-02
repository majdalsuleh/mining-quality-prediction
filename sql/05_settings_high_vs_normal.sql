-- Q: How do plant settings differ between high-silica and normal hours?
WITH labelled AS (
    SELECT *,
        CASE WHEN silica_conc > (SELECT QUANTILE_CONT(silica_conc, 0.75) FROM clean)
             THEN 'high' ELSE 'normal' END AS quality
    FROM clean
)
SELECT
    quality,
    COUNT(*)                    AS hours,
    ROUND(AVG(amina_flow), 1)   AS amina_flow,
    ROUND(AVG(starch_flow), 1)  AS starch_flow,
    ROUND(AVG(pulp_ph), 2)      AS pulp_ph,
    ROUND(AVG(air_01), 1)       AS air_01,
    ROUND(AVG(air_03), 1)       AS air_03,
    ROUND(AVG(level_04), 1)     AS level_04,
    ROUND(AVG(level_05), 1)     AS level_05
FROM labelled
GROUP BY quality;