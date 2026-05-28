USE MarketHubDB;
GO

-- Customers with no orders
SELECT u.user_id, u.name
FROM [User] u
LEFT JOIN [Order] o ON u.user_id = o.buyer_id
WHERE o.order_id IS NULL;

-- Products never purchased
SELECT p.product_id, p.name
FROM Product p
LEFT JOIN OrderItem oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- Sellers with no sales
SELECT s.user_id, s.shop_name
FROM Seller s
LEFT JOIN Product p ON s.user_id = p.seller_id
LEFT JOIN OrderItem oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- Pending orders
SELECT *
FROM [Order]
WHERE status IN ('pending');

-- Failed / pending payments
SELECT *
FROM Payment
WHERE status IN ('pending', 'failed');