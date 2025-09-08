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
    phone VARCHAR(15) NOT NULL UNIQUE,
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
-- Creating dog walker table 
CREATE TABLE dog_walker (
    walker_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    deleted_at TIMESTAMP DEFAULT NULL
);
-- inserting values into dog_walker table
INSERT INTO dog_walker (first_name, last_name, email, phone)
VALUES (
        'Rupert',
        'Grint',
        'rupert.grint123@gmail.com',
        '0411223344'
    ),
    (
        'Daniel',
        'Radcliffe',
        'dan.radcliffe@outlook.com',
        '0433445566'
    ),
    (
        'Tom',
        'Felton',
        'felton.tom@hotmail.com',
        '0477889911'
    );
-- Adding memberships table
CREATE TABLE memberships (
    membership_id SERIAL PRIMARY KEY,
    account_name VARCHAR(100) NOT NULL,
    active_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    customer_id INTEGER NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT
);