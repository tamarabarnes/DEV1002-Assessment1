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
-- inserting values into customers table
INSERT INTO customers (first_name, last_name, dob, email, phone)
VALUES (
        'Jake',
        'Simmons',
        '1993-05-14',
        'jacob.sim116@outlook.com',
        '0418741861'
    ),
    (
        'Rebecca',
        'Hunter',
        '1991-10-23',
        'rebecca.h123@gmail.com',
        '0451234521'
    ),
    (
        'Daniella',
        'Ferguson',
        '1996-11-17',
        'dani.ferg@hotmail.com',
        '0490909090'
    );