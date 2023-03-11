WITH users AS (
  SELECT
    kv.id
    , kv.inserted_at
    , kv.type
    , kv.data
  FROM
    production.kv
  WHERE
    kv.type = 'USER_TYPE'::text
)
SELECT
  users.data ->> '_id'::text AS buid
  , users.id AS kvid
  , users.data ->> 'email'::text AS email
  , users.data ->> 'displayName'::text AS display_name
  , users.data ->> 'firstName'::text AS first_name
  , users.data ->> 'lastName'::text AS last_name
  , x."tagName" AS tag_name
  , x."appliedCount" AS tag_applied_count
  , x."lastAssgined" AS tag_last_assigned
  , x."firstAssgined" AS tag_first_assigned
  , users.id
  , users.inserted_at
  , users.type
  , users.data
  , x."tagName"
  , x."appliedCount"
  , x."lastAssgined"
  , x."firstAssgined"
FROM
  users
  , LATERAL JSONB_POPULATE_RECORDSET(NULL::production.tagtype , (users.data -> 'tags'::text) -> 'ba006b7f-c6e5-11eb-9fe6-12a56cc33887'::text) x ("tagName"
    , "appliedCount"
    , "lastAssgined"
    , "firstAssgined")
