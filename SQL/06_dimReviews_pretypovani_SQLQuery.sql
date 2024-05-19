SELECT * FROM dimReviews

ALTER TABLE dimReviews
ADD temp_oneStar INT,
    temp_twoStar INT,
    temp_threeStar INT,
    temp_fourStar INT,
    temp_fiveStar INT;

UPDATE dimReviews
SET
    temp_oneStar = TRY_CAST(oneStarCount AS INT),
    temp_twoStar = TRY_CAST(twoStarCount AS INT),
    temp_threeStar = TRY_CAST(threeStarCount AS INT),
    temp_fourStar = TRY_CAST(fourStarCount AS INT),
    temp_fiveStar = TRY_CAST(fiveStarCount AS INT);


ALTER TABLE dimReviews
DROP COLUMN 
    oneStarCount,
    twoStarCount,
    threeStarCount,
    fourStarCount,
    fiveStarCount;

EXEC sp_rename 'dimReviews.temp_oneStar', 'oneStarCount', 'COLUMN';
EXEC sp_rename 'dimReviews.temp_twoStar', 'twoStarCount', 'COLUMN';
EXEC sp_rename 'dimReviews.temp_threeStar', 'threeStarCount', 'COLUMN';
EXEC sp_rename 'dimReviews.temp_fourStar', 'fourStarCount', 'COLUMN';
EXEC sp_rename 'dimReviews.temp_fiveStar', 'fiveStarCount', 'COLUMN';