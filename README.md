# BookStore Database Management System

## Overview
This project implements a comprehensive MySQL database solution for bookstore management. The system efficiently organizes and manages critical bookstore operations including inventory, customer data, and order processing. Designed with scalability in mind, it maintains complex relationships between entities while enforcing strict data integrity and security through role-based access control.

## Database Schema
The relational database comprises 15 interconnected tables structured into three main components:

### Core Inventory Tables
| Table | Description |
|-------|-------------|
| `book` | Stores book metadata including title, price, and publication date |
| `author` | Maintains author information |
| `book_author` | Junction table resolving many-to-many book-author relationships |
| `publisher` | Contains publisher details |
| `book_language` | Tracks available language options |

### Customer Management
| Table | Description |
|-------|-------------|
| `customer` | Central customer repository with contact details |
| `address` | Physical address storage |
| `customer_address` | Links customers to addresses with status tracking |
| `country` | Reference table for supported countries |
| `address_status` | Defines address states (current/old) |

### Order Processing System
| Table | Description |
|-------|-------------|
| `cust_order` | Master order records |
| `order_line` | Line items for each order |
| `shipping_method` | Available delivery options |
| `order_status` | Order lifecycle states |
| `order_history` | Complete order status audit trail |

## Installation & Setup
1. **Database Initialization**:
   ```bash
   mysql -u root -p < BookStore.sql