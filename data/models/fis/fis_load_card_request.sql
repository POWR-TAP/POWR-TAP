WITH rewards AS (
  SELECT
    pr.first_name
    , pr.last_name
    , pr.email
    , pr.payout
    , pr.grand_total
    , tp.employee_id
    , proxy_number
  FROM
    {{ ref ('ppf_payment_report') }} pr
    LEFT JOIN {{ ref ('tap_participants') }} tp ON pr.email = tp.email
    LEFT JOIN {{ ref ('current_debit_cards') }} dc ON tp.employee_id = dc.employee_id::int
)
SELECT
  104438 AS subprogram_id
  , 160951 AS package_id
  , 'LoadCard'::text AS order_type
  , NULL::text AS shipping_type
  , NULL::text AS shipping_method
  , NULL::text AS name_first
  , NULL::text AS name_middle
  , NULL::text AS name_last
  , NULL::text AS suffix
  , NULL::text AS ssn_number
  , NULL::text AS dob
  , r.email
  , NULL::text AS phone
  , NULL::text AS addressee
  , NULL::text AS attention
  , NULL::text AS third_line
  , NULL::text AS fourth_line
  , NULL::text AS name_on_card
  , LPAD(proxy_number::text , 13 , '0'::text) AS proxy_number
  , NULL::text AS card_number
  , NULL::text AS dda_number
  , r.employee_id
  , NULL::text AS residential_address1
  , NULL::text AS residential_address2
  , NULL::text AS residential_city
  , NULL::text AS residential_state
  , NULL::text AS residential_zip
  , NULL::text AS quantity
  , r.payout::numeric(4 , 2) AS payment
  , NULL::text AS comment
  , NULL::text AS data1
  , NULL::text AS data2
  , NULL::text AS data3
  , NULL::text AS shipping_addressee
  , NULL::text AS shipping_attention
  , NULL::text AS shipping_address1
  , NULL::text AS shipping_address2
  , NULL::text AS shipping_city
  , NULL::text AS shipping_state
  , NULL::text AS shipping_zip
  , NULL::text AS custom_field1
  , NULL::text AS custom_field2
  , NULL::text AS custom_field3
  , NULL::text AS custom_field4
  , NULL::text AS custom_field5
FROM
  rewards r
