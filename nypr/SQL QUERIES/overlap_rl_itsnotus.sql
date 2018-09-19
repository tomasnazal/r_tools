-- 693214: It's Not Us, It's You
-- 726626: Lose Lose
-- 731237: Radiolab Presents: On the Media: Busted, America's Poverty Myths
-- 690533: Bringing Gamma Back
-- 685691: Radiolab Presents: More Perfect - Object Anyway


WITH notus_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 693214
)

, ll_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 726626
)

, rlotm_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 731237
)

, bgb_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 690533
)

, rlmp_uniques AS (
  SELECT
    DISTINCT odl.ip_useragent_hash AS user
  FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl
  WHERE odl.story_id = 685691
)

SELECT
  'Its Not Us, Its You' AS show,
  COUNT(notus.user) AS total,
  --overlap
  COUNT(notus.user) AS overlap
FROM notus_uniques AS notus

UNION ALL 

SELECT
  'Lose Lose' AS show,
  COUNT(ll.user) AS total,
  --Dutee overlap
  SUM(CASE
    WHEN ll.user IN (
      SELECT 
        DISTINCT ip_useragent_hash
      FROM ${on_demand_listens_unique.SQL_TABLE_NAME}
      WHERE story_id = 693214
    )
    THEN 1
    ELSE 0
  END) AS overlap
FROM ll_uniques AS ll

UNION ALL 

SELECT
  'Radiolab Presents: On the Media: Busted, Americas Poverty Myths' AS show,
  COUNT(st.user) AS total,
  --Dutee overlap
  SUM(CASE
    WHEN st.user IN (
      SELECT 
        DISTINCT ip_useragent_hash
      FROM ${on_demand_listens_unique.SQL_TABLE_NAME}
      WHERE story_id = 693214
    )
    THEN 1
    ELSE 0
  END) AS overlap
FROM rlotm_uniques AS st

UNION ALL 

SELECT
  'Bringing Gamma Back' AS show,
  COUNT(fk.user) AS total,
  --Dutee overlap
  SUM(CASE
    WHEN fk.user IN (
      SELECT 
        DISTINCT ip_useragent_hash
      FROM ${on_demand_listens_unique.SQL_TABLE_NAME}
      WHERE story_id = 693214
    )
    THEN 1
    ELSE 0
  END) AS overlap
FROM bgb_uniques AS fk

UNION ALL 

SELECT
  'Radiolab Presents: More Perfect - Object Anyway' AS show,
  COUNT(rl.user) AS total,
  --Dutee overlap
  SUM(CASE
    WHEN rl.user IN (
      SELECT 
        DISTINCT ip_useragent_hash
      FROM ${on_demand_listens_unique.SQL_TABLE_NAME}
      WHERE story_id = 693214
    )
    THEN 1
    ELSE 0
  END) AS overlap
FROM rlmp_uniques AS rl