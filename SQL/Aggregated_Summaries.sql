USE MarketHubDB;
GO

-- Total Sales per Seller
SELECT
    p.seller_id,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM Product p
JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY p.seller_id;

-- Total Orders per Buyer
SELECT
    buyer_id,
    COUNT(*) AS total_orders
FROM [Order]
GROUP BY buyer_id;

-- Average Product Rating
SELECT
    product_id,
    AVG(rating) AS avg_rating
FROM Review
GROUP BY product_id;

-- Inventory per Warehouse
SELECT
    warehouse_id,
    SUM(quantity) AS total_stock
FROM Inventory
GROUP BY warehouse_id;

-- Revenue by Category
SELECT
    c.name AS category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM Category c
JOIN Subcategory sc ON c.category_id = sc.category_id
JOIN Product p ON sc.subcategory_id = p.subcategory_id
JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY c.name;