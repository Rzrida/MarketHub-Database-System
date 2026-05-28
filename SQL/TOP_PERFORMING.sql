USE MarketHubDB;
GO

-- Top Customers (by total spending)
SELECT TOP 5
    o.buyer_id,
    SUM(o.total_amount) AS total_spent
FROM [Order] o
GROUP BY o.buyer_id
ORDER BY total_spent DESC;

-- Top Selling Products
SELECT TOP 5
    oi.product_id,
    SUM(oi.quantity) AS total_sold
FROM OrderItem oi
GROUP BY oi.product_id
ORDER BY total_sold DESC;

-- Best Sellers (by sales)
SELECT TOP 5
    p.seller_id,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM Product p
JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY p.seller_id
ORDER BY total_sales DESC;