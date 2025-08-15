# Grocery POS & Inventory Database (SQL)

End-to-end SQL project for a grocery store’s POS and inventory operations. Includes a normalized schema (ERD), stored procedures for phone orders (receive/pickup/cancel), triggers for inventory updates & audit, and reporting queries (weekly sales, low stock, top products). Demo uses synthetic data.

**Tech:** SQL (**POSTGRESQL / MYSQL / SQL SERVER — PICK ONE**)

---

## Quickstart

1) **Create a database**
2) **Run in this order**
   
   - **PostgreSQL (psql)**
    
 
psql -d grocery_pos -f "Schema-ProudPinoy.sql"

psql -d grocery_pos -f "Data Insertion-ProudPinoy.sql"

psql -d grocery_pos -f "Procedures_Triggers_Queries-ProudPinoy.sql"

     
   - **MySQL**
     
     
mysql -e "CREATE DATABASE grocery_pos;"

mysql grocery_pos < "Schema-ProudPinoy.sql"

mysql grocery_pos < "Data Insertion-ProudPinoy.sql"

mysql grocery_pos < "Procedures_Triggers_Queries-ProudPinoy.sql"

  **SQL Server (sqlcmd)**
  
sqlcmd -S localhost -E -Q "IF DB_ID('grocery_pos') IS NULL CREATE DATABASE grocery_pos;"

sqlcmd -S localhost -E -d grocery_pos -i "Schema-ProudPinoy.sql"

sqlcmd -S localhost -E -d grocery_pos -i "Data Insertion-ProudPinoy.sql"

sqlcmd -S localhost -E -d grocery_pos -i "Procedures_Triggers_Queries-ProudPinoy.sql"



**Quick check after running:**

Postgres/MySQL: SELECT * FROM products LIMIT 5;

SQL Server: SELECT TOP 5 * FROM products;

