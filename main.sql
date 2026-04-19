CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    data JSON
);

INSERT INTO users (id, name, email, data)
VALUES
    (1, 'John Doe', 'johndoe@example.com', '{"address": {"street": "123 Main St", "city": "Anytown", "state": "CA", "zip": "12345"}}'),
    (2, 'Jane Doe', 'janedoe@example.com', '{"address": {"street": "456 Elm St", "city": "Othertown", "state": "NY", "zip": "67890"}}'),
    (3, 'Bob Smith', 'bobsmith@example.com', '{"address": {"street": "789 Oak St", "city": "Thirdtown", "state": "FL", "zip": "34567"}}');

CREATE TABLE orders (
    id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total DECIMAL(10, 2),
    items JSON,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO orders (id, user_id, order_date, total, items)
VALUES
    (1, 1, '2022-01-01', 100.00, '[{"product_id": 1, "quantity": 2}, {"product_id": 2, "quantity": 3}]'),
    (2, 2, '2022-01-15', 200.00, '[{"product_id": 3, "quantity": 1}, {"product_id": 4, "quantity": 2}]'),
    (3, 3, '2022-02-01', 50.00, '[{"product_id": 1, "quantity": 1}]');

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    description TEXT
);

INSERT INTO products (id, name, price, description)
VALUES
    (1, 'Product 1', 20.00, 'This is product 1'),
    (2, 'Product 2', 30.00, 'This is product 2'),
    (3, 'Product 3', 40.00, 'This is product 3'),
    (4, 'Product 4', 50.00, 'This is product 4');

CREATE TABLE invoices (
    id INT PRIMARY KEY,
    order_id INT,
    invoice_date DATE,
    total DECIMAL(10, 2),
    details JSON,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

INSERT INTO invoices (id, order_id, invoice_date, total, details)
VALUES
    (1, 1, '2022-01-05', 100.00, '{"payment_method": "credit_card", "payment_date": "2022-01-05"}'),
    (2, 2, '2022-01-20', 200.00, '{"payment_method": "bank_transfer", "payment_date": "2022-01-20"}'),
    (3, 3, '2022-02-05', 50.00, '{"payment_method": "cash", "payment_date": "2022-02-05"}');

SELECT * FROM users;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM invoices;

SELECT users.name, orders.total, orders.items FROM users JOIN orders ON users.id = orders.user_id;
SELECT orders.user_id, orders.total, products.name FROM orders JOIN products ON JSON_EXTRACT(orders.items, '$[0].product_id') = products.id;
SELECT invoices.order_id, invoices.total, invoices.details FROM invoices JOIN orders ON invoices.order_id = orders.id; 

SELECT JSON_EXTRACT(data, '$.address.city') AS city FROM users;
SELECT JSON_EXTRACT(items, '$[0].product_id') AS product_id FROM orders;
SELECT JSON_EXTRACT(details, '$.payment_method') AS payment_method FROM invoices; 

SELECT JSON_EXTRACT(data, '$.address') AS address FROM users WHERE id = 1;
SELECT JSON_EXTRACT(items, '$[0]') AS item FROM orders WHERE id = 1;
SELECT JSON_EXTRACT(details, '$') AS details FROM invoices WHERE id = 1; 

SELECT JSON_EXTRACT(data, '$.address.city') AS city FROM users WHERE JSON_EXTRACT(data, '$.address.state') = 'CA';
SELECT JSON_EXTRACT(items, '$[0].product_id') AS product_id FROM orders WHERE JSON_EXTRACT(items, '$[0].quantity') = 2;
SELECT JSON_EXTRACT(details, '$.payment_method') AS payment_method FROM invoices WHERE JSON_EXTRACT(details, '$.payment_date') = '2022-01-05';