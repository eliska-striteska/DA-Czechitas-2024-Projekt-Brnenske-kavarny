# Script pro stažení dat z https://nominatim.org/release-docs/latest/api/Overview/
# získání informace o katastrálním území, na kterém se kavárna nachází (zjišťováno podle souřadnic)

import geopy
import geopy.geocoders
from geopy.extra.rate_limiter import RateLimiter
import pandas as pd
from tqdm import tqdm
from functools import partial
import json


# inicializuje progressbar knihovnu tqdm pro pandas
tqdm.pandas()

df = pd.read_json("maps_google_scraped_final_dataset_V2.json")

print(df)

# inicializace objektu pro práci s nominatim api
napi = geopy.geocoders.Nominatim(user_agent="czechitas-project-eliska")

# inicializace rate limiteru s prodlevou minimálně 1 sekunda
reverse = RateLimiter(napi.reverse, min_delay_seconds=1)

# vytvoření tuple ze souřadnic
df["coords"] = list(zip(df["location"].str["lat"], df["location"].str["lng"]))

# zavolání api s ratelimiterem a progressbarem nad souřadnicemi
df["neigbourhood"] = df["coords"].progress_apply(partial(reverse, zoom=14))
df["neigbourhood"] = df["neigbourhood"].apply(lambda x: x.address)

df.to_csv("maps_google_scraped_final_dataset_V5.csv")
