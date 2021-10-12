INSERT INTO customers (
	first_name,
    last_name,
    birth_date,
    address,
    city,
    state)
VALUES (
	'John',
    'Smith',
    '1990-01-01',
    'address',
    'city',
    'CA');
    
INSERT INTO shippers (name)
VALUES 	('Shipper1'),
		('Shipper2'),
        ('Shipper3');
        
-- INSERT three rows in the product tables
INSERT INTO products (name, quantity_in_stock, unit_price)
VALUES 	('Unicorn', 5, 15),
		('Spike', 20, 7),
        ('Webby', 5, 8);
        
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);

INSERT INTO order_items
VALUES 
	(LAST_INSERT_ID(), 1, 1, 2.95),
  	(LAST_INSERT_ID(), 2, 1, 3.95);
  