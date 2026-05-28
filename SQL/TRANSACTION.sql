BEGIN TRANSACTION;

BEGIN TRY

    -- 1. Insert Order
    INSERT INTO [Order] (buyer_id, address_id, shipment_id, total_amount, status)
    VALUES (1, 1, 1, 5000, 'pending');

    DECLARE @order_id INT = SCOPE_IDENTITY();

    -- 2. Insert Order Item
    INSERT INTO OrderItem (order_id, product_id, quantity, unit_price)
    VALUES (@order_id, 1, 1, 5000);

    -- 3. Update Product Stock
    UPDATE Product
    SET stock = stock - 1
    WHERE product_id = 1;

    -- If everything works
    COMMIT TRANSACTION;

END TRY

BEGIN CATCH

    -- If any error occurs
    ROLLBACK TRANSACTION;

    PRINT 'Transaction Failed and Rolled Back';

END CATCH;
GO

SELECT * FROM [Order] ORDER BY order_id DESC;
SELECT * FROM OrderItem;
SELECT stock FROM Product WHERE product_id = 1;