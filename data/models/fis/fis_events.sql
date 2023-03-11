SELECT
  __basename AS filename
  , CASE WHEN __file_type = 'submission' THEN
    'submitted'
  ELSE
    LOWER(__status)
  END AS status
  , __type AS request_type
  , email
  , employee_id
  , payment
  , __file_type AS type
  , __row AS row
  , __status_code AS status_code
  , __status_message AS status_message
FROM
  {{ ref ('fis_records') }}
ORDER BY
  __modified_at DESC
