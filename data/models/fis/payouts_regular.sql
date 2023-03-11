WITH rpayouts AS (
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
    tag_name ~~* 'passed-week-%'::text
)
SELECT
  rp.buid
  , rp.email
  , rp.first_name
  , rp.last_name
  , rp.tag_name
  , rp.tag_first_assigned
  , qr.reward::DECIMAL(10 , 2) AS payout_value
  , rp.quiz_rank
FROM
  rpayouts rp
  JOIN {{ ref ('quiz_roster') }} qr ON qr.tag = rp.tag_name
ORDER BY
  rp.tag_name
