# Create Tables 
- I have started off by creating tables with NO foreign keys, which are the customer and services table

``` sql
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    service VARCHAR NOT NULL,
    price_per_hr NUMERIC(6, 2) NOT NULL
);
``` 