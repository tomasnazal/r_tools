-- 870129: Dana
-- 870128: Dutee
-- 866183: X&Y
-- 870978: Sex Ed
-- 871961: The Bad Show


WITH dutee_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 870128
)

, dana_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 870129
)

, xy_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 866183
)

, sexed_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 870978
)

, badshow_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 871961
)

SELECT
  'Dutee' AS show,
  COUNT(du.user) AS total,
  --overlap
  COUNT(du.user) AS overlap
FROM dutee_uniques AS du

UNION ALL 

SELECT
  'Dana' AS show,
  COUNT(da.user) AS total,
  --Dutee overlap
  SUM(CASE
    WHEN da.user IN (
      SELECT 
        DISTINCT ip_useragent_hash
      FROM ${on_demand_listens_unique.SQL_TABLE_NAME}
      WHERE story_id = 870128
    )
    THEN 1
    ELSE 0
  END) AS overlap
FROM dana_uniques AS da

UNION ALL 

SELECT
  'SexED' AS show,
  COUNT(se.user) AS total,
  --Dutee overlap
  SUM(CASE
    WHEN se.user IN (
      SELECT 
        DISTINCT ip_useragent_hash
      FROM ${on_demand_listens_unique.SQL_TABLE_NAME}
      WHERE story_id = 870128
    )
    THEN 1
    ELSE 0
  END) AS overlap
FROM sexed_uniques AS se

UNION ALL 

SELECT
  'XY' AS show,
  COUNT(xy.user) AS total,
  --Dutee overlap
  SUM(CASE
    WHEN xy.user IN (
      SELECT 
        DISTINCT ip_useragent_hash
      FROM ${on_demand_listens_unique.SQL_TABLE_NAME}
      WHERE story_id = 870128
    )
    THEN 1
    ELSE 0
  END) AS overlap
FROM xy_uniques AS xy

UNION ALL 

SELECT
  'The Bad Show' AS show,
  COUNT(bad.user) AS total,
  --Dutee overlap
  SUM(CASE
    WHEN bad.user IN (
      SELECT 
        DISTINCT ip_useragent_hash
      FROM ${on_demand_listens_unique.SQL_TABLE_NAME}
      WHERE story_id = 870128
    )
    THEN 1
    ELSE 0
  END) AS overlap
FROM badshow_uniques AS bad