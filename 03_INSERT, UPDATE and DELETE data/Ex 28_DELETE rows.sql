DELETE FROM invoices
WHERE client_id = (
		SELECT client_id
		FROM clients
		WHERE name = 'Myworks'
);