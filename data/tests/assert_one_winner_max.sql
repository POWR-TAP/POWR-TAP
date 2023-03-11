SELECT
  quiz_rank
FROM
  {{ ref ('quizzes_with_rewards') }}
WHERE
  payout_batch = 3
  AND tag_name = 'passed-bonus-quiz-6'
  AND quiz_rank > 1
