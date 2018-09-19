SELECT
  show.show_name AS show
  , EXTRACT(MONTH FROM odl.listen_timestamp) AS month
  , ip_useragent_hash AS listeners
FROM ${on_demand_listens_unique.SQL_TABLE_NAME} AS odl INNER JOIN
  show ON odl.show_id = show.show_id
WHERE EXTRACT(YEAR from odl.listen_timestamp) = 2018 AND
  EXTRACT(MONTH from odl.listen_timestamp) IN (4,5) AND
  show.show_name IN ('Radiolab'
    ,'Freakonomics Radio'
    ,'More Perfect'
    ,'On The Media'
    ,'Snap Judgment'
    ,'The New Yorker Radio Hour'
    ,'Death, Sex & Money'
    ,'2 Dope Queens'
    ,'Here''s The Thing'
    ,'Note to Self'
    ,'Stay Tuned with Preet'
    ,'The New Yorker: Politics and More'
    ,'Nancy'
    ,'Sooo Many White Guys'
    ,'Science Friday'
    ,'Snap Judgment Presents: Spooked'
    ,'The New Yorker: Fiction'
    ,'Late Night Whenever'
    ,'The Brian Lehrer Show'
    ,'Trump, Inc.')
GROUP BY 1, 2, 3