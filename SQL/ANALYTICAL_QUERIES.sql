--Top selling products
SELECT TOP 5 
       p.product_id,
       p.name,
       SUM(oi.quantity) AS total_sold
FROM Product p
JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC;

--Most active buyers
SELECT TOP 5
       buyer_id,
       COUNT(order_id) AS total_orders
FROM [Order]
GROUP BY buyer_id
ORDER BY total_orders DESC;

--Monthly sales trends
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(total_amount) AS monthly_sales
FROM [Order]
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

--Products never purchased
SELECT *
FROM Product
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM OrderItem
);

-- Sellers with no sales
SELECT *
FROM Seller s
WHERE s.user_id NOT IN (
    SELECT DISTINCT p.seller_id
    FROM Product p
    JOIN OrderItem oi ON p.product_id = oi.product_id
);

-- Orders pending shipment
SELECT *
FROM [Order] o
JOIN Shipment s ON o.shipment_id = s.shipment_id
WHERE s.status = 'pending';