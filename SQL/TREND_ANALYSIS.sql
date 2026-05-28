USE MarketHubDB;
GO

-- Monthly Sales Trend
SELECT
    FORMAT(order_date, 'yyyy-MM') AS month,
    SUM(total_amount) AS total_sales
FROM [Order]
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY month;

-- Daily Order Activity
SELECT
    CAST(order_date AS DATE) AS order_day,
    COUNT(*) AS total_orders
FROM [Order]
GROUP BY CAST(order_date AS DATE)
ORDER BY order_day;

-- Payment Trends
SELECT
    status,
    COUNT(*) AS total_payments
FROM Payment
GROUP BY status;