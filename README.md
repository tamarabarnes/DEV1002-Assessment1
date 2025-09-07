# Dog walking/services platform 
- For my database project, I have chosen to create a relational database based on a dog walking/services plaform.
- This platform allows users to book in private or group dog walks with dog walkers, as well as dog sitting services. 
- Users can either pay as they book services OR pay a monthly membership and book as many services as they want

# Tables in my database 
- The tables in my dog walking/services database are
-- customers
-- dog walker 
-- services 
-- bookings
-- payments
-- memberships

# Relationship between tables

# Create Tables 
- I have started off by creating tables with NO foreign keys, which are the customer and services table

``` sql
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    service VARCHAR NOT NULL,
    price_per_hr NUMERIC(6, 2) NOT NULL
);
``` 