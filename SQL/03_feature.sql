CREATE OR REFRESH MATERIALIZED VIEW sreality_gold AS
SELECT
    *,
    price / velikost as price_per_m2,
    DATEDIFF(last_seen, first_seen) as listing_duration_days
FROM sreality_clean