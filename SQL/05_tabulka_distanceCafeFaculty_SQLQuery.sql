ALTER TABLE distanceCafeFaculty
ADD temp_lat_x FLOAT,
    temp_lng_x FLOAT,
    temp_lat_y FLOAT,
    temp_lng_y FLOAT,
    temp_distance_m FLOAT;


UPDATE distanceCafeFaculty
SET
    temp_lat_x = TRY_CAST(lat_x AS FLOAT),
    temp_lng_x = TRY_CAST(lng_x AS FLOAT),
    temp_lat_y = TRY_CAST(lat_y AS FLOAT),
    temp_lng_y = TRY_CAST(lng_y AS FLOAT),
    temp_distance_m = TRY_CAST(distance_m AS FLOAT);


ALTER TABLE distanceCafeFaculty
DROP COLUMN 
    lat_x,
    lng_x,
    lat_y,
    lng_y,
    distance_m;

EXEC sp_rename 'distanceCafeFaculty.temp_lat_x', 'lat_x', 'COLUMN';
EXEC sp_rename 'distanceCafeFaculty.temp_lng_x', 'lng_x', 'COLUMN';
EXEC sp_rename 'distanceCafeFaculty.temp_lat_y', 'lat_y', 'COLUMN';
EXEC sp_rename 'distanceCafeFaculty.temp_lng_y', 'lng_y', 'COLUMN';
EXEC sp_rename 'distanceCafeFaculty.temp_distance_m', 'distance_m', 'COLUMN';


SELECT * FROM distanceCafeFaculty

---------------------------------------------------------------------------------------------------

SELECT * FROM faculties

ALTER TABLE faculties
ADD temp_lat FLOAT,
    temp_lng FLOAT;

UPDATE faculties
SET
    temp_lat = TRY_CAST(Y AS FLOAT),
    temp_lng = TRY_CAST(X AS FLOAT);


ALTER TABLE faculties
DROP COLUMN 
    Y,
    X;

EXEC sp_rename 'faculties.temp_lat', 'lat', 'COLUMN';
EXEC sp_rename 'faculties.temp_lng', 'lng', 'COLUMN';
