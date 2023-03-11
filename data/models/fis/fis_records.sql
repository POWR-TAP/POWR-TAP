SELECT
  meta.basename AS __basename
  , meta.file AS __file
  , CASE (kv.data ->> 'status'::text) IS NULL
  WHEN TRUE THEN
    'submission'::text
  WHEN FALSE THEN
    'response'::text
  ELSE
    NULL::text
  END AS __file_type
  , meta."row" AS __row
  , kv.data ->> 'status'::text AS __status
  , kv.data ->> 'statuscode'::text AS __status_code
  , kv.data ->> 'message'::text AS __status_message
  , kv.data ->> 'order_type'::text AS __type
  , COALESCE(kv.data ->> 'proxy'::text , proxy_number) AS __proxy_number
  , (col.__meta ->> 'modified_at')::timestamptz AS __modified_at
  , col.__meta
  , col.subprogram_id
  , col.package_id
  , col.order_type
  , col.shipping_type
  , col.shipping_method
  , col.name_first
  , col.name_middle
  , col.name_last
  , col.suffix
  , col.ssn_number
  , col.dob
  , col.email
  , col.phone
  , col.addressee
  , col.attention
  , col.third_line
  , col.fourth_line
  , col.name_on_card
  , col.proxy_number
  , col.card_number
  , col.dda_number
  , col.employee_id
  , col.residential_address1
  , col.residential_address2
  , col.residential_city
  , col.residential_state
  , col.residential_zip
  , col.quantity
  , col.payment
  , col.comment
  , col.data1
  , col.data2
  , col.data3
  , col.shipping_addressee
  , col.shipping_attention
  , col.shipping_address1
  , col.shipping_address2
  , col.shipping_city
  , col.shipping_state
  , col.shipping_zip
  , col.custom_field1
  , col.custom_field2
  , col.custom_field3
  , col.custom_field4
  , col.custom_field5
FROM
  production.kv
  , LATERAL JSONB_TO_RECORD(kv.data) col (__meta jsonb , subprogram_id text , package_id text , order_type text , shipping_type text , shipping_method text , name_first text , name_middle text , name_last text , suffix text , ssn_number text , dob text , email text , phone text , addressee text , attention text , third_line text , fourth_line text , name_on_card text , proxy_number text , card_number text , dda_number text , employee_id text , residential_address1 text , residential_address2 text , residential_city text , residential_state text , residential_zip text , quantity text , payment text , comment text , data1 text , data2 text , data3 text , shipping_addressee text , shipping_attention text , shipping_address1 text , shipping_address2 text , shipping_city text , shipping_state text , shipping_zip text , custom_field1 text , custom_field2 text , custom_field3 text , custom_field4 text , custom_field5 text)
  , LATERAL JSONB_TO_RECORD(col.__meta) meta ("row" numeric , file text , basename text)
WHERE
  kv.type = 'CSV_ROW_TYPE'::text
