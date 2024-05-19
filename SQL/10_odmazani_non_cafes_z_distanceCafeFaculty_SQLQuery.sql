WITH DeletedCafes AS
(
SELECT
    DISTINCT cafePlaceId
FROM
    distanceCafeFaculty d
    LEFT JOIN dimCafes c ON c.placeId = d.cafePlaceId
WHERE
    c.placeId IS NULL
    )
DELETE FROM 
    distanceCafeFaculty
WHERE 
    cafePlaceId IN (
        SELECT cafePlaceId 
        FROM DeletedCafes
        );


-- Kontrola "sirotků":

SELECT
    DISTINCT *
FROM
    distanceCafeFaculty d
    LEFT JOIN dimCafes c ON c.placeId = d.cafePlaceId
WHERE
    c.placeId IS NULL;

