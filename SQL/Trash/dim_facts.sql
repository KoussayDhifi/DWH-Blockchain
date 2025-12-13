CREATE TABLE DimDate (
    date_id INT IDENTITY(1,1) PRIMARY KEY,
    full_date DATE UNIQUE,
    day INT,
    month INT,
    year INT,
    week INT
);
CREATE TABLE DimCoin (
    coin_id INT IDENTITY(1,1) PRIMARY KEY,
    coin_symbol VARCHAR(20) UNIQUE,
    coin_name VARCHAR(100)
);
CREATE TABLE DimSentiment (
    sentiment_id INT IDENTITY(1,1) PRIMARY KEY,
    sentiment_class VARCHAR(50),
    min_polarity float not null;
    max_polarity float not null;
);

CREATE TABLE DimMood (
    mood_id INT IDENTITY(1,1) PRIMARY KEY,
    classification VARCHAR(50)
    min_value int ,
    max_value int ;
);

CREATE TABLE DimTradeTpe(
trade_type_id INT IDENTITY(1,1) PRIMARY KEY,
label VARCHAR(20)
);

CREATE TABLE FactPriceDaily (
    price_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT,
    coin_id INT,
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
    trade_id BIGINT PRIMARY KEY,
    date_id INT,
    coin_id INT,
    price FLOAT,
    quantity FLOAT,
    trade_type_id  INT PRIMARY KEY null,
    trade_value AS (price * quantity) PERSISTED,
 FOREIGN KEY (date_id) REFERENCES DimDate(date_id),
 FOREIGN KEY (coin_id) REFERENCES DimCoin(coin_id)
FOREIGN KEY (trade_type_id) REFERENCES DimTradeType(trade_type_id)
 );
 CREATE TABLE FactNewsSentiment (
    news_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT,
    coin_id INT,
    sentiment_id INT,
    title VARCHAR(255),
    polarity FLOAT,
    subjectivity FLOAT,

    FOREIGN KEY (date_id) REFERENCES DimDate(date_id),
    FOREIGN KEY (coin_id) REFERENCES DimCoin(coin_id),
    FOREIGN KEY (sentiment_id) REFERENCES DimSentiment(sentiment_id)
);
CREATE TABLE FactBlockchainActivity (
    blockchain_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT,
    coin_id INT,
    active_addresses INT,
    block_count INT,
    tx_count INT,

    FOREIGN KEY (date_id) REFERENCES DimDate(date_id),
    FOREIGN KEY (coin_id) REFERENCES DimCoin(coin_id)
);
CREATE TABLE FactMarketSnapshot (
    snapshot_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id DATETIME,
    coin_id INT,
    price_usd FLOAT,
    market_cap FLOAT,
    volume_24h FLOAT,
    change_24h FLOAT,
	FOREIGN KEY (date_id) REFERENCES DimDate(date_id),
    FOREIGN KEY (coin_id) REFERENCES DimCoin(coin_id)
);
CREATE TABLE FactMoodIndex (
    mood_fact_id INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT,
    mood_id INT,
    greed_value INT,

    FOREIGN KEY (date_id) REFERENCES DimDate(date_id),
    FOREIGN KEY (mood_id) REFERENCES DimMood(mood_id)
);
CREATE INDEX idx_price_date ON FactPriceDaily(date_id);
CREATE INDEX idx_trades_date ON FactTrades(date_id);
CREATE INDEX idx_trades_coin ON FactTrades(coin_id);
CREATE INDEX idx_news_coin ON FactNewsSentiment(coin_id);
CREATE INDEX idx_blockchain_date ON FactBlockchainActivity(date_id);
CREATE INDEX idx_marketlive_coin ON FactMarketLive(coin_id);

    

