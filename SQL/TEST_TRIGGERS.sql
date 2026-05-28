
-- TRIGGER 1
INSERT INTO OrderItem (order_id, product_id, quantity, unit_price)
VALUES (1, 1, 2, 90000);

-- Check:
SELECT stock FROM Product WHERE product_id = 1;


-- Test negative prevention:
UPDATE Product
SET stock = -5
WHERE product_id = 1;


--Test cart timestamp:
INSERT INTO CartItem (cart_id, product_id, quantity)
VALUES (1, 2, 1);

-- check:

SELECT updated_at FROM Cart WHERE cart_id = 1;