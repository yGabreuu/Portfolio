import requests
import pprint
import json
import pandas as pd
url = requests.get('https://pokeapi.co/api/v2/pokemon/35/')
url = url.json()
print(url)
