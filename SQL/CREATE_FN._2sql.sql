-- Function: Calculate Seller Rating

CREATE FUNCTION fn_SellerRating (@seller_id INT)
RETURNS DECIMAL(3,2)
AS
BEGIN
    DECLARE @avg_rating DECIMAL(3,2);

    SELECT @avg_rating = AVG(r.rating)
    FROM Review r
    INNER JOIN Product p
        ON r.product_id = p.product_id
    WHERE p.seller_id = @seller_id;

    RETURN ISNULL(@avg_rating, 0);
END;
GO

SELECT dbo.fn_SellerRating(16) AS SellerRating;