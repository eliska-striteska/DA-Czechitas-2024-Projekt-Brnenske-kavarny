SELECT g.placeId, cf.title, maps.address, g.neighbourhoodAll, g.postalCode 
FROM dimGeo g
    JOIN dimCafes cf ON g.placeId = cf.placeId
    JOIN maps_google_scraped maps ON g.placeId = maps.placeId
WHERE g.postalCode IS NULL;

------------------------------------------------------------------------------

/******** Kavárna U Šimpanze *************/

UPDATE dimGeo
SET postalCode = '635 00'
WHERE placeId = 'ChIJe8xi1c-WEkcRZHdDHuo3j90';

SELECT * 
FROM dimGeo
WHERE placeId = 'ChIJe8xi1c-WEkcRZHdDHuo3j90';

SELECT * 
FROM dimGeo
WHERE neighbourhoodPart = 'Bystrc';

SELECT placeId, neigbourhood 
FROM maps_google_scraped
WHERE neigbourhood LIKE N'Bystrc%';


/******** Křupkafé **************/

SELECT *
FROM maps_google_scraped
WHERE placeId = N'ChIJhYGFpheXEkcRajb-rh-zrNw';

UPDATE dimGeo
SET postalCode = '635 00'
WHERE placeId = N'ChIJhYGFpheXEkcRajb-rh-zrNw';


/******* Design lab MENDELU ******/

UPDATE dimGeo
SET postalCode = '613 00'
WHERE placeId = N'ChIJo7fsidqVEkcRCB3V_qX8ues';

SELECT * 
FROM dimGeo
WHERE placeId = N'ChIJo7fsidqVEkcRCB3V_qX8ues';


/******* KOFI-KOFI *************/
UPDATE dimGeo
SET postalCode = '621 00'
WHERE placeId = N'ChIJS-fkOJaXEkcRMbJEqh64uro';

SELECT * 
FROM dimGeo
WHERE placeId = N'ChIJS-fkOJaXEkcRMbJEqh64uro';


/******** Costa coffee ***********/
UPDATE dimGeo
SET postalCode = '602 00'
WHERE placeId = N'ChIJk2NsJS6VEkcR8bOWn6X4H8Q';

SELECT * 
FROM dimGeo
WHERE placeId = N'ChIJk2NsJS6VEkcR8bOWn6X4H8Q';
