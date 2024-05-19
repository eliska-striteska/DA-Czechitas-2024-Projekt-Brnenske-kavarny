-- Procházení dat

SELECT 
    *
FROM    
    dimCafes dc
    JOIN dimCategories dr ON dc.placeId = dr.placeId
WHERE
    KatastralniUzemi = 'Bosonohy'

SELECT 
    *
FROM
    maps_google_scraped
WHERE
    neigbourhood LIKE 'Albert%';



SELECT DISTINCT Category
FROM dimCategories;

SELECT categories 
FROM maps_google_scraped;


SELECT openingHours, reviewsDistribution
FROM maps_google_scraped;




SELECT 
    mgs.placeId,
    title,
    coords,
    latitude, 
    longitude,
    neighbourhoodPart
FROM
    maps_google_scraped mgs 
    JOIN dimGeo dg ON mgs.placeId = dg.placeId;


SELECT DISTINCT neighbourhoodPart FROM dimGeo;


SELECT
    COUNT(DISTINCT placeId) AS CafesCount
FROM
    dimCafes;


SELECT * 
FROM 
    dimCafes
WHERE
    placeId = N'ChIJS8b3H9uWEkcRHzc47iZJf90';



SELECT
    mgs.placeId,
    mgs.title,
    address
FROM maps_google_scraped mgs   
    JOIN (
        SELECT title
        FROM maps_google_scraped
        GROUP BY title 
        HAVING COUNT(placeId) > 1) AS dbl
    ON mgs.title = dbl.title
ORDER BY mgs.title;