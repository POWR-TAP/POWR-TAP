SELECT
  MD5(CONCAT(__basename , fs.employee_id)) AS id
  , __modified_at AS created_at
  , tp.employee_id
  , tp.email
  , __proxy_number AS proxy_number
  , __basename
  , ROW_NUMBER() OVER (PARTITION BY fs.employee_id ORDER BY (fs.__meta ->> 'modified_at')::timestamptz DESC nulls LAST) AS current_card
, ROW_NUMBER() OVER (PARTITION BY fs.employee_id ORDER BY (fs.__meta ->> 'modified_at')::timestamptz ASC nulls LAST) AS card_by_ordered_date
FROM
  {{ ref ('fis_records') }} fs
  LEFT JOIN tap_participants tp ON fs.employee_id::int = tp.employee_id
WHERE
  __status_code = '1'
  AND order_type IN ('Personalized')
