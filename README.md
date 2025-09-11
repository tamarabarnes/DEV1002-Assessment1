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

# Soft Delete for customers 
- I have chosen to implement soft deletes rather than permanently deleting customer records. This ensures that even if a customer deletes their account, their details remain in the system for any previous bookings and payment information. It also allows for the recovery of customer information if they decide to restore their account later.

# Constraints for foreign keys
For the foreign keys in the memberships, payments, and bookings tables, I have set the constraint as ON DELETE RESTRICT. This ensures that related records cannot be removed if someone accidentally attempts a hard delete on a parent record. This aligns with the use of soft deletes (deleted_at), since historical data (such as bookings and payments) should always be preserved.

## example of constraint added on foreign key 
``` sql
CREATE TABLE memberships (
    membership_id SERIAL PRIMARY KEY,
    account_name VARCHAR(100) NOT NULL,
    active_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    customer_id INTEGER NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT
);
```

# ERD for Database
![ERD Diagram for Dog walking/services app](<DEV1002 Assessment 1 ERD.drawio.png>)

# Create Tables 
- I have started off by creating tables with NO foreign keys, which are the customer and services table

``` sql
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    service VARCHAR NOT NULL,
    price_per_hr NUMERIC(6, 2) NOT NULL
);
``` 
# inserting tables 
- For all my tables, I did not insert values for the ID columns because they are auto-populated by PostgreSQL using SERIAL.

- For the deleted_at column in the customers table, it is set to DEFAULT NULL, so I did not insert any values. This is because all customers added are active, and NULL indicates that the customer has not been deleted.

# QUERY JOINED TABLES FOR A SINGLE RECORD
- For this requirement —> query joined tables for a single record, I chose to join the memberships and payments tables. I used a LEFT JOIN, which extracts all rows from the left table (memberships) and matches them with corresponding rows in the payments table. If there is no matching payment, the columns from the payments table will display as NULL. This ensures that I always get a record from the memberships table, regardless of whether there is corresponding data in the payments table.

``` sql
SELECT *
FROM memberships
    LEFT JOIN payments ON memberships.membership_id = payments.membership_id
WHERE memberships.membership_id = 1;
```