-- Podniky, které mají ve vedlejších kategoriích zadané jiné kategorie než cafe / coffee shop / espresso bar:

SELECT 
    cat.placeId,
    cat.category,
    caf.title,
    g.neighbourhoodPart
FROM 
    dimCategories cat 
    JOIN dimCafes caf ON cat.placeId = caf.placeId
    JOIN dimGeo g ON cat.placeId = g.placeId
WHERE
    category != N'Coffee shop' AND
    category != N'Cafe' AND
    category != N'Espresso bar'
ORDER BY
    cat.placeId



-- Odstranění zbylých  cukráren:

SELECT *
FROM 
    maps_google_scraped
WHERE
    title LIKE N'%cukrárna%' OR
    title LIKE N'%cukrárnička%' 


-- Kontrola podniků, které měly jako katastralní území shopping mall apod.:

SELECT *
FROM 
    maps_google_scraped
WHERE
    neigbourhood LIKE N'%Albert%' OR
    neigbourhood LIKE N'%Alfa centrum%' OR 
    neigbourhood LIKE N'%Avion shopping park%' OR
    neigbourhood LIKE N'%Bobycentrum%' OR
    neigbourhood LIKE N'%Business Centre Ponávka%' OR
    neigbourhood LIKE N'%Campus Square%' OR
    neigbourhood LIKE N'%Centrum Kaštanová%' OR
    neigbourhood LIKE N'%IBC Příkop%' OR
    neigbourhood LIKE N'%Nákupní centrum Královo Pole%' OR
    neigbourhood LIKE N'%Panorama Kociánka%' OR
    neigbourhood LIKE N'%průmyslová zóna Černovická terasa%' OR
    neigbourhood LIKE N'%Spielberg Business Park%' OR
    neigbourhood LIKE N'%Titanium%' OR
    neigbourhood LIKE N'%Vlněna Office Park%' OR
    neigbourhood LIKE N'%Vysokoškolské koleje Purkyňovy%'


-- Náhodně objevené "non-cafes":

SELECT *
FROM maps_google_scraped
WHERE
    title LIKE '%viet%'


SELECT *
FROM    
    maps_google_scraped
WHERE
    title = 'coffee'