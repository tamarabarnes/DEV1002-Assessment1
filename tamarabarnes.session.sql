-- create service table 
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    service VARCHAR NOT NULL,
    price_per_hr NUMERIC(6, 2) NOT NULL
);
-- input seed data in the service table
INSERT INTO services (service, price_per_hr)
VALUES ('Dog Walking Private', 12),
    ('Dog Walking Group', 7),
    ('Dog Sitting', 20);
-- create customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    deleted_at TIMESTAMP DEFAULT NULL
);