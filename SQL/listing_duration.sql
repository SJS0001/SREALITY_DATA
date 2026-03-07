CREATE OR REFRESH MATERIALIZED VIEW listing_duration_table AS
WITH limits AS (
    SELECT
        MIN(first_seen) AS first_day,
        MAX(last_seen) AS last_day
    FROM sreality_clean
)

SELECT
    *,
    price / velikost AS price_per_m2,
    DATEDIFF(last_seen, first_seen) AS listing_duration_days
FROM sreality_clean
WHERE first_seen > (SELECT first_day FROM limits)
AND last_seen < (SELECT last_day FROM limits)