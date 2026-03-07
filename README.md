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

## 📈 Vizualizace (Databricks SQL Dashboard)
Projekt obsahuje interaktivní dashboardy vizualizující:
