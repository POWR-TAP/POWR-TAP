SELECT
  MD5(CONCAT(__basename , employee_id)) AS id
  , TO_DATE((REGEXP_MATCH(__basename , '\d{8}'))[1] , 'YYYYMMDD') AS date
  , email
  , employee_id
  , payment
  , (REGEXP_MATCH(__basename , 'Batch (\d+)-'))[1]::int AS payout_batch
  -- Depends on 20230201 FIS Award Payment Batch 01-004_Completed_.csv
FROM
  {{ ref ('fis_records') }} fs
WHERE
  __status_code = '1'
  AND order_type = 'LoadCard'
