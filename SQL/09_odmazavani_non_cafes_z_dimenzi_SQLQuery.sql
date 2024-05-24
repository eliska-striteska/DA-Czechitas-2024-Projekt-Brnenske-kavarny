/*********** ODMAZÁVÁNÍ NECHTĚNÝCH PODNIKŮ OBJEVENÝCH BĚHEM PRÁCE S DATY *************/

SELECT *
FROM dimCafes
WHERE placeId = 'ChIJyZSAVByUEkcR-sUl_5lIeD8';

DELETE FROM dimGeo
WHERE placeId = 'ChIJyZSAVByUEkcR-sUl_5lIeD8';

DELETE FROM dimCafes
WHERE placeId = 'ChIJyZSAVByUEkcR-sUl_5lIeD8';

DELETE FROM dimCategories
WHERE placeId = 'ChIJyZSAVByUEkcR-sUl_5lIeD8';

DELETE FROM dimReviews
WHERE placeId = 'ChIJyZSAVByUEkcR-sUl_5lIeD8';

DELETE FROM dimOpeningHours
WHERE placeId = 'ChIJyZSAVByUEkcR-sUl_5lIeD8';

---------------------------------------------------
SELECT *
FROM dimCafes
WHERE placeId = 'ChIJm9mzpsaWEkcRtnxQPaR9ZpI';

DELETE FROM dimGeo
WHERE placeId = 'ChIJm9mzpsaWEkcRtnxQPaR9ZpI';

DELETE FROM dimCafes
WHERE placeId = 'ChIJm9mzpsaWEkcRtnxQPaR9ZpI';

DELETE FROM dimCategories
WHERE placeId = 'ChIJm9mzpsaWEkcRtnxQPaR9ZpI';

DELETE FROM dimReviews
WHERE placeId = 'ChIJm9mzpsaWEkcRtnxQPaR9ZpI';

DELETE FROM dimOpeningHours
WHERE placeId = 'ChIJm9mzpsaWEkcRtnxQPaR9ZpI';


---------------------------------------------------------------

SELECT *
FROM dimCafes
WHERE 
    placeId = N'ChIJO0_vlueVEkcRdybhvPNmL84' OR 
    placeId = N'ChIJ9V627JaVEkcRTFEWuYobiuA' OR 
    placeId = N'ChIJU4llyFCUEkcR91JlAC1Mlaw' OR 
    placeId = N'ChIJVdeHibrqEkcRaBlXmq7OA6c' OR
    placeId = N'ChIJf0Tqf0iUEkcRe7gZzGCrlx4';

DELETE FROM dimGeo
WHERE 
    placeId = N'ChIJO0_vlueVEkcRdybhvPNmL84' OR
    placeId = N'ChIJ9V627JaVEkcRTFEWuYobiuA' OR 
    placeId = N'ChIJU4llyFCUEkcR91JlAC1Mlaw' OR 
    placeId = N'ChIJVdeHibrqEkcRaBlXmq7OA6c' OR
    placeId = N'ChIJf0Tqf0iUEkcRe7gZzGCrlx4';

DELETE FROM dimCafes
WHERE
    placeId = N'ChIJO0_vlueVEkcRdybhvPNmL84' OR
    placeId = N'ChIJ9V627JaVEkcRTFEWuYobiuA' OR 
    placeId = N'ChIJU4llyFCUEkcR91JlAC1Mlaw' OR 
    placeId = N'ChIJVdeHibrqEkcRaBlXmq7OA6c' OR
    placeId = N'ChIJf0Tqf0iUEkcRe7gZzGCrlx4';

DELETE FROM dimCategories
WHERE
    placeId = N'ChIJO0_vlueVEkcRdybhvPNmL84' OR
    placeId = N'ChIJ9V627JaVEkcRTFEWuYobiuA' OR 
    placeId = N'ChIJ9V627JaVEkcRTFEWuYobiuA' OR 
    placeId = N'ChIJU4llyFCUEkcR91JlAC1Mlaw' OR 
    placeId = N'ChIJVdeHibrqEkcRaBlXmq7OA6c' OR
    placeId = N'ChIJf0Tqf0iUEkcRe7gZzGCrlx4';

DELETE FROM dimReviews
WHERE 
    placeId = N'ChIJO0_vlueVEkcRdybhvPNmL84' OR
    placeId = N'ChIJ9V627JaVEkcRTFEWuYobiuA' OR 
    placeId = N'ChIJU4llyFCUEkcR91JlAC1Mlaw' OR 
    placeId = N'ChIJVdeHibrqEkcRaBlXmq7OA6c' OR
    placeId = N'ChIJf0Tqf0iUEkcRe7gZzGCrlx4';

DELETE FROM dimOpeningHours
WHERE 
    placeId = N'ChIJO0_vlueVEkcRdybhvPNmL84' OR
    placeId = N'ChIJ9V627JaVEkcRTFEWuYobiuA' OR 
    placeId = N'ChIJU4llyFCUEkcR91JlAC1Mlaw' OR 
    placeId = N'ChIJVdeHibrqEkcRaBlXmq7OA6c' OR
    placeId = N'ChIJf0Tqf0iUEkcRe7gZzGCrlx4';