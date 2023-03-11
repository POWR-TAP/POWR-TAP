-- DEPRECATED
SELECT
  kv.id
  , (kv.data -> 'data'::text) ->> 'title'::text AS title
  , kv.data ->> 'lastUpdated'::text AS last_updated
  , (kv.data -> 'data'::text) ->> 'instanceId'::text AS instance_id
  , kv.type
  , kv.data
  , (((kv.data -> 'data'::text) -> 'behavioralTags'::text) -> 0) ->> 'name'::text AS tag_name
  , (((kv.data -> 'data'::text) -> 'behavioralTags'::text) -> 0) ->> 'appliedCount'::text AS tag_applied_count
  , (((kv.data -> 'data'::text) -> '_buildfire'::text) -> 'index'::text) ->> 'text'::text AS email_and_name
FROM
  production.kv
WHERE
  kv.type = 'PLUGIN_TYPE'::text
ORDER BY
  (kv.data ->> 'lastUpdated'::text) DESC
