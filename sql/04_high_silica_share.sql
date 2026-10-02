-- Q: How often is silica "high" (top 25% of all trusted hours), by month?
WITH threshold AS (
    SELECT QUANTILE_CONT(silica_conc, 0.75) AS high_cutoff
    FROM clean
)
SELECT
    STRFTIME(c.hour, '%Y-%m')                                      AS month,
    ROUND(ANY_VALUE(t.high_cutoff), 2)                             AS high_cutoff,
    SUM(CASE WHEN c.silica_conc > t.high_cutoff THEN 1 ELSE 0 END) AS high_hours,
    COUNT(*)                                                       AS hours,
    ROUND(100.0 * high_hours / hours, 1)                           AS pct_high
FROM clean c
CROSS JOIN threshold t
GROUP BY month
ORDER BY month;