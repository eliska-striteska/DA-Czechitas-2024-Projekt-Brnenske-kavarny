-- Vytvoření dimenze "dimReviews":
    -- převod formátu toitalScore ze string na float
    -- rozbalení JSON struktury (slovník) ve sloupečku reviewDistribution do samostatných sloupců pomocí funkce JSON_VALUE()
    -- ukázka původního formátu: "{'oneStar': 11, 'twoStar': 7, 'threeStar': 29, 'fourStar': 78, 'fiveStar': 405}"
    -- pomocí REPLACE() jsme museli zaměnit původní apostrofy za úvozovky, jinak nedokázal formát přečíst

SELECT 
    placeId,
    TRY_PARSE(totalScore AS float) AS ReviewScore,
    reviewsCount,
    JSON_VALUE(REPLACE(reviewsDistribution, '''', '"'), '$.oneStar') as OneStarCount,
    JSON_VALUE(REPLACE(reviewsDistribution, '''', '"'), '$.twoStar') as TwoStarCount,
    JSON_VALUE(REPLACE(reviewsDistribution, '''', '"'), '$.threeStar') as ThreeStarCount,
    JSON_VALUE(REPLACE(reviewsDistribution, '''', '"'), '$.fourStar') as FourStarCount,
    JSON_VALUE(REPLACE(reviewsDistribution, '''', '"'), '$.fiveStar') as FiveStarCount
INTO 
    dimReviews
FROM 
    maps_google_scraped 


SELECT * FROM dimReviews


-- Vytvoření dimenze "dimOpeningHours"
    -- rozbalení JSON struktury (seznam slovníků) ve sloupečku reviewDistribution do samostatných sloupců pomocí funkce OPENJSON()
    -- ukázka původního formátu:
    /* "[{'day': 'Monday', 'hours': '10\u202fAM to 1\u202fAM'}, 
    {'day': 'Tuesday', 'hours': '10\u202fAM to 1\u202fAM'}, 
    {'day': 'Wednesday', 'hours': '10\u202fAM to 1\u202fAM'}, ...]" */
    -- pomocí REPLACE() jsme opět museli zaměnit původní apostrofy za úvozovky, což je potřeba pro správné rozparsování JSONu 
/* SELECT placeId, item.*: Vybere placeId z původní tabulky maps_google_scraped a všechny sloupce z výsledku, který vznikne po aplikaci OPENJSON a CROSS APPLY.
INTO dimOpeningHours: Výsledek dotazu bude uložen do nově vytvořené tabulky dimOpeningHours. Pokud tabulka již existuje, dotaz selže; pokud neexistuje, bude vytvořena.
CROSS APPLY OPENJSON(replace(openingHours, '''', '"'), '$'): 
CROSS APPLY používá funkci OPENJSON, která rozparsuje JSON data uložená ve sloupci openingHours. Funkce replace(openingHours, '''', '"') nahradí apostrofy uvozovkami, 
WITH (day NVARCHAR(100), hours NVARCHAR(100)) AS item: Specifikuje strukturu JSON objektu, kde každý objekt má klíče day a hours, 
jejichž hodnoty jsou interpretovány jako text (NVARCHAR(100)). Alias item pak reprezentuje tyto hodnoty jako virtuální tabulku, z které jsou sloupce 
day a hours dostupné pro dotaz. */

SELECT 
    placeId, 
    item.*
INTO 
    dimOpeningHours
FROM 
    maps_google_scraped
CROSS APPLY 
    OPENJSON(replace(openingHours, '''', '"'), '$') WITH (
    day NVARCHAR(100),
    hours NVARCHAR(100)
    ) AS item;

SELECT * FROM dimOpeningHours

-- Vytvoření dimenze "dimCategories"

/* SELECT Clause:
placeId: Vybírá sloupec placeId z tabulky maps_google_scraped.
item.value AS Category: Vybírá hodnotu z JSON objektu, který je získán pomocí OPENJSON funkce a pojmenovává ji jako Category.
CROSS APPLY a OPENJSON:
OPENJSON(replace(replace(categories, 'Children''s', 'Childrens'), '''', '"')): Tato funkce slouží k převodu JSON řetězce na tabulkovou strukturu. 
Před tímto převodem se v JSON řetězci nahradí specifické znaky, aby byl formát JSON validní. 
CROSS APPLY: Používá se k aplikaci tabulkové funkce (zde OPENJSON) na každý řádek zdrojové tabulky. 
Výsledkem je "rozšíření" každého řádku o další řádky vytvořené z JSON dat. */

SELECT 
    placeId, item.value AS Category
INTO 
    dimCategories
FROM 
    maps_google_scraped
CROSS APPLY 
    OPENJSON(replace(replace(categories, 'Children''s', 'Childrens'), '''', '"')) item

SELECT * FROM dimCategories


-- vytvoření dimenze "dimCafes"
    -- zde jsme si vytáhli informaci o katastrálním území ze sloupce [neigbourhood]: 
        -- LTRIM(RTRIM) = očištění bílých znaků
        -- CHARINDEX - vezmi informaci po tento znak -1
        -- > vytáhli jsme první slovo, což se ukázalo jako problematické a budeme to muset ještě upravit

SELECT
    placeId,
    title,
    categoryName AS MainCategory,
    LTRIM(RTRIM(SUBSTRING(neigbourhood, 1, CHARINDEX(',', neigbourhood) - 1))) AS KatastralniUzemi,
    claimThisBusiness,
    temporarilyClosed
INTO
    dimCafes
FROM
    maps_google_scraped

