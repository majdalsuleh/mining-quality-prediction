-- Q: What is the 24-hour rolling average of silica?
SELECT
    hour,
    ROUND(silica_conc, 2) AS silica,
    ROUND(AVG(silica_conc) OVER (
        ORDER BY hour
        RANGE BETWEEN INTERVAL 23 HOURS PRECEDING AND CURRENT ROW
    ), 2) AS silica_24h_avg
FROM clean
ORDER BY hour;