-- 1. SELECT ALL RECORDS
SELECT * FROM [User];
SELECT * FROM Product;
SELECT * FROM [Order];
SELECT * FROM Review;
SELECT * FROM Payment;

-- 2. SELECT WITH WHERE CONDITIONS
-- Active products only
SELECT * 
FROM Product
WHERE status = 'active';

-- High value orders
SELECT * 
FROM [Order]
WHERE total_amount > 50000;

-- Buyers with high loyalty points
SELECT * 
FROM Buyer
WHERE loyalty_points > 300;

-- Reviews with rating 5
SELECT * 
FROM Review
WHERE rating = 5;

-- Pending payments
SELECT * 
FROM Payment
WHERE status = 'pending';

-- 3. ORDER BY (SORTING)
-- Products by price (High to Low)
SELECT * 
FROM Product
ORDER BY price DESC;

-- Orders by date (latest first)
SELECT * 
FROM [Order]
ORDER BY order_date DESC;

-- Users alphabetically
SELECT * 
FROM [User]
ORDER BY name ASC;

-- Reviews by rating (best first)
SELECT * 
FROM Review
ORDER BY rating DESC;

-- 4. AGGREGATE FUNCTIONS

-- Total users
SELECT COUNT(*) AS total_users FROM [User];

-- Total products
SELECT COUNT(*) AS total_products FROM Product;

-- Total orders
SELECT COUNT(*) AS total_orders FROM [Order];
 
-- Total revenue from orders
SELECT SUM(total_amount) AS total_revenue 
FROM [Order];

-- Total stock available
SELECT SUM(stock) AS total_stock 
FROM Product;

-- Average order value
SELECT AVG(total_amount) AS avg_order_value 
FROM [Order];

-- Average product price
SELECT AVG(price) AS avg_product_price 
FROM Product;

-- Average rating of products
SELECT AVG(rating) AS avg_rating 
FROM Review;

-- Average rating per product
SELECT product_id, AVG(rating) AS avg_rating
FROM Review
GROUP BY product_id;