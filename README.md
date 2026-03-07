# 🏘️ Sreality Data Pipeline & Market Analysis (Brno)

Tento projekt představuje end-to-end datové řešení pro automatizovaný monitoring, zpracování a vizualizaci realitního trhu v Brně. Systém denně analyzuje data z portálu Sreality, prochází kompletní transformací v cloudovém prostředí **Databricks** a poskytuje business insights skrze interaktivní dashboardy.



## 📊 Business Insights (Stav k 7. 3. 2026)
Na základě analýzy **1 237 aktivních inzerátů** s průměrnou dobou vystavení **3,79 dne** systém identifikoval klíčové trendy:

* **Rychlost trhu:** Byty s dispozicí **1+kk** mizí z trhu nejrychleji (průměrně kolem **3 dnů**), zatímco u **2+1** trvá pronájem nejdéle (**5,67 dne**).
* **Cenová analýza:** Průměrná cena za m² u dispozic **1+kk** přesahuje hranici **400 Kč**, což představuje nejvyšší jednotkovou cenu na trhu.
* **Lokalizace:** Nejvyšší koncentrace nabídek se nachází v městské části **Zábrdovice** (přes 140 inzerátů).

## 🛠️ Technická Architektura
Projekt využívá **Medallion Architecture** implementovanou v prostředí Databricks:

### 1. Bronze Layer (Raw Data)
* **Ingestion:** Automatizovaný Python scraper spouštěný denně v 06:00 jako Databricks Job.
* **Storage:** Ukládání surových dat se všemi atributy (listingID, price, cityPart, GPS souřadnice).

### 2. Silver Layer (Cleaned & Standardized)
* **Data Cleaning:** SQL pipeline pro typování dat, ošetření duplicit a normalizaci textových polí.
* **Feature Engineering:** Výpočet klíčových metrik jako cena za m² a sledování doby expozice inzerátu (rozdíl mezi `first_seen` a `last_seen`).

### 3. Gold Layer (Business Ready)
* **Aggregations:** Finální pohledy (Views) připravené pro vizualizaci.
* **Reporting:** Automatizované výpočty průměrů podle dispozic a lokalit pro potřeby dashboardu.

### 📈 Vizualizace a Business Intelligence
Data jsou vizualizována v interaktivním Databricks SQL Dashboardu, který poskytuje čtyři klíčové pohledy na brněnský realitní trh:

* Mapa nájemního trhu v Brně: Geografické zobrazení distribuce nabídek. Velikost bodu reprezentuje počet inzerátů v dané lokalitě, zatímco barva vyjadřuje průměrnou cenu nájmu za m². Pro vyšší přehlednost jsou zobrazeny primárně vnitřní části města.

* Průměrná doba inzerce podle dispozice: Analýza likvidity trhu ukazující, jak rychle se byty pronajímají. Zatímco byty 1+1 jsou v průměru vystaveny pouze 3 dny, u dispozic 2+1 je doba expozice nejdelší, a to 5,67 dne. Celková průměrná doba pronájmu napříč trhem je 3,79 dne.

* Cena za m² podle velikosti bytu: Srovnání jednotkových cen nájmů. Z analýzy vyplývá, že nejvyšší jednotkovou cenu mají byty 1+kk, kde průměr dosahuje téměř 500 Kč/m². U velkých bytů (např. 4+1) cena klesá k cca 260 Kč/m².

* Počet nabídek podle městských částí: Horizontální analýza dostupnosti bydlení v jednotlivých čtvrtích. Celkový dataset obsahuje 1 237 aktivních inzerátů, přičemž největší výběr je v městské části Zábrdovice (přes 140 inzerátů) a Židenice (přes 100 inzerátů).

  Odkaz přímo na DataBricks: https://dbc-4cf67b0e-8b5b.cloud.databricks.com/dashboardsv3/01f119fd085a1cdc82e876f8c36b2358/published?o=7474648947285826

  ![Dashboard Screenshot](srealityDashboard.png)
