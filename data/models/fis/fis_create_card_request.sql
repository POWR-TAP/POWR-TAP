WITH rewards AS (
  SELECT
    tp.organization
    , tp.player_no
    , tp.first_name
    , tp.last_name
    , tp.ssn_fake
    , tp.employee_id
    , tp.dob
    , tp.age
    , tp.phone_number
    , tp.email
    ,
    LEFT (tp.shipping_address_attention
      , 18) AS shipping_address_attention -- Because it's either max of 18 or 26
    , tp.shipping_address_1
    , tp.shipping_address_2
    , tp.city
    , tp.state
    , tp.zipcode
    , tp.row_frozen
    , tp.uid
    , CONCAT(tp.first_name
      , ' '
      , tp.last_name) AS full_name
  FROM
    {{ ref ('tap_participants') }} tp
)
SELECT
  104438 AS subprogram_id
  , 160951 AS package_id
  , 'Personalized'::text AS order_type
  , 'BulkShip'::text AS shipping_type
  , 'UPS Ground'::text AS shipping_method
  , r.first_name AS name_first
  , NULL::text AS name_middle
  , r.last_name AS name_last
  , NULL::text AS suffix
  , r.ssn_fake AS ssn_number
  , r.dob
  , r.email
  , r.phone_number AS phone
  , r.full_name AS addressee
  , r.shipping_address_attention AS attention
  , NULL::text AS third_line
  , NULL::text AS fourth_line
  , r.full_name AS name_on_card
  , NULL::text AS proxy_number
  , NULL::text AS card_number
  , NULL::text AS dda_number
  , r.employee_id
  , r.shipping_address_1 AS residential_address1
  , r.shipping_address_2 AS residential_address2
  , r.city AS residential_city
  , r.state AS residential_state
  , r.zipcode AS residential_zip
  , 1 AS quantity
  , 0.00::numeric(4 , 2) AS payment
  , NULL::text AS comment
  , NULL::text AS data1
  , NULL::text AS data2
  , NULL::text AS data3
  , r.full_name AS shipping_addressee
  , r.shipping_address_attention AS shipping_attention
  , r.shipping_address_1 AS shipping_address1
  , r.shipping_address_2 AS shipping_address2
  , r.city AS shipping_city
  , r.state AS shipping_state
  , r.zipcode AS shipping_zip
  , NULL::text AS custom_field1
  , NULL::text AS custom_field2
  , NULL::text AS custom_field3
  , NULL::text AS custom_field4
  , NULL::text AS custom_field5
FROM
  rewards r
