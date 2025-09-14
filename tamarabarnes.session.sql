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
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE RESTRICT,
    FOREIGN KEY (walker_id) REFERENCES dog_walker(walker_id) ON DELETE RESTRICT
);
-- inserting values into bookings table
INSERT INTO bookings (
        booking_type,
        booking_date,
        booking_time,
        status,
        customer_id,
        service_id,
        walker_id
    )
VALUES (
        'Dog Walking Group',
        '2025-11-15',
        '17:00',
        'confirmed',
        3,
        2,
        1
    ),
    (
        'Dog Walking Private',
        '2025-11-13',
        '13:30',
        'awaiting',
        2,
        1,
        2
    ),
    (
        'Dog Sitting',
        '2025-11-21',
        '16:45',
        'confirmed',
        1,
        3,
        3
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
-- inserting data into payments table
INSERT INTO payments (
        payment_date,
        amount_paid,
        payment_type,
        membership_id,
        booking_id,
        customer_id
    )
VALUES ('2025-08-28', 75, 'membership', 1, NULL, 1),
    ('2024-10-20', 765, 'membership', 2, NULL, 2),
    ('2025-11-15', 15, 'booking', NULL, 1, 3);
-- QUERY A TABLE FOR A SINGLE RECORD
SELECT *
FROM payments
WHERE payment_id = 2;
-- INSERT A RECORD INTO A TABLE 
INSERT INTO payments (
        payment_date,
        amount_paid,
        payment_type,
        membership_id,
        booking_id,
        customer_id
    )
VALUES ('2025-04-15', 765, 'membership', 3, NULL, 3);
-- QUERY JOINED TABLES FOR A SINGLE RECORD
SELECT *
FROM memberships
    LEFT JOIN payments ON memberships.membership_id = payments.membership_id
WHERE memberships.membership_id = 1;
-- INSERT A RECORD INTO A TABLE WITH APPROPRIATE FOREIGN-KEY DATA
INSERT INTO bookings (
        booking_type,
        booking_date,
        booking_time,
        status,
        customer_id,
        service_id,
        walker_id
    )
VALUES (
        'Dog Walking Group',
        '2025-09-20',
        '15:00',
        'confirmed',
        1,
        2,
        3
    );
-- UPDATE A RECORD IN A TABLE
UPDATE customers
SET dob = '1994-05-14'
WHERE customer_id = 1;
-- DELETING A RECORD FROM A TABLE 
DELETE FROM bookings
WHERE booking_id = 4;
-- ORDER DATA BY A SPECIFIC VALUE
SELECT *
FROM customers
ORDER BY first_name DESC;
-- CALCULATE DATA BASED ON VALUES FROM TABLES - SUM
SELECT SUM(amount_paid)
FROM payments
WHERE customer_id = 3;
-- CALCULATING DATA BASED ON VALUES FROM TABLES - MIN
SELECT MIN(amount_paid)
FROM payments;
-- FILTERING DATA ON A SPECIFIC VALUE
SELECT customer_id,
    SUM(amount_paid) AS total_paid
FROM payments
GROUP BY customer_id
HAVING SUM(amount_paid) > 100;
-- Adding integrity checks on services table 
ALTER TABLE services
ADD CONSTRAINT check_price_pr_hr CHECK (price_per_hr > 0);
-- Adding integrity checks on customers table
ALTER TABLE customers
ADD CONSTRAINT check_dob CHECK (dob <= CURRENT_DATE);
-- Adding integtity checks for memberships table
ALTER TABLE memberships
ADD CONSTRAINT check_expiry_date CHECK (expiry_date > active_date);
-- Adding integrity checks for booking status in bookings table
ALTER TABLE bookings
ADD CONSTRAINT check_status CHECK (status IN ('confirmed', 'cancelled', 'awaiting'));
-- adding integrity checks for amount paid in payments table 
ALTER TABLE payments
ADD CONSTRAINT check_amount_paid CHECK (amount_paid > 0);
-- Adding integrity checks on payments table - ensure if payment was for memberships then membership_id is NOT NULL, if for bookings, booking_id is NOT NULL
ALTER TABLE payments
ADD CONSTRAINT check_payment_id_match CHECK (
        (
            payment_type = 'membership'
            AND membership_id IS NOT NULL
            AND booking_id IS NULL
        )
        OR (
            payment_type = 'booking'
            AND booking_id IS NOT NULL
            AND membership_id is NULL
        )
    );
-- Adding integrity checks to ensure first and last name is not empty 
ALTER TABLE customers
ADD CONSTRAINT check_first_name_not_empty CHECK (first_name <> ''),
    ADD CONSTRAINT check_last_name_not_empty CHECK (last_name <> '');
ALTER TABLE dog_walker
ADD CONSTRAINT check_first_name_not_empty CHECK (first_name <> ''),
    ADD CONSTRAINT check_last_name_not_empty CHECK (last_name <> '');
-- Adding integrity check to ensure customers email is in a valid email format 
ALTER TABLE customers
ADD CONSTRAINT check_email_format CHECK (email LIKE '%@%.%');