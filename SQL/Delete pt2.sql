
-- -------- HANDLING FK ---------------
-- Delete users with no activity 
DELETE FROM [User]
WHERE user_id NOT IN (SELECT buyer_id FROM [Order])
AND user_id NOT IN (SELECT buyer_id FROM Cart)
AND user_id NOT IN (SELECT user_id FROM Seller);



-- -------- Handlind Dependencies --------------
-- OrderItems
DELETE FROM OrderItem
WHERE order_id IN (
    SELECT order_id FROM [Order] WHERE buyer_id = 3
);

-- Payments 
DELETE FROM Payment
WHERE order_id IN (
    SELECT order_id FROM [Order] WHERE buyer_id = 3
);

-- Buyer_Order 
DELETE FROM Buyer_Order
WHERE buyer_id = 3
   OR order_id IN (
        SELECT order_id FROM [Order] WHERE buyer_id = 3
   );

-- Reviews
DELETE FROM Review
WHERE buyer_id = 3;

-- CartItems
DELETE FROM CartItem
WHERE cart_id IN (
    SELECT cart_id FROM Cart WHERE buyer_id = 3
);

-- Cart
DELETE FROM Cart WHERE buyer_id = 3;

-- Orders
DELETE FROM [Order] WHERE buyer_id = 3;

-- Buyer table
DELETE FROM Buyer WHERE user_id = 3;

-- User table (last step always)
DELETE FROM [User] WHERE user_id = 3;