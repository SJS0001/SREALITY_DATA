CREATE OR REFRESH MATERIALIZED VIEW avg_price_by_dispozice AS
SELECT
    dispozice,
    ROUND(AVG(price_per_m2)) AS avg_price_per_m2,
    COUNT(*) AS count_listings
FROM sreality_gold
GROUP BY dispozice
ORDER BY avg_price_per_m2 DESC;

CREATE OR REFRESH MATERIALIZED VIEW count_listings_cityPart AS
SELECT
    cityPart,
    COUNT(*) AS num_listings
FROM sreality_gold
GROUP BY cityPart
ORDER BY num_listings DESC;

CREATE OR REFRESH MATERIALIZED VIEW map_aggregated AS
SELECT
    cityPart,
    ROUND(AVG(price_per_m2)) AS avg_price_per_m2,
    AVG(latitude) AS avg_latitude,
    AVG(longitude) AS avg_longitude,
    COUNT(*) AS num_listings
FROM sreality_gold
GROUP BY cityPart;