WITH bpayouts AS (
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
    -- Partition so each quiz gets independent quiz ranking
    -- Fixes issue on 2023-02-28 where quiz rank was being calculated globally for
    -- all tagged quizes that were bonus
    , ROW_NUMBER() OVER (PARTITION BY tag_name ORDER BY tag_name
      , tag_first_assigned) AS quiz_rank
  FROM
    {{ ref ('user_tags') }}
  WHERE
    tag_name ~~* 'passed-bonus-%'::text
)
SELECT
  bp.buid
  , bp.email
  , bp.first_name
  , bp.last_name
  , bp.tag_name
  , bp.tag_first_assigned
  , qr.reward::DECIMAL(10 , 2) AS payout_value
  , bp.quiz_rank
FROM
  bpayouts bp
  JOIN {{ ref ('quiz_roster') }} qr ON qr.tag = bp.tag_name
WHERE
  quiz_rank <= qr.winner_count
ORDER BY
  bp.tag_name
  , bp.tag_first_assigned
