CREATE DATABASE BookStoreDB;
USE BookStoreDB;

-- create table for books and authors
CREATE TABLE book_language (
language_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL
);
CREATE TABLE publisher (
publisher_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL
);
CREATE TABLE book (
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(250) NOT NULL,
isbn VARCHAR(20) UNIQUE,
price DECIMAL(10, 2),
publication_date DATE,
language_id INT,
publisher_id INT,
FOREIGN KEY (language_id) REFERENCES book_language(language_id),
FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);
CREATE TABLE author (
author_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL
);
CREATE TABLE book_author (
 book_id INT,
 author_id INT,
 PRIMARY KEY (book_id, author_id),
 FOREIGN KEY (book_id) REFERENCES book(book_id),
 FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- create table for customers and address
CREATE TABLE country (
country_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL
);
CREATE TABLE address (
address_id INT AUTO_INCREMENT PRIMARY KEY,
street VARCHAR(255),
city VARCHAR(100),
postal_code VARCHAR(20),
country_id INT,
FOREIGN KEY (country_id) REFERENCES country(country_id)
);
CREATE TABLE address_status (
status_id INT AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR(50) NOT NULL
);
CREATE TABLE customer (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100) UNIQUE,
phone VARCHAR(20)
);
CREATE TABLE customer_address (
customer_id INT,
address_id INT,
status_id INT,
PRIMARY KEY (customer_id, address_id),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (address_id) REFERENCES address(address_id),
FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- create orders and shipping table
CREATE TABLE shipping_method (
shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100),
cost DECIMAL(10, 2)
);

CREATE TABLE order_status (
status_id INT AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR(50)
);

CREATE TABLE cust_order (
order_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT,
order_date DATETIME,
shipping_method_id INT,
status_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

CREATE TABLE order_line (
order_line_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
book_id INT,
quantity INT,
price DECIMAL(10, 2),
FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE order_history (
history_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
status_id INT,
change_date DATETIME,
FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- inserting sample data
INSERT INTO country (name) VALUES ('Kenya'), ('Nigeria'), ('Uganda');
INSERT INTO book_language (name) VALUES ('English'), ('Swahili'), ('French');
INSERT INTO publisher (name) VALUES ('Pearson'), ('Longhorn'), ("KLB");
INSERT INTO author (name) VALUES ('Ngugi wa Thiong'), ('Chinua Achebe'), ('Margaret Ogola');

INSERT INTO book (title, isbn, publication_date, price, language_id, publisher_id)
VALUES ('The River Between', '9789966463600', '2004-03-01', 15.99, 1, 2),
	      ('Things Fall Apart', '9780385474542', '1994-06-01', 17.50, 1, 1),
       ('The River and the Source', '97803854457600', '2021-05-28', 17.50, 1, 3);

INSERT INTO book_author (book_id, author_id) VALUES (1, 1), (2, 2), (3, 3);
-- insert customers and address
INSERT INTO customer (name, email, phone) 
VALUES  ('Jane Kuchal', 'janekuchal@gmail.com', '+254712345678'),
        ('Jack Arogo', 'jackarogo@gmail.com', '+254712340000'),
        ('Phill Jones', 'philljone@gmail.com', '+254712356750');
INSERT INTO address_status (status_name) VALUES ('Current'), ('Old');

INSERT INTO address (street, city, postal_code, country_id)
VALUES ('123 Koinange St', 'Nairobi', '00100', 1),
	      ('456 Fedha st', 'Nairobi', '00100', 1),
       ('678 Tom mboys st', 'Nairobi', '00100', 1);
INSERT INTO customer_address (customer_id, address_id, status_id)
VALUES (1, 1, 1);
INSERT INTO shipping_method (name, cost) 
VALUES ('Standard', 5.50), ('Express', 10.99);
INSERT INTO order_status (status_name)
VALUES ('Pending'), ('Shipped'), ('Delivered');
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, status_id)
VALUES (1, NOW() , 1, 1);
INSERT INTO order_line (order_id, book_id, quantity, price)
VALUES (1, 1, 2, 15.99), (1, 2, 1, 17.50);
INSERT INTO order_history (order_id, status_id, change_date)
VALUES (1, 1, NOW())

-- Create roles
CREATE ROLE bookstore_admin;
CREATE ROLE bookstore_readonly;
CREATE ROLE bookstore_order_clerk;

-- Create users and assign passwords
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'AdminPass1234!';
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'ReadOnlyPass@1234';
CREATE USER 'order_clerk'@'localhost' IDENTIFIED BY 'OrderClerk@2025';

-- Grant roles to users
GRANT bookstore_admin TO 'admin_user'@'localhost';
GRANT bookstore_readonly TO 'readonly_user'@'localhost';
GRANT bookstore_order_clerk TO 'order_clerk'@'localhost';

-- Grant Permissions to Roles
GRANT ALL PRIVILEGES ON bookstoredb.* TO bookstore_admin;
GRANT SELECT ON bookstoredb.* TO bookstore_readonly;
GRANT SELECT, INSERT, UPDATE ON bookstoredb.* TO bookstore_order_clerk;


















