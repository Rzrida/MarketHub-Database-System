-- 1. INNER JOIN (User + Order)

SELECT 
    U.user_id,
    U.name,
    O.order_id,
    O.order_date,
    O.total_amount,
    O.status
FROM [User] U
INNER JOIN Buyer B ON U.user_id = B.user_id
INNER JOIN [Order] O ON B.user_id = O.buyer_id;


-- 2. INNER JOIN (Product + OrderItem)

SELECT 
    P.product_id,
    P.name AS product_name,
    OI.order_id,
    OI.quantity,
    OI.unit_price
FROM Product P
INNER JOIN OrderItem OI ON P.product_id = OI.product_id;



-- 3. LEFT JOIN (Products with/without Reviews)

SELECT 
    P.product_id,
    P.name,
    R.rating,
    R.comment
FROM Product P
LEFT JOIN Review R 
ON P.product_id = R.product_id;



--4. LEFT JOIN (Sellers with/without Products)

SELECT 
    S.user_id,
    S.shop_name,
    P.product_id,
    P.name AS product_name
FROM Seller S
LEFT JOIN Product P 
ON S.user_id = P.seller_id;



-- 5. Multi-table JOIN (Order → Payment → Shipment)

SELECT 
    O.order_id,
    O.order_date,
    O.total_amount,
    P.payment_id,
    P.method,
    P.status AS payment_status,
    S.shipment_id,
    S.status AS shipment_status
FROM [Order] O
INNER JOIN Payment P 
ON O.order_id = P.order_id
INNER JOIN Shipment S 
ON O.shipment_id = S.shipment_id;

-- Multi-table JOIN (Buyer → Order → Product)

SELECT 
    B.user_id AS buyer_id,
    U.name AS buyer_name,
    O.order_id,
    P.product_id,
    P.name AS product_name,
    OI.quantity,
    OI.unit_price
FROM Buyer B
INNER JOIN [User] U 
ON B.user_id = U.user_id
INNER JOIN [Order] O 
ON B.user_id = O.buyer_id
INNER JOIN OrderItem OI 
ON O.order_id = OI.order_id
INNER JOIN Product P 
ON OI.product_id = P.product_id;
