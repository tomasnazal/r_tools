WITH mc_totals AS (
SELECT
    mcl.list_name as list
    ,COUNT(DISTINCT mcm.email_id) AS count
   FROM
    mailchimp_member AS mcm INNER JOIN
    mailchimp_list AS mcl ON mcm.list_id = mcl.list_id
   WHERE list IN (
      SELECT
        mcl.list_name as list
      FROM
        mailchimp_member AS mcm INNER JOIN
        mailchimp_list AS mcl ON mcm.list_id = mcl.list_id 
      WHERE email_id IN (SELECT email_id FROM crm_emails)
GROUP BY list)
GROUP BY list)

, in_crm AS(
  SELECT
   mcl.list_name as list
   ,COUNT(DISTINCT mcm.email_id) AS in_crm
  FROM
    mailchimp_member AS mcm INNER JOIN
    mailchimp_list AS mcl ON mcm.list_id = mcl.list_id 
  WHERE email_id IN (SELECT email_id FROM crm_emails)
  GROUP BY list
)

SELECT
  in_crm.list as list
  , mc_totals.count AS distincts_mailchimp
  , in_crm.in_crm AS in_crm
  , ROUND((CAST(in_crm.in_crm AS FLOAT)/CAST(mc_totals.count AS FLOAT))*100, 2) AS prop 
FROM in_crm LEFT JOIN 
  mc_totals ON in_crm.list = mc_totals.list