WITH prequery AS (
  SELECT
    p.first_name
    , p.last_name
    , qr.email
    , SUM(qr.payout_value) OVER (PARTITION BY qr.email
      , p.first_name
      , p.last_name
      , qr.payout_batch ORDER BY qr.email) AS payout
    , SUM(qr.payout_value) OVER () AS grand_total
    , qr.payout_batch
  FROM
    {{ ref ('quizzes_with_rewards') }} qr
    LEFT JOIN {{ ref ('participants_map_to_roster') }} p ON qr.email = p.email
  WHERE
    p.first_name IS NOT NULL
)
SELECT
  prequery.first_name
  , prequery.last_name
  , prequery.email
  , prequery.payout
  , prequery.grand_total
  , prequery.payout_batch
FROM
  prequery
GROUP BY
  prequery.first_name
  , prequery.last_name
  , prequery.email
  , prequery.payout
  , prequery.grand_total
  , prequery.payout_batch
