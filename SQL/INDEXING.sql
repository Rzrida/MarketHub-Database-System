-- 1. Index on product_id
CREATE INDEX idx_product_id
ON Product(product_id);
GO

-- 2. Index on order_id
CREATE INDEX idx_order_id
ON [Order](order_id);
GO

-- 3. Index on buyer_id
CREATE INDEX idx_buyer_id
ON [Order](buyer_id);
GO


-- Verify Indexes 
SELECT *
FROM sys.indexes
WHERE object_id = OBJECT_ID('Product');