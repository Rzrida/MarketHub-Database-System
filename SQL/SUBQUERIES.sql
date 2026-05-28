--Products above average price
SELECT *
FROM Product
WHERE price > (SELECT AVG(price) FROM Product);

-- Buyer with maximum orders
SELECT TOP 1 buyer_id, COUNT(order_id) AS total_orders
FROM [Order]
GROUP BY buyer_id
ORDER BY total_orders DESC;

--Seller with highest rating
SELECT *
FROM Seller
WHERE rating = (SELECT MAX(rating) FROM Seller);

--Orders above average total
SELECT *
FROM [Order]
WHERE total_amount > (SELECT AVG(total_amount) FROM [Order]);

--Products never ordered
SELECT *
FROM Product
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM OrderItem
);