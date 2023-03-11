SELECT
  *
FROM
  {{ ref ('debit_cards') }} dc
WHERE
  -- Loading should be done on most recent card belonging to a player
  dc.current_card = 1
