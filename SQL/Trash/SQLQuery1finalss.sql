USE CryptoDW_;
create database CryptoDW_ ;
use CryptoSourceDB ;
GO
select * from Dimmood;
select * from Stgmarketlive;
select * from dimsentiment;
stgtMa

-----------------------------
-- 1️⃣ STAGING TABLES
-- All date columns are DATE type
-----------------------------
delete from stgtMa;
/* this create in other database as source 
CREATE TABLE News_(
    id INT IDENTITY(1,1) PRIMARY KEY,
    publish_time DATE,
    coin_symbol NVARCHAR(10),
    title NVARCHAR(400),
    subject NVARCHAR(150),
    sentiment_class NVARCHAR(20),
    polarity FLOAT,
    subjectivity FLOAT




);*/




CREATE TABLE News(
    id INT IDENTITY(1,1) PRIMARY KEY,
    publish_time DATE,
    coin_symbol NVARCHAR(10),
    title NVARCHAR(400),
    subject NVARCHAR(150),
    sentiment_class NVARCHAR(20),
    polarity FLOAT,
    subjectivity FLOAT);


-- Staging Price Daily
CREATE TABLE StgPriceDaily (
    full_date DATE,
    open_price DECIMAL(18,8),
    high_price DECIMAL(18,8),
    low_price DECIMAL(18,8),
    close_price DECIMAL(18,8),
    volume DECIMAL(18,8),
    quote_volume DECIMAL(18,8),
    trades_count INT,
    taker_buy_volume DECIMAL(18,8),
    taker_buy_quote DECIMAL(18,8),
    coin_symbol NVARCHAR(20)
);

-- Staging Trades
CREATE TABLE StgTrades (
    aggId BIGINT PRIMARY KEY,
    price DECIMAL(18,8),
    quantity DECIMAL(18,8),
    trade_date DATE,
    buyerMaker BIT,
    coin_symbol NVARCHAR(20)
);

-- Staging News
CREATE TABLE StgNews (
    publish_date DATE,
    coin_symbol NVARCHAR(20),
    title NVARCHAR(400),
    subject NVARCHAR(150),
    sentiment_class NVARCHAR(50),
    polarity FLOAT,
    subjectivity FLOAT
);

-- Staging Blockchain / Metrics
CREATE TABLE StgBlockchain (
    full_date DATE,
    coin_symbol NVARCHAR(20),
    active_addresses INT,
    block_count INT,
    tx_count INT
);

-- Staging Market Live
CREATE TABLE StgMarketLive (
    snapshot_date DATE,
    coin_symbol NVARCHAR(20),
    price_usd DECIMAL(18,8),
    market_cap DECIMAL(38,2),
    volume_24h DECIMAL(18,8),
    change_24h FLOAT
);

-- Staging Mood / Fear & Greed
CREATE TABLE StgMood (
    full_date DATE,
    fear_greed_value INT,
    classification NVARCHAR(80)
);

-----------------------------
-- 2️⃣ DIMENSIONS
-----------------------------

CREATE TABLE DimDate (
    date_id INT IDENTITY(1,1) PRIMARY KEY,
    full_date DATE UNIQUE NOT NULL,
    day INT,
    month INT,
    year INT,
    week INT
);

CREATE TABLE DimCoin (
    coin_id INT IDENTITY(1,1) PRIMARY KEY,
    coin_symbol NVARCHAR(20) UNIQUE NOT NULL,
    coin_name NVARCHAR(100)
);

CREATE TABLE DimSentiment (
    sentiment_id INT IDENTITY(1,1) PRIMARY KEY,
    sentiment_class NVARCHAR(50),
    min_polarity FLOAT NOT NULL,
    max_polarity FLOAT NOT NULL
);

CREATE TABLE DimMood (
    mood_id INT IDENTITY(1,1) PRIMARY KEY,
    classification NVARCHAR(50),
    min_value INT,
    max_value INT
);

CREATE TABLE DimTradeType (
    trade_type_id INT IDENTITY(1,1) PRIMARY KEY,
    label NVARCHAR(20)
);

-----------------------------
-- 3️⃣ FACT TABLES
-----------------------------

CREATE TABLE FactPriceDaily (
    price_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT NOT NULL,
    coin_id INT NOT NULL,
    open_price FLOAT,
    close_price FLOAT,
    high_price FLOAT,
    low_price FLOAT,
    volume FLOAT,
    trades_count INT,
    FOREIGN KEY (date_id) REFERENCES DimDate(date_id),
    FOREIGN KEY (coin_id) REFERENCES DimCoin(coin_id)
);

CREATE TABLE FactTrades (
    trade_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    date_id INT NOT NULL,
    coin_id INT NOT NULL,
    price FLOAT,
    quantity FLOAT,
    trade_type_id INT,
    trade_value AS (price * quantity) PERSISTED,
    FOREIGN KEY (date_id) REFERENCES DimDate(date_id),
    FOREIGN KEY (coin_id) REFERENCES DimCoin(coin_id),
    FOREIGN KEY (trade_type_id) REFERENCES DimTradeType(trade_type_id)
);

CREATE TABLE FactNewsSentiment (
    news_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT NOT NULL,
    coin_id INT NOT NULL,
    sentiment_id INT NOT NULL,
    title NVARCHAR(255),
    polarity FLOAT,
    subjectivity FLOAT,
    FOREIGN KEY (date_id) REFERENCES DimDate(date_id),
    FOREIGN KEY (coin_id) REFERENCES DimCoin(coin_id),
    FOREIGN KEY (sentiment_id) REFERENCES DimSentiment(sentiment_id)
);

CREATE TABLE FactBlockchainActivity (
    blockchain_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT NOT NULL,
    coin_id INT NOT NULL,
    active_addresses INT,
    block_count INT,
    tx_count INT,
    FOREIGN KEY (date_id) REFERENCES DimDate(date_id),
    FOREIGN KEY (coin_id) REFERENCES DimCoin(coin_id)
);

CREATE TABLE FactMarketSnapshot (
    snapshot_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT NOT NULL,
    coin_id INT NOT NULL,
    price_usd FLOAT,
    market_cap FLOAT,
    volume_24h FLOAT,
    change_24h FLOAT,
    FOREIGN KEY (date_id) REFERENCES DimDate(date_id),
    FOREIGN KEY (coin_id) REFERENCES DimCoin(coin_id)
);

CREATE TABLE FactMoodIndex (
    mood_fact_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT NOT NULL,
    mood_id INT NOT NULL,
    greed_value INT,
    FOREIGN KEY (date_id) REFERENCES DimDate(date_id),
    FOREIGN KEY (mood_id) REFERENCES DimMood(mood_id)
);

-----------------------------
-- 4️⃣ INDEXES
-----------------------------

CREATE INDEX IX_Price_Date ON FactPriceDaily(date_id);
CREATE INDEX IX_Trades_Date ON FactTrades(date_id);
CREATE INDEX IX_Trades_Coin ON FactTrades(coin_id);
CREATE INDEX IX_Market_Coin ON FactMarketSnapshot(coin_id);
CREATE INDEX IX_Blockchain_Date ON FactBlockchainActivity(date_id);
CREATE INDEX IX_News_Coin ON FactNewsSentiment(coin_id);


SELECT TOP 10 
    snapshot_date, 
    coin_symbol, 
    price_usd, 
    volume_24h
FROM CryptoDW_.dbo.StgMarketLive
ORDER BY snapshot_date DESC