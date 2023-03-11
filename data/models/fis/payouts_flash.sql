WITH fpayouts AS (
  SELECT
    buid
    , kvid
    , email
    , display_name
    , first_name
    , last_name
    , tag_name
    , tag_applied_count
    , tag_last_assigned
    , tag_first_assigned
    , id
    , inserted_at
    , type
    , data
    , "tagName"
    , "appliedCount"
    , "lastAssgined"
    , "firstAssgined"
    , ROW_NUMBER() OVER (PARTITION BY tag_name ORDER BY tag_name
      , tag_first_assigned) AS quiz_rank
  FROM
    {{ ref ('user_tags') }}
  WHERE
    tag_name ~~* 'passed-flash-%'::text
)
SELECT
  buid
  , email
  , first_name
  , last_name
  , tag_name
  , tag_first_assigned
  , qr.reward::DECIMAL(10 , 2) AS payout_value
  , quiz_rank
FROM
  fpayouts fp
  JOIN {{ ref ('quiz_roster') }} qr ON qr.tag = fp.tag_name
WHERE
  quiz_rank <= winner_count
ORDER BY
  tag_name
