--Kota tempat tiap jenis barang paling banyak terjual

CREATE TEMPORARY TABLE customer_product as 
SELECT
olist_order_dataset.customer_id,
olist_order_items_dataset.product_id,
olist_order_items_dataset.order_item_id
FROM 
olist_order_items_dataset
LEFT JOIN olist_order_dataset ON  olist_order_items_dataset.order_id = olist_order_dataset.order_id;

CREATE TEMPORARY TABLE product_city as 
SELECT 
olist_order_customer_dataset.customer_city,
customer_product.product_id,
customer_product.order_item_id
FROM customer_product
LEFT JOIN olist_order_customer_dataset on olist_order_customer_dataset.customer_id = customer_product.customer_id;

SELECT customer_city, translate_.product_category_name_english as product_name, SUM(order_item_id) as jumlah_pembelian
FROM product_city
LEFT JOIN translate_ on product_city.product_id = translate_.product_id
GROUP BY customer_city, product_name
order by jumlah_pembelian DESC;

CREATE TEMPORARY TABLE translate_ as
SELECT 
olist_products_dataset.product_id,
product_category_name_translation.product_category_name_english
FROM olist_products_dataset
LEFT JOIN product_category_name_translation ON olist_products_dataset.product_category_name = product_category_name_translation.product_category_name