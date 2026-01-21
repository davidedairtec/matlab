
import pandas as pd
import numpy as np
import requests
from bs4 import BeautifulSoup
import re
import time

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options

import json

#del modulo bs4 importo el beatutifulsoup
data = {
    'Activo': ['AAPL', 'GOOGL', 'TSLA', 'AMZN'],
    'Precio': [150.25, 2750.30, 700.50, 3400.75],
    'Volumen': [1000000, 500000, 750000, 250000],
    'Sector': ['Tecnología', 'Tecnología', 'Automotriz', 'Tecnología']
}

df=pd.DataFrame(data)
print(f"valores {df}" )
print(f"\nvalores:\n{df.shape}")
print(f"\ncolumnas:\n{df.columns.tolist()}")
print(f"\ncolumnaespecifica:\n{df.loc[0]}")
print(f"\nvalorespecifico:\n {df.loc[0,"Activo"]}")
print(f"\nvalor:\n{df.iloc[0:10]}")
print(f"\npreciopromedio:\n{ df.groupby("Sector")["Precio"].mean()}")

datos = {
    'Activo': ['AAPL', 'GOOGL', 'TSLA', 'AMZN'],
    'Precio': [150.25, 2750.30, 700.50, 3400.75],
    'Volumen': [1000000, 500000, 750000, 250000],
    'Sector': ['Tecnología', 'Tecnología', 'Automotriz', 'Tecnología']
}
tf=pd.DataFrame(datos,index=["ind1","ind2","ind3","ind4"])
print(f"\ndatas:\n{tf}")
print(f"\nvalor1:\n{tf.iloc[1,1]}")
print(f"\nvalor2:\n{tf.loc["ind2","Precio"]}")
print(f"\nvalor3:\n{tf.iloc[:,:2]}")
print(f"\nvalor4:\n{tf.loc[:,:"Volumen"]}")



url = "https://13f.info/data/13f/000090514825003925"

r = requests.get(url)
data = r.json()
rows=data["data"]
columns = [
    "symbol", "issuer_name", "class", "cusip",
    "value_000", "percent", "shares", "principal", "option_type"
]

df = pd.DataFrame(rows,columns=columns)

print(f"\nvalornuevo:\n{df.head()}")

print(f"\nvalorfiltrado:\n{df.iloc[:,2]}")
filtrado = df[df.iloc[:, 2] == "DEPOSITARY RECEIPT"]
print(f"\nvalorfiltrado1:\n{filtrado}")

filtrado.to_csv("holdings_jump_financial_q3_2025.csv", index=False)
