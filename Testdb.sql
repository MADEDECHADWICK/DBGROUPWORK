-- Verify all required tables exist
SHOW TABLES;
-- Expected output should include all 15 tables from the schema
-- Sample test for book table structure
DESCRIBE book;
-- Expected columns: book_id, title, price, publication_date, language_id, publisher_id

-- Test foreign key constraint on book table
INSERT INTO book (title, language_id, publisher_id) 
VALUES ('Test Book', 999, 999);
-- Expected: Should fail with foreign key constraint error
-- Verify initial book data
SELECT COUNT(*) FROM book;

-- Verify author-book relationships
SELECT COUNT(*) FROM book_author;
-- Expected: 3 records

-- Test unique email constraint
INSERT INTO customer (name, email, phone) 
VALUES ('Test User', 'janekuchal@gmail.com', '+254700000000');
-- Expected: Should fail with duplicate email error

-- Verify books have correct authors
SELECT b.title, a.name 
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
ORDER BY b.title;
-- Expected: Each book should show correct author

-- Verify customer has orders
SELECT c.name, COUNT(o.order_id) as order_count
FROM customer c
LEFT JOIN cust_order o ON c.customer_id = o.customer_id
GROUP BY c.name;
-- Expected: Jane Kuchal should have 1 order, others 0

-- Test complete order lifecycle
-- 1. Create new order
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, status_id)
VALUES (2, NOW(), 2, 1);

-- 2. Add order lines
SET @new_order_id = LAST_INSERT_ID();
INSERT INTO order_line (order_id, book_id, quantity, price)
VALUES (@new_order_id, 3, 1, 16.99);

-- 3. Update order status
INSERT INTO order_history (order_id, status_id, change_date)
VALUES (@new_order_id, 2, NOW());

-- 4. Verify order total
SELECT SUM(quantity * price) as order_total
FROM order_line
WHERE order_id = @new_order_id;
-- Expected: 16.99
