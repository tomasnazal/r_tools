WITH lists_in_crm AS (
SELECT
 DISTINCT mcl.list_name as list
FROM
  mailchimp_member AS mcm INNER JOIN
  mailchimp_list AS mcl ON mcm.list_id = mcl.list_id 
WHERE email_id IN (SELECT email_id FROM crm_emails))

SELECT
  list_name
  ,   COUNT(DISTINCT email_id) 
FROM mailchimp_list mcl INNER JOIN
  mailchimp_member mcm ON mcl.list_id = mcm.list_id 
WHERE list_name NOT IN (SELECT list FROM lists_in_crm)
GROUP BY list_name