USE MarketHubDB;
GO

-- High Performing Sellers (HAVING)
SELECT
    p.seller_id,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM Product p
JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY p.seller_id
HAVING SUM(oi.quantity * oi.unit_price) > 50000;

-- Low Stock Products
SELECT *
FROM Product
WHERE stock < 20;

-- High Value Orders
SELECT *
FROM [Order]
WHERE total_amount > 50000;