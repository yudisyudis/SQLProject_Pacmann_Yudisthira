--Hubungan waktu order hingga barang sampai di pelanggan dengan skor review

SELECT  
ROUND(JULIANDAY(olist_order_dataset.order_delivered_customer_date) - JULIANDAY(olist_order_dataset.order_purchase_timestamp)) as waktu,
AVG(review.review_score) as rerata_skor
FROM olist_order_dataset
LEFT JOIN review ON olist_order_dataset.order_id == review.order_id
GROUP BY waktu
ORDER BY rerata_skor DESC;

CREATE TEMPORARY TABLE review as
SELECT
olist_order_reviews_dataset.order_id,
olist_order_reviews_dataset.review_score
FROM olist_order_reviews_dataset;