# Dog walking/services platform 
- For my database project, I have chosen to create a relational database based on a dog walking/services plaform.
- This platform allows users to book in private or group dog walks with dog walkers, as well as dog sitting services. 
- Users can either pay as they book services OR pay a monthly membership and book as many services as they want

# Tables in my database 
- The tables in my dog walking/services database are, customers, dog walker, services, bookings, payments, memberships

# Relationship between tables
- The Customer, Dog_Walker, and Services tables have no foreign keys and are independent. 
- The Memberships table has customer_id as a foreign key. A customer can have many memberships over time (e.g. if customer has monthly memberships), and each membership belongs to a single customer. Therefore, the Customer and Memberships tables have a one-to-many relationship.
- The payments table has 3 foreign keys, memership_id, booking_id and customer_id. A membership can have ONE or MANY payments and a payment is linked to only ONE membership. therefore the membership and payments table is a ONE to MANY relationship. One booking can have one payment and one payment can only be associated with one booking so this is a one to one relationship. A customer can have many payments and one payment can only be associated with one customer, so this is a one to many relationship. 
- The bookings table has 3 foreign keys customer_id, service_id and walker_id. A customer can have many bookings at a time and one booking can only be associated with one customer, so this is a one to many relationship. A service can be associated with many bookings, for example multiple customers booking in for a group dog service, and a booking can only be associated with one service, so this is a one to many relationship. A walker can be tied to many bookings, for example, if they are handling group dog walks or dog sitting sessions, and one booking is associated with one dog walker, therefore this is a one to many relationship. 
- 

# Create Tables 
- I have started off by creating tables with NO foreign keys, which are the customer and services table

``` sql
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    service VARCHAR NOT NULL,
    price_per_hr NUMERIC(6, 2) NOT NULL
);
``` 