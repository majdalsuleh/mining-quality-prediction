-- Q: Which 10 days had the worst average quality?
WITH daily AS (
    SELECT
        CAST(hour AS DATE)          AS day,
        COUNT(*)                    AS hours,
        ROUND(AVG(silica_conc), 2)  AS avg_silica
    FROM clean
    GROUP BY day
    HAVING COUNT(*) >= 12           -- skip days with too few real hours
)
SELECT
    RANK() OVER (ORDER BY avg_silica DESC) AS rank,
    day, hours, avg_silica
FROM daily
ORDER BY rank
LIMIT 10;