SELECT
  __meta ->> 'modified_at' AS modified_at
  , CASE WHEN __status_message = 'PAN/Proxy/DA/CUID Multiple or Not Found' THEN
    'Check for missing leading zeros in proxy_number bc leading zero incorrectly stripped'
  WHEN __status_message = 'Invalid PAN' THEN
    'Cannot yet use employee_id as identifier, try using proxy_number'
  ELSE
    CONCAT('Unknown error to ponder: ' , __status_message)
  END AS recommendation
  , *
FROM
  {{ ref ('fis_records') }}
WHERE
  __status_code::numeric != 1
ORDER BY
  __meta ->> 'modified_at' DESC
