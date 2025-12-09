 USE CryptoDW;
GO

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

CREATE TABLE StgTrades (
    aggId BIGINT,
    price DECIMAL(18,8),
    quantity DECIMAL(18,8),
    timestamp_ms BIGINT,
    buyerMaker BIT,
    ignored VARCHAR(50),
    coin_symbol NVARCHAR(20),
    month VARCHAR(20)
);

CREATE TABLE StgNews (
    publish_time DATETIME,
    coin_symbol NVARCHAR(20),
    title VARCHAR(400),
    subject VARCHAR(150),
    sentiment_class VARCHAR(50),
    polarity FLOAT,
    subjectivity FLOAT
);

CREATE TABLE StgBlockchain (
    full_date DATE,
    coin_symbol NVARCHAR(20),
    active_addresses INT,
    block_count INT,
    tx_count INT,
    

CREATE TABLE StgMarketLive (
    snapshot_time DATETIME,
    coin_symbol NVARCHAR(20),
    price_usd DECIMAL(18,8),
    market_cap DECIMAL(18,2),
    volume_24h DECIMAL(18,8),
    change_24h FLOAT
);

CREATE TABLE StgMood (
    full_date DATE,
    fear_greed_value INT,
    classification VARCHAR(80)
);


GO
SELECT name FROM sys.tables ORDER BY name;


ALTER TABLE  StgBlockchain
DROP COLUMN fee_total_usd;
