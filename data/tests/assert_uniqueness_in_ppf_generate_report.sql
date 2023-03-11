-- We should never have duplicate rows in this report
SELECT
  first_name
  , last_name
  , COUNT(CONCAT(first_name , last_name)) AS count
  --  email
  --, count(email) AS email_count
FROM
  production.generate_ppf_payment_report (3)
GROUP BY
  1
  , 2
HAVING (COUNT(CONCAT(first_name , last_name)) > 1)
