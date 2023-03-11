WITH quiz_attempts AS (
  SELECT
    ((kv_1.data -> 'data'::text) -> 'user'::text) ->> 'email'::text AS email
    , (kv_1.data ->> 'total_score'::text)::integer AS total_score
    , ((kv_1.data -> 'data'::text) ->> 'maxScore'::text)::integer AS max_score
    , EXTRACT(epoch FROM (((kv_1.data -> 'data'::text) ->> 'finishedDateTime'::text)::timestamp WITHOUT time zone) - (((kv_1.data -> 'data'::text) ->> 'startedDateTime'::text)::timestamp WITHOUT time zone)) AS quiz_duration_sec
    , kv_1.data ->> 'lastUpdated'::text AS last_updated
    , (kv_1.data -> 'data'::text) ->> 'instanceId'::text AS instance_id
    , ((kv_1.data -> 'data'::text) ->> 'startedDateTime'::text)::timestamp WITHOUT time zone AS start_time
    , ((kv_1.data -> 'data'::text) ->> 'finishedDateTime'::text)::timestamp WITHOUT time zone AS end_time
    , kv_1.data ->> 'user_id'::text AS user_id
    , kv_1.type
    , kv_1.id
    , ((kv_1.data -> 'data'::text) -> 'user'::text) ->> 'displayName'::text AS display_name
    , kv_1.data
  FROM
    production.kv kv_1
)
SELECT
  kv.email
  , p.title AS quiz_title
  , kv.total_score
  , kv.max_score
  , kv.total_score >= kv.max_score AS passed
  , kv.quiz_duration_sec
  , kv.last_updated
  , kv.instance_id
  , kv.start_time
  , kv.end_time
  , kv.user_id
  , kv.id
  , p.tag_name
  , kv.display_name
  , kv.data
FROM
  quiz_attempts kv
  LEFT JOIN production.quizzes p ON kv.instance_id = p.instance_id
WHERE
  kv.type = 'QUIZ_ATTEMPT'::text
  AND p.type = 'PLUGIN_TYPE'::text
ORDER BY
  kv.last_updated DESC
