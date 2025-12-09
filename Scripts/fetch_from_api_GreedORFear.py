import requests
import pandas as pd
from datetime import datetime

url = "https://api.alternative.me/fng/?limit=0&format=json"
r = requests.get(url)
if r.status_code != 200:
    print("! API ERROR:", r.status_code)
    print(r.text)
    df = pd.DataFrame()
else:
    data = r.json()["data"]
    df = pd.DataFrame(data)
    # Convert timestamp to readable date
    df["date"] = df["timestamp"].apply(lambda x: datetime.utcfromtimestamp(int(x)))
    df = df.rename(columns={
        "value":"fear_greed_value",
        "value_classification":"fear_greed_class"
    })
    df = df[["date","fear_greed_value","fear_greed_class"]]

    df.to_csv("../data/raw/fear_greed.csv", index=False)
    print("ok, Fear & Greed CSV created:", df.shape)
