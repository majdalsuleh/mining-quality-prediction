-- Q: What does silica look like each month?
SELECT
    DATE_TRUNC('month', hour)       AS month,
    COUNT(*)                        AS hours,
    ROUND(AVG(silica_conc), 2)      AS avg_silica,
    ROUND(MIN(silica_conc), 2)      AS min_silica,
    ROUND(MAX(silica_conc), 2)      AS max_silica
FROM clean
GROUP BY month
ORDER BY month;