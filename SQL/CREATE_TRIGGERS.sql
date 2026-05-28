-- 1. Reduce stock after order (OrderItem insert)
CREATE TRIGGER trg_reduce_stock
ON OrderItem
AFTER INSERT
AS
BEGIN
    UPDATE Product
    SET stock = stock - i.quantity
    FROM Product p
    INNER JOIN inserted i
        ON p.product_id = i.product_id;
END;
GO

-- 2. Prevent negative inventory (safety trigger)
CREATE TRIGGER trg_prevent_negative_stock
ON Product
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Product
        WHERE stock < 0
    )
    BEGIN
        RAISERROR ('Stock cannot go below 0', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO


-- 3. Auto update cart timestamp
CREATE TRIGGER trg_update_cart_timestamp
ON CartItem
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE Cart
    SET updated_at = GETDATE()
    WHERE cart_id IN (
        SELECT cart_id FROM inserted
        UNION
        SELECT cart_id FROM deleted
    );
END;
GO