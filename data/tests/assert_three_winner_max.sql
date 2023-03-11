SELECT
  quiz_rank
FROM
  {{ ref ('quizzes_with_rewards') }}
WHERE
  payout_batch = 4
  AND tag_name = 'passed-bonus-quiz-7'
  AND quiz_rank > 3
