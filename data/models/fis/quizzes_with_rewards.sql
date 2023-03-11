WITH survey_payouts AS (
  SELECT
    pmtr.buid
    , pmtr.email
    , pmtr.first_name
    , pmtr.last_name
    , sr.tag_name
    , sr.tag_first_assigned::timestamp WITHOUT time zone AS tag_first_assigned
    , sr.payout_value
    , sr.quiz_rank
  FROM
    production.survey_respondants sr
    LEFT JOIN {{ ref ('participants_map_to_roster') }} pmtr ON sr.email = pmtr.email
)
, all_payouts AS (
  SELECT
    buid
    , email
    , first_name
    , last_name
    , tag_name
    , tag_first_assigned
    , payout_value
    , quiz_rank
  FROM
    {{ ref ('payouts_bonus') }}
UNION
SELECT
  buid
  , email
  , first_name
  , last_name
  , tag_name
  , tag_first_assigned
  , payout_value
  , quiz_rank
FROM
  {{ ref ('payouts_flash') }}
UNION
SELECT
  buid
  , email
  , first_name
  , last_name
  , tag_name
  , tag_first_assigned
  , payout_value
  , quiz_rank
FROM
  {{ ref ('payouts_regular') }}
UNION
SELECT
  survey_payouts.buid
  , survey_payouts.email
  , survey_payouts.first_name
  , survey_payouts.last_name
  , survey_payouts.tag_name
  , survey_payouts.tag_first_assigned
  , survey_payouts.payout_value
  , survey_payouts.quiz_rank
FROM
  survey_payouts
)
SELECT
  p.buid
  , p.email
  , p.first_name
  , p.last_name
  , ap.tag_name
  , ap.tag_first_assigned
  , ap.payout_value
  , ap.quiz_rank
  , qpb.payout_batch
FROM
  all_payouts ap
  LEFT JOIN {{ ref ('participants_map_to_roster') }} p ON ap.email = p.email
  LEFT JOIN {{ ref ('quiz_roster') }} qpb ON qpb.tag = ap.tag_name
