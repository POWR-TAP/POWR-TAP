WITH ranked_quizes AS (
  SELECT
    quiz_attempts_all.email
    , quiz_attempts_all.quiz_title
    , quiz_attempts_all.total_score
    , quiz_attempts_all.max_score
    , quiz_attempts_all.passed
    , quiz_attempts_all.quiz_duration_sec
    , quiz_attempts_all.last_updated
    , quiz_attempts_all.instance_id
    , quiz_attempts_all.start_time
    , quiz_attempts_all.end_time
    , quiz_attempts_all.user_id
    , quiz_attempts_all.id
    , quiz_attempts_all.tag_name
    , quiz_attempts_all.display_name
    , quiz_attempts_all.data
    , ROW_NUMBER() OVER (PARTITION BY quiz_attempts_all.user_id
      , quiz_attempts_all.quiz_title ORDER BY quiz_attempts_all.total_score DESC) AS best_attempt
  FROM
    production.quiz_attempts_all
)
SELECT
  ranked_quizes.email
  , ranked_quizes.quiz_title
  , ranked_quizes.total_score
  , ranked_quizes.max_score
  , ranked_quizes.passed
  , ranked_quizes.quiz_duration_sec
  , ranked_quizes.last_updated
  , ranked_quizes.instance_id
  , ranked_quizes.start_time
  , ranked_quizes.end_time
  , ranked_quizes.user_id
  , ranked_quizes.id
  , ranked_quizes.tag_name
  , ranked_quizes.display_name
  , ranked_quizes.data
  , ranked_quizes.best_attempt
FROM
  ranked_quizes
WHERE
  ranked_quizes.best_attempt = 1
