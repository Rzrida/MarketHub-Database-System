Use MarketHubDB;

--1. Update product details (price, stock)
UPDATE Product
SET price = 95000, stock = 100
WHERE product_id = 1;
--2. Update order status
UPDATE [Order]
SET status = 'shipped'
WHERE order_id = 9;
--3. Update shipment status
UPDATE Shipment
SET status = 'in_transit', shipped_at = GETDATE()
WHERE shipment_id = 10;
--4. Update user information
UPDATE [User]
SET name = 'Ali Hassan Updated',
    phone = '0300-1111111'
WHERE user_id = 1;