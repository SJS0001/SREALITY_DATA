CREATE OR REFRESH MATERIALIZED VIEW price_per_m2_table AS
SELECT
    cityPart,
    AVG(price_per_m2) as avg_price
FROM workspace.default.sreality_gold
GROUP BY cityPart
ORDER BY avg_price DESC