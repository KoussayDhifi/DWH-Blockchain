import requests
import pandas as pd

def fetch(asset):
    url = "https://community-api.coinmetrics.io/v4/timeseries/asset-metrics"
    params = {
        "assets": asset,
        "metrics": "TxCnt,AdrActCnt,BlkCnt,FeeMean,FeeTotUSD",
        "frequency": "1d",
        "start_time": "2025-01-01"   # forcing 2025 for consistency
    }

    r = requests.get(url, params=params)

    # SECURITY CHECK
    if r.status_code != 200:
        print(f"! API ERROR for {asset}:", r.status_code)
        print(r.text)
        return pd.DataFrame()

    json_data = r.json()

    # FORMAT CHECK
    if "data" not in json_data:
        print(f"! NO DATA RETURNED for {asset}")
        print(json_data)
        return pd.DataFrame()

    df = pd.json_normalize(json_data["data"])
    print(f"✅ {asset.upper()} rows fetched:", len(df))
    return df

# FETCH BOTH COINS
btc_df = fetch("btc")
eth_df = fetch("eth")

df = pd.concat([btc_df, eth_df])

# RENAME COLUMNS
df = df.rename(columns={
    "asset": "coin_symbol",
    "time": "date",
    "TxCnt": "tx_count",
    "AdrActCnt": "active_addresses",
    "BlkCnt": "block_count",
    "FeeMean": "fee_mean_usd",
    "FeeTotUSD": "fee_total_usd"
})

# SAVE RESULT
df.to_csv("../data/raw/onchain_metrics.csv", index=False)
print("✅ FINAL FILE CREATED:", df.shape)
