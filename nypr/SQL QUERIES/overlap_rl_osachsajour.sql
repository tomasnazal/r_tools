-- 807863: Oliver Sacks: A Journey From Where to Where
-- 811385: Match Made in Marrow
-- 814334: Stereothreat
-- 804065: Father K
-- 801346: Radiolab Presents: More Perfect - American Pendulum I


WITH os_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 807863
)

, matchmade_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 811385
)

, stereo_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 814334
)

, fk_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 804065
)

, rl_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 801346
)

SELECT
  'Oliver Sacks: A Journey From Where to Where' AS show,
  COUNT(os.user) AS total,
  --overlap
  COUNT(os.user) AS overlap
FROM os_uniques AS os

UNION ALL 

SELECT
  'Match Made in Marrow' AS show,
  COUNT(ma.user) AS total,
  --Dutee overlap
  SUM(CASE
    WHEN ma.user IN (
      SELECT 
        DISTINCT ip_useragent_hash
      FROM ${on_demand_listens_unique.SQL_TABLE_NAME}
      WHERE story_id = 807863
    )
    THEN 1
    ELSE 0
  END) AS overlap
FROM matchmade_uniques AS ma

UNION ALL 

SELECT
  'Stereothreat' AS show,
  COUNT(st.user) AS total,
  --Dutee overlap
  SUM(CASE
    WHEN st.user IN (
      SELECT 
        DISTINCT ip_useragent_hash
      FROM ${on_demand_listens_unique.SQL_TABLE_NAME}
      WHERE story_id = 807863
    )
    THEN 1
    ELSE 0
  END) AS overlap
FROM stereo_uniques AS st

UNION ALL 

SELECT
  'Father K' AS show,
  COUNT(fk.user) AS total,
  --Dutee overlap
  SUM(CASE
    WHEN fk.user IN (
      SELECT 
        DISTINCT ip_useragent_hash
      FROM ${on_demand_listens_unique.SQL_TABLE_NAME}
      WHERE story_id = 807863
    )
    THEN 1
    ELSE 0
  END) AS overlap
FROM fk_uniques AS fk

UNION ALL 

SELECT
  'Radiolab Presents: More Perfect - American Pendulum I' AS show,
  COUNT(rl.user) AS total,
  --Dutee overlap
  SUM(CASE
    WHEN rl.user IN (
      SELECT 
        DISTINCT ip_useragent_hash
      FROM ${on_demand_listens_unique.SQL_TABLE_NAME}
      WHERE story_id = 807863
    )
    THEN 1
    ELSE 0
  END) AS overlap
FROM rl_uniques AS rl