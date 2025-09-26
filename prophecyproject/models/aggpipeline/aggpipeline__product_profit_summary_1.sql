{{
  config({    
    "materialized": "table",
    "alias": "product_profit_summary",
    "database": "prophecy",
    "schema": "prophecy_db"
  })
}}

WITH customer AS (

  SELECT * 
  
  FROM {{ source('prophecy.prophecy_db', 'customer') }}

),

sales AS (

  SELECT * 
  
  FROM {{ source('prophecy.prophecy_db', 'sales') }}

),

inner_join_tables AS (

  SELECT 
    in1.row_id AS row_id,
    in1.order_id AS order_id,
    in1.order_date AS order_date,
    in1.ship_date AS ship_date,
    in1.ship_mode AS ship_mode,
    in1.customer_id AS customer_id,
    in1.product_id AS product_id,
    in1.sales AS sales,
    in1.quantity AS quantity,
    in1.discount AS discount,
    in1.profit AS profit,
    in2.customer_name AS customer_name,
    in2.segment AS segment,
    in2.country AS country,
    in2.city AS city,
    in2.state AS state,
    in2.postal_code AS postal_code,
    in2.region AS region
  
  FROM sales AS in1
  INNER JOIN customer AS in2
     ON in2.customer_id = in1.customer_id

),

product AS (

  SELECT * 
  
  FROM {{ source('prophecy.prophecy_db', 'product') }}

),

order_product_details AS (

  SELECT 
    in1.product_id AS product_id,
    in1.category AS category,
    in1.sub_category AS sub_category,
    in1.product_name AS product_name,
    in0.row_id AS row_id,
    in0.order_id AS order_id,
    in0.order_date AS order_date,
    in0.ship_date AS ship_date,
    in0.ship_mode AS ship_mode,
    in0.customer_id AS customer_id,
    in0.sales AS sales,
    in0.profit AS profit,
    in0.discount AS discount,
    in0.quantity AS quantity,
    in0.customer_name AS customer_name,
    in0.segment AS segment,
    in0.country AS country,
    in0.city AS city,
    in0.state AS state,
    in0.postal_code AS postal_code,
    in0.region AS region
  
  FROM inner_join_tables AS in0
  INNER JOIN product AS in1
     ON in1.product_id = in0.product_id

),

profitable_order_products AS (

  SELECT * 
  
  FROM order_product_details AS in0
  
  WHERE profit >= 0

),

product_profit_summary AS (

  SELECT 
    product_name AS product_name,
    sum(profit) AS profit
  
  FROM profitable_order_products AS in0
  
  GROUP BY product_name

),

profit_ascending_summary AS (

  SELECT * 
  
  FROM product_profit_summary AS in0
  
  ORDER BY profit DESC

),

negative_profit_orders AS (

  SELECT * 
  
  FROM order_product_details AS in0
  
  WHERE profit < 0

),

product_loss_summary AS (

  SELECT 
    product_name AS product_name,
    sum(profit) AS profit
  
  FROM negative_profit_orders AS in0
  
  GROUP BY product_name

),

sorted_product_loss_summary AS (

  SELECT * 
  
  FROM product_loss_summary AS in0
  
  ORDER BY profit ASC

),

Union_1 AS (

  SELECT * 
  
  FROM sorted_product_loss_summary AS in0
  
  UNION
  
  SELECT * 
  
  FROM profit_ascending_summary AS in1

),

product_profit_summary_1 AS (

  SELECT 
    product_name AS product_name,
    sum(profit) AS profit
  
  FROM Union_1 AS in0
  
  GROUP BY product_name

)

SELECT *

FROM product_profit_summary_1
