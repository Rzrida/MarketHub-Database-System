--Sales per seller
SELECT p.seller_id,
       SUM(oi.quantity * oi.unit_price) AS total_sales
FROM Product p
JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY p.seller_id;

--Orders per buyer
SELECT buyer_id,
       COUNT(order_id) AS total_orders
FROM [Order]
GROUP BY buyer_id;

--Average rating per product
SELECT product_id,
       AVG(rating) AS avg_rating
FROM Review
GROUP BY product_id;

--Inventory per warehouse
SELECT warehouse_id,
       SUM(quantity) AS total_stock
FROM Inventory
GROUP BY warehouse_id;

--Sellers with sales greater than 100,000
SELECT p.seller_id,
       SUM(oi.quantity * oi.unit_price) AS total_sales
FROM Product p
JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY p.seller_id
HAVING SUM(oi.quantity * oi.unit_price) > 100000;

-- Buyers with more than 2 orders
SELECT buyer_id,
       COUNT(order_id) AS total_orders
FROM [Order]
GROUP BY buyer_id
HAVING COUNT(order_id) > 2;

-- Products with average rating ≥ 4
SELECT product_id,
       AVG(rating) AS avg_rating
FROM Review
GROUP BY product_id
HAVING AVG(rating) >= 4;

-- Warehouses with stock greater than 500
SELECT warehouse_id,
       SUM(quantity) AS total_stock
FROM Inventory
GROUP BY warehouse_id
HAVING SUM(quantity) > 500;