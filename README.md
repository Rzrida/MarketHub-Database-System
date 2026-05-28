# MarketHub-Database-System

# MarketHub — Online Marketplace System

## Project Overview

MarketHub is a fully relational, data-driven online marketplace system inspired by platforms such as Amazon and Daraz. The system enables buyers to browse products, manage shopping carts, place orders, make payments, and submit reviews. Sellers can manage product listings, inventory, warehouses, and sales analytics through a centralized platform.

The project is implemented using Microsoft SQL Server (T-SQL) with a web-based frontend interface.

---

# Objectives

* Design and implement a normalized relational database system for an e-commerce platform.
* Apply advanced ER modeling concepts including:

  * Specialization / Generalization
  * Weak Entities
  * Composite Attributes
  * Derived Attributes
  * Many-to-Many Relationships
* Normalize all tables to Third Normal Form (3NF).
* Implement advanced SQL concepts:

  * DDL and DML
  * Joins and Subqueries
  * GROUP BY and HAVING
  * Views
  * Triggers
  * User Defined Functions
  * Indexes and Constraints
* Develop a frontend connected with the SQL backend.

---

# Technology Stack

| Component         | Technology                         |
| ----------------- | ---------------------------------- |
| Database Engine   | Microsoft SQL Server               |
| SQL Language      | T-SQL                              |
| ER Modeling Tools | DrawSQL / ERDPlus                  |
| Backend           | Python Flask / PHP                 |
| Frontend          | HTML5, CSS3, JavaScript, Bootstrap |
| Database Tools    | SSMS / Azure Data Studio           |
| Version Control   | Git & GitHub                       |

---

# System Users

## Buyer

* Browse products
* Add products to cart
* Place orders
* Make payments
* Submit reviews
* Track order history

## Seller

* Add and update products
* Manage inventory
* Track sales
* View analytics
* Manage warehouses

## Guest

* Browse products without registration

---

# Database Design Features

## ISA Specialization

The `User` entity is specialized into:

* Buyer
* Seller

Constraints:

* Complete
* Disjoint

Every registered user must belong to exactly one subtype.

---

# Weak Entities

The following weak entities are implemented:

* ProductImage
* ProductAttribute
* CartItem
* OrderItem

---

# Many-to-Many Relationships

| Relationship        | Resolved By |
| ------------------- | ----------- |
| Cart ↔ Product      | CartItem    |
| Order ↔ Product     | OrderItem   |
| Product ↔ Warehouse | Inventory   |

---

# Derived Attributes

| Attribute          | Description            |
| ------------------ | ---------------------- |
| Order.total_amount | Sum of all order items |
| Seller.rating      | Average review rating  |

---

# Main Database Entities

* User
* Buyer
* Seller
* Address
* Category
* Subcategory
* Product
* ProductImage
* ProductAttribute
* Cart
* CartItem
* Order
* OrderItem
* Payment
* Transaction
* Shipment
* Carrier
* Warehouse
* Inventory
* Review

---

# Database Normalization

All tables are normalized up to Third Normal Form (3NF).

Normalization eliminates:

* Redundant data
* Partial dependencies
* Transitive dependencies

---

# SQL Features Implemented

## DDL

* CREATE TABLE
* ALTER TABLE
* Constraints
* Indexes

## DML

* INSERT
* UPDATE
* DELETE
* SELECT

## Advanced SQL

* INNER JOIN
* LEFT JOIN
* Subqueries
* Aggregate Functions
* GROUP BY
* HAVING

## Database Programming

* Stored Procedures
* Functions
* Triggers
* Views

---

# Business Logic

## Triggers

* Automatically reduce stock after order placement
* Prevent negative stock values

## Constraints

* Unique email addresses
* Product price must be greater than zero
* Stock cannot be negative
* One review per buyer per product
* Payment status validation

## Views

* Top-selling products
* Monthly revenue reports
* Seller dashboards
* Inventory reports

---

# Frontend Features

The frontend interface supports:

* User Registration and Login
* Product Browsing
* Cart Management
* Order Placement
* Payment Handling
* Seller Product Management
* Dashboard and Reports

Frontend technologies:

* HTML5
* CSS3
* JavaScript
* Bootstrap

---

# Functional Requirements

| Module          | Features                                |
| --------------- | --------------------------------------- |
| User Management | Registration, Login, Address Management |
| Product Catalog | Product Listings, Categories, Search    |
| Shopping Cart   | Add, Remove, Update Cart Items          |
| Orders          | Multi-product Orders                    |
| Payments        | Payment and Transaction Tracking        |
| Inventory       | Warehouse Stock Management              |
| Reviews         | Product Ratings and Reviews             |
| Analytics       | Revenue and Sales Reports               |

---


# ER Diagram


![Uploading Screenshot 2026-05-28 at 4.49.31 PM.png…]()


---

# Relational Schema
![Uploading Screenshot 2026-05-28 at 4.49.56 PM.png…]()

---

# Future Improvements

* Admin dashboard
* Recommendation system
* Payment gateway integration
* Product wishlist
* REST API support
* AI-based recommendations

---

# Learning Outcomes

This project demonstrates:

* Relational database design
* Advanced SQL programming
* Normalization techniques
* Database constraints and triggers
* Backend integration
* Real-world e-commerce modeling

---

