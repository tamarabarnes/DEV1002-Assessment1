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