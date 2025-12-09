# Plan DW\_project



## Data:



* source 1:(columns) date-open-high-low-close-volume-quote\_volume-trades-taker\_buy\_volume-taker\_buy\_quote-coin
* source 2:(columns)aggId-price-quantity-timestamp-buyerMaker-ignored-coin-month
* source3:(columns)publish\_time-coin\_symbol-title-subject-sentiment\_class-polarity-subjectivity
* source 4:(columns)coin\_symbol-date-active\_addresses-block\_count-tx\_count
* source 5:(columns)timestamp-coin-price\_usd-market\_cap-volume\_24h-change\_24h
* source 6:(columns) greed(u know)





KPI	                   Source



Price \& Market Cap	    1, 5

Trading Volume	            1, 2

Trades \& Avg Trade Size	     2

Blockchain Activity	     4

News Sentiment	             3

Fear \& Greed Index	     6

Google Trends / Hype	     7

Risk Alerts	           3 + 6



## answer key questions that a crypto investor or analyst might ask:



###### A. Price \& Market Questions (Source 1 + 5)

How did BTC and ETH prices evolve over time?

What is the daily, weekly, and monthly volatility of BTC and ETH?

How do price changes correlate with trading volume and market capitalization?



###### B. Trading Activity (Source 2 + 4)

How many trades occur per day, and what is the average trade size?

How active is each blockchain network (transactions per day, active addresses, blocks)?

Are there abnormal spikes in transactions that might indicate market events?



###### C. Sentiment \& Market Mood (Source 3 + 6 + 7)

What is the overall sentiment of news for BTC and ETH?

How does Fear \& Greed Index affect price movements and volatility?

How does Google Trends attention correlate with market behavior?



###### D. Risk \& Alerts

Are there periods of extreme market fear that could indicate risk for investors?

Are there clusters of negative sentiment in news or social media that precede large price drops?





## KPIs:

Step 2: Identify KPIs



For each question, here’s a list of KPIs you can calculate from your sources:



**KPI	                     Description	                         Source(s)**



OHLC Charts	        Open, High, Low, Close per day	                 Source 1

Daily Trading Volume	Total coins traded per day	                 Source 1, 2

Market Cap	        USD market cap per day	                         Source 5

Daily Change %	        Price change percentage per day	                 Source 1

Volatility	        Standard deviation of price over a period	 Source 1

Total Trades	        Number of trades per day			 Source 2

Avg Trade Size	        Average quantity per trade			 Source 2

Active Addresses	Number of active addresses per day		 Source 4

Blocks Produced	        Number of blocks per day			 Source 4

Sentiment Score	        Weighted average sentiment per day		 Source 3

Polarity Distribution	Count of positive / neutral / negative news	 Source 3

Fear \& Greed Value	Daily market mood 0–100				 Source 6

Risk Alerts	         Flag days of extreme fear or high negative 	Source 3, 6









#### Step 3: Map Data Sources to KPIs:

**KPI	                   Source**



Price \& Market Cap	    1, 5

Trading Volume	            1, 2

Trades \& Avg Trade Size	     2

Blockchain Activity	     4

News Sentiment	             3

Fear \& Greed Index	     6

Risk Alerts	           3 + 6









































---

🏗️ BIG STEPS OF YOUR PROJECT (END‑TO‑END)

Phase 1 — Project Definition \& Dataset Selection

🎯 Goal: Decide the theme, KPIs, and data sources.



Tasks:



Finalize topic: Crypto Exchange Activity \& Risk Monitoring



Choose datasets (CSV / JSON / API)



Identify KPIs



Define business questions



Phase 2 — Data Collection \& Staging

🎯 Goal: Bring all data locally and prepare for processing.



Tasks:



Download CSV datasets from Kaggle



Explore columns



Connect to API and test sample requests



Save all data in a Staging Folder / Database



Phase 3 — Data Warehouse Design

🎯 Goal: Create your star schema.



Tasks:



Design Fact table



Design Dimension tables



Define primary keys and foreign keys



Draw schema diagram



Phase 4 — ETL with SSIS

🎯 Goal: Clean and move data into DW



Tasks:



Build SSIS packages:



CSV ingestion



JSON ingestion



API ingestion



Data cleansing:



remove nulls



standardize dates



merge datasets



Load into dimensional model



Phase 5 — Power BI Dashboards

🎯 Goal: Build professional visuals



Tasks:



Connect Power BI to SQL Server



Build data model inside Power BI



Create dashboard pages:



KPIs



Coin analysis



Risk \& fraud



Trends



Add filters, slicers, drill‑-down



Phase 6 — Report \& Presentation

🎯 Goal: Make your academic submission



Tasks:



Write report:



datasets



ETL



warehouse



dashboard



Prepare slides



Create demo story



👥 TASK PARTITION (2 PEOPLE)

Let’s call you:



👤 Person A → Back‑end / Data Engineer

👤 Person B → Front‑end / Analyst / Business Model

👤 PERSON A — DATA ENGINEER (TECHNICAL SIDE)

RESPONSIBILITIES:

✅ Download datasets

✅ API integration

✅ Create Star Schema

✅ SQL Tables

✅ Build SSIS packages

✅ Load data into Data Warehouse

✅ Schedule refresh



MAIN OUTPUT:

SQL Scripts



DW Schema



SSIS packages



Clean DB



👤 PERSON B — DATA ANALYST / DASHBOARD

RESPONSIBILITIES:

✅ KPIs design

✅ Business questions

✅ Power BI modeling

✅ Dashboards

✅ Visual design

✅ Report drafting

✅ Presentation



MAIN OUTPUT:

Power BI dashboards



KPIs list



Insight analysis



Slides \& report



📅 5‑DAY EXECUTION PLAN

DAY 1

Both



Finalize topic



Select datasets



Define KPIs



DAY 2

Person A



Build star schema



Create SQL tables



Person B



Design dashboard mockups



Define visuals



DAY 3

Person A



Build ETL in SSIS



Load warehouse



Person B



Connect Power BI to DB



Create relationships



DAY 4

Person A



Automate refresh



Debug errors



Person B



Build dashboards



Add filters



DAY 5

Both



Write report



Finish presentation



Polish visuals



Make demo queries

