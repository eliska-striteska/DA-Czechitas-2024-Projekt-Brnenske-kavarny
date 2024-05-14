# Ucelený kód pro práci s daty staženými přes Apify Google maps Extractor
# a pro vytvoření základního datasetu pro SQL databázi

import json


def filter_keys_in_list_of_cafes(data, keys):
    # filtruje klíče ve slovnících "cafe" obsažených v celkovém seznamu
    # parametry: data = stažená data, keys = seznam klíčů, které chceme zachovat
    filtered_data = []
    for cafe in data:
        filtered_cafe = {}
        for key, value in cafe.items():
            if key in keys:
                filtered_cafe[key] = value
        filtered_data.append(filtered_cafe)
    return filtered_data


def filter_by_category(data):
    # filtruje seznam slovníků kaváren podle klíče "categoryName"
    # parametr: data = stažená data
    filtered_cafes = []
    for cafe in data:
        if (
            cafe["categoryName"] == "Cafe"
            or cafe["categoryName"] == "Coffee shop"
            or cafe["categoryName"] == "Espresso bar"
        ):
            filtered_cafes.append(cafe)
    return filtered_cafes


keys_needed = [
    "searchString",
    "title",
    "categoryName",
    "categories",
    "address",
    "street",
    "city",
    "postalCode",
    "claimThisBusiness",
    "location",
    "totalScore",
    "reviewsCount",
    "reviewsDistribution",
    "temporarilyClosed",
    "placeId",
    "cid",
    "openingHours",
    "url",
]


# Načtení prvního datasetu (scraped by Search term: "kavárna")
with open(
    "dataset_google-maps-extractor_2024-04-15_Brno_kavarny.json", encoding="utf-8"
) as file:
    cafes = json.load(file)


cafes_cleaned = filter_keys_in_list_of_cafes(cafes, keys_needed)

cafes_filtered = filter_by_category(cafes_cleaned)

# Vytvoření prvního souboru s pročištěnými daty podle hesla "kavárna"
with open(
    "dataset_google-maps-extractor_Brno_kavarny_cleaned.json",
    mode="w",
    encoding="utf-8",
) as output_file:
    json.dump(cafes_filtered, output_file, indent=4, ensure_ascii=False)


# Načtení druhého datasetu (scraped by Category "cafe")
with open(
    "dataset_google-maps-extractor_2024-04-15_Brno_cafe.json", encoding="utf-8"
) as file:
    category_cafe = json.load(file)

category_cafe_cleaned = filter_keys_in_list_of_cafes(category_cafe, keys_needed)

category_cafe_filtered = filter_by_category(category_cafe_cleaned)

# Načtení třetího datasetu (scraped by Category "coffee shop")
with open(
    "dataset_google-maps-extractor_2024-04-18_Brno_Coffee_shop.json", encoding="utf-8"
) as file:
    category_coffee_shop = json.load(file)

category_coffee_shop_cleaned = filter_keys_in_list_of_cafes(
    category_coffee_shop, keys_needed
)

category_coffee_shop_filtered = filter_by_category(category_coffee_shop_cleaned)

# Načtení čtvrtého datasetu (scraped by Category "espresso bar")
with open(
    "dataset_google-maps-extractor_2024-04-18_Brno_Espresso_bar.json", encoding="utf-8"
) as file:
    category_espresso_bar = json.load(file)

category_espresso_bar_cleaned = filter_keys_in_list_of_cafes(
    category_espresso_bar, keys_needed
)

category_espresso_bar_filtered = filter_by_category(category_espresso_bar_cleaned)


# Vytvoření 3 souborů s pročištěnými daty podle 3 vybraných kategorií (cafe, coffee shop, espresso bar)
with open(
    "dataset_google-maps-extractor_Brno_category_cafe_cleaned.json",
    mode="w",
    encoding="utf-8",
) as output_file:
    json.dump(category_cafe_filtered, output_file, indent=4, ensure_ascii=False)

with open(
    "dataset_google-maps-extractor_Brno_category_coffee_shop_cleaned.json",
    mode="w",
    encoding="utf-8",
) as output_file:
    json.dump(category_coffee_shop_filtered, output_file, indent=4, ensure_ascii=False)

with open(
    "dataset_google-maps-extractor_Brno_category_espresso_bar_cleaned.json",
    mode="w",
    encoding="utf-8",
) as output_file:
    json.dump(category_espresso_bar_filtered, output_file, indent=4, ensure_ascii=False)


# Porovnávání názvů kaváren (cafe["title"]) v jednotlivých datasetech:
# vytvoření množiny titulů, které jsou v doplňkových datasetech (stažených podle kategorií) a v prvním datasetu chybí
set_cafe = set(cafe["title"] for cafe in category_cafe_filtered)
set_kavarna = set(cafe["title"] for cafe in cafes_filtered)

cafe_diff_titles = set_cafe.difference(set_kavarna)


set_coffee_shop = set(cafe["title"] for cafe in category_coffee_shop_filtered)
set_kavarna = set(cafe["title"] for cafe in cafes_filtered)

coffee_shop_diff_titles = set_coffee_shop.difference(set_kavarna)


set_espresso_bar = set(cafe["title"] for cafe in category_espresso_bar_filtered)
set_kavarna = set(cafe["title"] for cafe in cafes_filtered)

espresso_bar_diff_titles = set_espresso_bar.difference(set_kavarna)


# Vytvoření seznamu kaváren, které v prvním datasetu chybí, a uložení do souboru JSON:
diff_cafe = []

for cafe in category_cafe_filtered:
    if cafe["title"] in cafe_diff_titles:
        diff_cafe.append(cafe)

with open("diff_cafe.json", mode="w", encoding="utf-8") as output_file:
    json.dump(diff_cafe, output_file, indent=4, ensure_ascii=False)


diff_coffee_shop = []

for cafe in category_coffee_shop_filtered:
    if cafe["title"] in coffee_shop_diff_titles:
        diff_coffee_shop.append(cafe)

with open("diff_coffee_shop.json", mode="w", encoding="utf-8") as output_file:
    json.dump(diff_coffee_shop, output_file, indent=4, ensure_ascii=False)


diff_espresso_bar = []

for cafe in category_espresso_bar_filtered:
    if cafe["title"] in espresso_bar_diff_titles:
        diff_espresso_bar.append(cafe)

with open("diff_espresso_bar.json", mode="w", encoding="utf-8") as output_file:
    json.dump(diff_espresso_bar, output_file, indent=4, ensure_ascii=False)


# Závěrečné propojení datasetů:
with open(
    "dataset_google-maps-extractor_Brno_kavarny_cleaned.json", encoding="utf-8"
) as input_file_1:
    cafes_main = json.load(input_file_1)

with open("diff_cafe.json", encoding="utf-8") as input_file_2:
    cafes_2 = json.load(input_file_2)

with open("diff_coffee_shop.json", encoding="utf-8") as input_file_3:
    cafes_3 = json.load(input_file_3)

with open("diff_espresso_bar.json", encoding="utf-8") as input_file_4:
    cafes_4 = json.load(input_file_4)


final_dataset = cafes_main + cafes_2 + cafes_3 + cafes_4

with open(
    "maps_google_scraped_final_dataset_V2.json", mode="w", encoding="utf-8"
) as output_file:
    json.dump(final_dataset, output_file, indent=4, ensure_ascii=False)
