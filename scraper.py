import requests, re, json
from bs4 import BeautifulSoup
from datetime import datetime
from pyspark.sql.functions import current_date

all_listings = []

today = datetime.now().strftime('%Y-%m-%d')

session = requests.Session()

strana = 1

homePage = "https://www.sreality.cz/"
r = session.get(homePage)
scraper = BeautifulSoup(r.text, 'html.parser')
find = scraper.find('script', id="__NEXT_DATA__")
json_data = json.loads(find.string)
version = json_data["buildId"]

while True:
    baseURL = f"https://www.sreality.cz/_next/data/{version}/cs/hledani/pronajem/byty.json?strana={strana}&region=Brno&region-id=5740&region-typ=municipality&slug=pronajem&slug=byty"

    response = session.get(baseURL)
    data = response.json()

    results = data["pageProps"]["dehydratedState"]["queries"][1]["state"]["data"]["results"]

    if not results: 
        break

    print(f"Printing page {strana}")

    for result in results:
        dispozice = result["categorySubCb"]["name"]
        cityPart = result["locality"]["cityPartSeoName"]
        latitude = result["locality"]["latitude"]
        longitude = result["locality"]["longitude"]
        price = result["priceCzk"]
        name = result["name"]
        listingID = result["id"]

        match = re.search(r'(\d+)[\s\xa0]*m[²2]', name)
        velikost = match.group(1) if match else None


        all_listings.append({
            "listingID": listingID,
            "dispozice": dispozice,
            "cityPart": cityPart,
            "price": int(price),
            "latitude": float(latitude),
            "longitude": float(longitude),
            "velikost": int(velikost) if velikost else None,
            "first_seen": today,
            "last_seen": today
        })
    strana += 1

df_new = spark.createDataFrame(all_listings)
df_new.createOrReplaceTempView("staged_updates")

spark.sql("""
CREATE TABLE IF NOT EXISTS sreality_brno_silver
USING DELTA
AS SELECT * FROM staged_updates WHERE 1=0
""")

spark.sql("""
ALTER TABLE sreality_brno_silver SET TBLPROPERTIES (delta.enableChangeDataFeed = true)
""")

spark.sql("""
MERGE INTO sreality_brno_silver AS target
USING staged_updates AS source
ON target.listingID = source.listingID
WHEN MATCHED AND target.price <> source.price THEN
  UPDATE SET 
    target.price = source.price,
    target.last_seen = source.last_seen
WHEN MATCHED THEN
  UPDATE SET target.last_seen = source.last_seen
WHEN NOT MATCHED THEN
  INSERT *
""")

print("Data úspěšně uložena do Delta tabulky.")

print(f"Celkem staženo {len(all_listings)} inzerátů.")

