SELECT DISTINCT
  email
  , user_id AS id
  , user_id AS external_user_id
FROM
  {{ ref ('quiz_attempts') }}
WHERE
  email IS NOT NULL
