USE MarketHubDB;
GO

 -- CREATE VIEWS

-- Product Catalog View
CREATE VIEW ProductCatalog AS
SELECT 
    p.product_id,
    p.name AS product_name,
    p.price,
    p.stock,
    s.shop_name,
    sc.name AS subcategory_name
FROM Product p
JOIN Seller s ON p.seller_id = s.user_id
JOIN Subcategory sc ON p.subcategory_id = sc.subcategory_id;
GO


-- Order Summary View
CREATE VIEW OrderSummary AS
SELECT 
    o.order_id,
    o.buyer_id,
    o.order_date,
    o.total_amount,
    o.status AS order_status,
    sh.status AS shipment_status
FROM [Order] o
JOIN Shipment sh ON o.shipment_id = sh.shipment_id;
GO


-- Seller Dashboard View
CREATE VIEW SellerDashboard AS
SELECT 
    s.user_id AS seller_id,
    s.shop_name,
    COUNT(DISTINCT p.product_id) AS total_products,
    ISNULL(SUM(oi.quantity * oi.unit_price), 0) AS total_sales
FROM Seller s
LEFT JOIN Product p ON s.user_id = p.seller_id
LEFT JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY s.user_id, s.shop_name;
GO


-- QUERY USING VIEWS

-- Product Catalog
SELECT * 
FROM ProductCatalog;
GO

-- Order Summary (filtered)
SELECT *
FROM OrderSummary
WHERE order_status = 'delivered';
GO

-- Seller performance
SELECT *
FROM SellerDashboard
ORDER BY total_sales DESC;
GO