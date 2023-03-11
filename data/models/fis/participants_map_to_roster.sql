SELECT
  kv.data ->> '_id'::text AS buid
  , kv.data ->> 'email'::text AS email
  , tp.first_name
  , tp.last_name
FROM
  production.kv
  LEFT JOIN production.tap_participants tp ON tp.email ILIKE (kv.data ->> 'email'::text)
WHERE
  kv.type = 'USER_TYPE'::text
