CREATE OR REFRESH MATERIALIZED VIEW sreality_clean AS
SELECT
    listingID,
    LOWER(cityPart) as cityPart,
    TRIM(dispozice) as dispozice,
    price,
    velikost,
    latitude,
    longitude,
    first_seen,
    last_seen
FROM workspace.default.sreality_brno_silver
WHERE price IS NOT NULL
  AND velikost IS NOT NULL
  AND cityPart IS NOT NULL
  AND dispozice IS NOT NULL
  AND latitude IS NOT NULL
  AND longitude IS NOT NULL
  AND first_seen IS NOT NULL
  AND last_seen IS NOT NULL
  AND dispozice != 'Pokoj' 
  AND dispozice  != '6 a více'
  AND dispozice != 'Atypický'
  AND price > 1000           
  AND velikost > 5
