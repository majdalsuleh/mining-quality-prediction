-- Hours we trust for silica analysis: after the 13-day gap,
-- and only real (not filled-in) lab results.
CREATE OR REPLACE VIEW clean AS
SELECT *
FROM hourly
WHERE hour >= TIMESTAMP '2017-03-29 12:00:00'
  AND NOT is_filled;