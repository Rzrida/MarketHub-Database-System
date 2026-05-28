-- Function: Calculate Order Total

CREATE FUNCTION fn_CalculateOrderTotal (@order_id INT)
RETURNS DECIMAL(12,2)
AS
BEGIN
    DECLARE @total DECIMAL(12,2);

    SELECT @total = SUM(quantity * unit_price)
    FROM OrderItem
    WHERE order_id = @order_id;

    RETURN ISNULL(@total, 0);
END;
GO


SELECT dbo.fn_CalculateOrderTotal(1) AS OrderTotal;

