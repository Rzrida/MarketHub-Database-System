--1. Delete cart items
DELETE FROM CartItem
WHERE cart_id = 1 AND product_id = 3;

--2. Delete reviews
DELETE FROM Review
WHERE review_id = 5;

--3. Delete inactive products
DELETE FROM Product
WHERE status = 'inactive';

--4. Delete cancelled orders
DELETE FROM [Order]
WHERE status = 'cancelled';


--5. Prevent invalid deletions (safe delete using condition)
DELETE FROM Product
WHERE product_id = 1
AND stock = 0;

--6. Delete using subquery
DELETE FROM Review
WHERE product_id IN (
    SELECT product_id
    FROM Product
    WHERE price > 100000
);

--7. Delete using JOIN
DELETE R
FROM Review R
JOIN Product P ON R.product_id = P.product_id
WHERE P.status = 'deleted';