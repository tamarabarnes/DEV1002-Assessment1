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
    customer_id INTEGER NOT NULL,
    plan_type VARCHAR(50) NOT NULL,
    account_name VARCHAR(100) NOT NULL,
    active_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT
);
-- inserting values into memberships table
INSERT INTO memberships (
        customer_id,
        plan_type,
        account_name,
        active_date,
        expiry_date
    )
VALUES (
        1,
        'Monthly',
        'j.simmons',
        '2025-08-28',
        '2025-09-28'
    ),
    (
        2,
        'Yearly',
        'r.hunter',
        '2024-10-20',
        '2025-10-20'
    ),
    (
        3,
        'Yearly',
        'd.ferguson',
        '2025-04-15',
        '2026-04-15'
    );
-- Creating bookings table
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    booking_type VARCHAR(100) NOT NULL,
    booking_date DATE NOT NULL,
    booking_time TIME NOT NULL,
    status VARCHAR(100) NOT NULL,
    customer_id INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    walker_id INTEGER NOT NULL,
    FOREIGN KEY customer_id REFERENCES customers(customer_id) ON DELETE RESTRICT,
    FOREIGN KEY service_id REFERENCES services(service_id) ON DELETE RESTRICT,
    FOREIGN KEY walker_id REFERENCES dog_walker(walker_id) ON DELETE RESTRICT
);
-- Creating payments table 
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    payment_date DATE NOT NULL,
    amount_paid NUMERIC(6, 2) NOT NULL,
    payment_type VARCHAR(20) NOT NULL CHECK (payment_type IN ('membership', 'booking')),
    membership_id INTEGER DEFAULT NULL,
    booking_id INTEGER DEFAULT NULL,
    customer_id INTEGER NOT NULL,
    FOREIGN KEY (membership_id) REFERENCES memberships(membership_id) ON DELETE RESTRICT,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE RESTRICT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT
);