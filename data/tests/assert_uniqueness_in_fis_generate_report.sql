SELECT
  email
  , COUNT(email) AS email_count
FROM
  production.generate_fis_load_card_report (3)
GROUP BY
  1
HAVING (COUNT(email) > 1)
