USE proudpinoydb;


-- ==============================
-- Use case 1, Step 4
-- Use case 2, Step 2: The same procedure can be used for use case 2, step 2.
-- Use case 7, Step 4: The same procedure can be used for use case 7, step 4.
-- Update inventory stock after sale
-- ==============================
DELIMITER $$
DROP PROCEDURE IF EXISTS Update_Inventory_Through_Sale $$
CREATE PROCEDURE Update_Inventory_Through_Sale (
IN P_TransactionID INT)
BEGIN
UPDATE Product set StockQuantity = StockQuantity - 
(SELECT Quantity FROM TransactionItem WHERE TransactionID = P_TransactionID AND ProductID = Product.ProductID)
WHERE ProductID IN (SELECT ProductID FROM TransactionItem WHERE TransactionID = P_TransactionID);
    END $$
    DELIMITER ;

-- Query/Testing:
-- Step 1: Capture stock quantities before the update
SELECT ProductID, Name, StockQuantity AS Before_StockQuantity
FROM Product
WHERE ProductID IN (SELECT ProductID FROM TransactionItem WHERE TransactionID = @T_ID);

-- Step 2: Call the procedure to update stock quantities
SET @T_ID = 10;  -- Example Transaction ID
CALL Update_Inventory_Through_Sale (@T_ID);

-- Step 3: Capture stock quantities after the update
SELECT ProductID, Name, StockQuantity AS After_StockQuantity
FROM Product
WHERE ProductID IN (SELECT ProductID FROM TransactionItem WHERE TransactionID = @T_ID);

-- ==============================
-- Use case 1, Step 5
-- Record transaction log
-- ==============================
INSERT INTO TRANSACTION (TransactionDate, TotalAmount, PaymentMethod, EmployeeID) 
VALUES (NOW(), 7, 'Credit Card', 1);
SET @TRANSACTION_ID = LAST_INSERT_ID ();

-- Query 1 (The transaction gets added to the transaction log):
SELECT * FROM Transaction;

-- ==============================
-- Use case 2, Step 1
-- Receive shipment
-- ==============================
DELIMITER $$
DROP PROCEDURE IF EXISTS ReceiveShipment $$
CREATE PROCEDURE ReceiveShipment (
IN P_ProductID INT,
IN P_Quantity INT,
IN Shipment_OrderID INT)
BEGIN
START TRANSACTION;
UPDATE ShipmentOrder set DateReceived = CURDATE(), `Status` = 'Received' WHERE ShipmentOrderID = 
Shipment_OrderID;
UPDATE Product SET StockQuantity = StockQuantity + P_Quantity WHERE ProductID = P_ProductID;
	COMMIT; 
    END $$
    DELIMITER ;

-- Query/Test:
-- Step 1: Capture stock quantity before the update (before receiving shipment)
SELECT ProductID, Name, StockQuantity AS Before_StockQuantity
FROM Product
WHERE ProductID = @P_ID;

-- Step 2: Call the procedure to update the stock quantity (receive shipment)
SET @P_ID = 10;           -- Example Product ID
SET @Q = 100;             -- Example Quantity received
SET @ShID = 8;            -- Example Shipment Order ID
CALL ReceiveShipment(@P_ID, @Q, @ShID);

-- Step 3: Capture stock quantity after the update (after receiving shipment)
SELECT ProductID, Name, StockQuantity AS After_StockQuantity
FROM Product
WHERE ProductID = @P_ID;

-- ==============================
-- Use case 2, Step 3
-- Low stock alert
-- ==============================
DELIMITER $$
DROP TRIGGER IF EXISTS Low_Stock_Alert;
CREATE TRIGGER Low_Stock_Alert AFTER UPDATE ON Product
FOR EACH ROW 
BEGIN
IF NEW.StockQuantity < 20 THEN 
INSERT INTO LowStockAlert (ProductID, CurrentStock, AlertDate, Status) 
	VALUES (New.ProductID, New.StockQuantity, NOW(), 'Open');
END IF;
    END $$
    DELIMITER ;
    
-- Query/Test:
SELECT * FROM LowStockAlert;

-- ==============================
-- Use case 2, Step 4
-- Inventory and discrepency report
-- ==============================
-- Inventory Report:
SELECT * FROM Product;

-- Discrepency Report:
DELIMITER $$
DROP PROCEDURE IF EXISTS Discrepency_Report $$
CREATE PROCEDURE Discrepency_Report (
IN Product_ID INT,
IN Quantity INT)
BEGIN
DECLARE Inventory_Quantity INT;
SELECT StockQuantity INTO Inventory_Quantity FROM Product WHERE ProductID = Product_ID;
SELECT Inventory_Quantity - Quantity;
END $$
-- Query/Test (Discrepency Report):
SET @P_ID = 1;
SET @Q = 1000;
CALL Discrepency_Report (@P_ID, @Q);

-- ==============================
-- Use case 3 - Step 1 
-- Trigger for Regular Price Review (Weekly)  ---This trigger will run every week to 
										       -- remind the store manager to review product prices.
-- ==============================

DROP EVENT IF EXISTS WeeklyPriceReview;

CREATE EVENT WeeklyPriceReview
ON SCHEDULE EVERY 1 WEEK
STARTS '2024-11-20 00:00:00'
DO
    -- Select a Manager's EmployeeID (you might need to adjust the logic here)
    SET @employee_id = (SELECT EmployeeID FROM Employee WHERE Role = 'Manager' LIMIT 1); 

    -- Insert a reminder into the PricingLog table with the selected ManagerID
    INSERT INTO PricingLog (ProductID, OldPrice, NewPrice, ChangeDate, EmployeeID, Message)
    VALUES (NULL, 0.00, 0.00, NOW(), @employee_id, 'Time to review product pricing for the week');
    
    
   
-- Query/Test 
-- Confirm the event ran
SHOW EVENTS LIKE 'WeeklyPriceReview';

-- Check the PricingLog for a new entry inserted by the event
SELECT * FROM PricingLog WHERE Message = 'Time to review product pricing for the week';


-- ==============================
-- Use case 3 -- Step 4 -- Promotional sales events
-- Trigger for Launch of Promotional Sale Events  ---This trigger will activate when a new 
-- promotional sale event starts and notify the system to apply relevant discounts.
-- ==============================

DELIMITER $$
DROP TRIGGER IF EXISTS AfterSaleStart;
CREATE TRIGGER AfterSaleStart
AFTER INSERT ON Promotion
FOR EACH ROW
BEGIN
    -- Apply discounts and update pricing in the system
    UPDATE Product
    SET Price = Price * (1 - NEW.DiscountPercentage / 100)
    WHERE ProductID IN (SELECT ProductID FROM PromotionProduct WHERE PromotionID = NEW.PromotionID); 
END $$
DELIMITER ;

-- Test/Query: Check if product prices are updated
SELECT ProductID, Price FROM Product WHERE ProductID IN (1, 2);

-- ==============================
-- Use case 3 -- Step 3  -- Procedure for Adjusting Product Prices 
-- This procedure allows the store manager to adjust product prices based on cost and profit margin.
-- ==============================

DELIMITER $$
DROP PROCEDURE IF EXISTS AdjustProductPrice;

-- Assuming you'll add a MinPrice column to the Category table--------------------------------------------------------------------------------------...mlm,m
DELIMITER $$
CREATE PROCEDURE AdjustProductPrice(
    IN p_ProductID INT, 
    IN p_NewPrice DECIMAL(10, 2)
)
BEGIN
    DECLARE v_MinPrice DECIMAL(10, 2);

    -- Fetch the minimum allowable price from the Category table
    SELECT c.MinPrice INTO v_MinPrice 
    FROM Product p
    JOIN Product_Category pc ON p.ProductID = pc.ProductID
    JOIN Category c ON pc.CategoryID = c.CategoryID
    WHERE p.ProductID = p_ProductID;

    IF p_NewPrice < v_MinPrice THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price too low. Please adjust.';
    ELSE
        -- Update the product price
        UPDATE Product SET Price = p_NewPrice WHERE ProductID = p_ProductID;

        -- Record the price change in the PricingLog (replace with your logic to get ManagerID)
        INSERT INTO PricingLog (ProductID, OldPrice, NewPrice, ChangeDate, EmployeeID)
        VALUES (p_ProductID, (SELECT Price FROM Product WHERE ProductID = p_ProductID), p_NewPrice, NOW(), /* Replace with session variable or function to get ManagerID */ 1);
    END IF;
END $$
DELIMITER ; 

-- Test/Query 
-- Call the stored procedure with a valid new price
CALL AdjustProductPrice(1, 7.00); 

-- Check the Product table to see if the price has been updated:

SELECT * FROM Product WHERE ProductID IN (1, 2);

-- ==============================
-- Use case 4, Step 1
-- Display low stock items (a.k.a items that got low stock alerts)
-- ==============================
SELECT * FROM LowStockAlert WHERE Status = 'Open';

-- ==============================
-- Use case 4, Steps 2-4
-- Order low stock items
-- ==============================
DELIMITER $$
DROP PROCEDURE IF EXISTS Order_Supplies $$
CREATE PROCEDURE Order_Supplies (
IN S_ID INT,
IN Amount DECIMAL(10,2),
IN PaymentType VARCHAR (20),
IN P_ID INT
)
BEGIN 
DECLARE ShipmentOrderID INT;
DECLARE Payment_ConfirmationID INT;
INSERT INTO ShipmentOrder (SupplierID, Status) 
VALUES (S_ID, 'Shipment Pending');
Set ShipmentOrderID = LAST_INSERT_ID ();
INSERT INTO Payment (TransactionID, PaymentDate, AmountPaid, PaymentMethod)
VALUES (ShipmentOrderID, NOW(), Amount, PaymentType);
UPDATE LowStockAlert SET Status = 'Closed' WHERE ProductID = P_ID;
SET Payment_ConfirmationID = LAST_INSERT_ID ();
SELECT ShipmentOrderID, Payment_ConfirmationID;
END $$
DELIMITER ;

-- Query Use Case 4
SET @S_ID = 2;
SET @Amount = 1200;
SET @Pay_Type = 'Credit Card';
SET @P_ID = 1;
CALL Order_Supplies (@S_ID, @Amount, @Pay_Type, @P_ID);

-- ==============================
-- Use case 5 -- Step 1 -- Procedure for Generating Sales Reports
-- This procedure generates a weekly sales report.
-- ==============================
DROP PROCEDURE IF EXISTS GenerateSalesReport;

DELIMITER $$

CREATE PROCEDURE GenerateSalesReport(
    IN p_StartDate DATE,
    IN p_EndDate DATE,
    IN p_EmployeeID INT 
)
BEGIN
    -- Check if the EmployeeID belongs to a Manager
    DECLARE is_manager INT;
    SELECT COUNT(*) INTO is_manager FROM Employee WHERE EmployeeID = p_EmployeeID AND Role = 'Manager';

    -- Only proceed if the EmployeeID is a Manager
    IF is_manager > 0 THEN
        -- Insert a new record into SalesReport
        INSERT INTO SalesReport (EmployeeID, StartDate, EndDate, DateGenerated)
        VALUES (p_EmployeeID, p_StartDate, p_EndDate, NOW());

        -- Get the ID of the newly created report
        SET @ReportID = LAST_INSERT_ID();

        -- Insert sales data into SalesReportDetail
        INSERT INTO SalesReportDetail (ReportID, ProductID, QuantitySold, TotalRevenue)
        SELECT 
            @ReportID,
            ti.ProductID,
            SUM(ti.Quantity),
            SUM(ti.Price * ti.Quantity)
        FROM TransactionItem ti
        JOIN Transaction t ON ti.TransactionID = t.TransactionID
        WHERE t.TransactionDate BETWEEN p_StartDate AND p_EndDate
        GROUP BY ti.ProductID;
    ELSE
        -- Raise an error or signal that the user is not authorized
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only managers can generate sales reports.';
    END IF;
END $$

DELIMITER ;

-- Testing
SELECT EmployeeID FROM Employee WHERE Role = 'Manager' LIMIT 1; 
CALL GenerateSalesReport('2024-11-18', '2024-11-24', 7); -- Replace 7 with the actual EmployeeID
-- Check the SalesReport table if it has been updated. 
SELECT * 
FROM SalesReport 
ORDER BY ReportID DESC;  -- Order by ReportID in descending order to see the latest report first

-- Test with a Non-Manager (No access) -> You should be receiveing an error because it 
-- demonstrates that non-managers do not have access.
CALL GenerateSalesReport('2024-11-18', '2024-11-24', 2); -- Replace 2 with the actual EmployeeID


-- ==============================
-- Use case 5 -- Trigger -- Step 1 -- For Weekly Sales Report Generation
-- This trigger will execute at the end of the business week to generate sales reports.
-- ==============================
DELIMITER $$

DROP EVENT IF EXISTS GenerateWeeklySalesReport;

CREATE EVENT GenerateWeeklySalesReport
ON SCHEDULE EVERY 1 WEEK
STARTS '2024-12-04 23:59:59'
DO
  CALL GenerateSalesReport(NOW() - INTERVAL 1 WEEK, NOW());

$$
DELIMITER ;

SHOW EVENTS LIKE 'GenerateWeeklySalesReport';

-- Shows Salesreport is updated    
SELECT * FROM SalesReport;



-- ==============================
-- Use case 6 -- Trigger -- For End of Payroll Period
-- Trigger for End of Payroll Period.
-- ==============================

DELIMITER $$
DROP EVENT IF EXISTS EndOfPayrollPeriod;

CREATE EVENT EndOfPayrollPeriod
ON SCHEDULE EVERY 2 WEEK
STARTS '2024-11-23 23:59:59'
DO
  CALL CalculatePayroll();

$$
DELIMITER ;
-- The testing query for this event is under 'use case 6 -- step 3' as it also shows the EndofPayrollPeriod.

-- ==============================
-- Use case 6 -- Step 3 -- Procedure for Calculating Payroll
-- This procedure calculates payroll based on worked hours and employee pay rates, including overtime.
-- ==============================
DELIMITER $$

DROP PROCEDURE IF EXISTS CalculatePayroll $$

CREATE PROCEDURE CalculatePayroll()
BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE employee_id INT;
   DECLARE worked_hours DECIMAL(10, 2);
   DECLARE pay_rate DECIMAL(10, 2);
   DECLARE total_pay DECIMAL(10, 2);
   DECLARE overtime_rate DECIMAL(10, 2);
   
   -- Declare a cursor to fetch employee data
   DECLARE cur CURSOR FOR 
     SELECT ew.EmployeeID, SUM(TIMESTAMPDIFF(HOUR, ew.ClockInTime, ew.ClockOutTime)) AS TotalHours, e.PayRate
     FROM EmployeeHours ew
     JOIN Employee e ON ew.EmployeeID = e.EmployeeID
     GROUP BY ew.EmployeeID;

   -- Declare a handler for the end of the cursor
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

   -- Open the cursor
   OPEN cur;

   -- Loop through the cursor rows
   read_loop: LOOP
     FETCH cur INTO employee_id, worked_hours, pay_rate;

     -- Exit the loop if no more rows
     IF done THEN
       LEAVE read_loop;
     END IF;
     
     -- Calculate total pay
     SET total_pay = worked_hours * pay_rate;
     
     -- Add overtime pay if applicable
     IF worked_hours > 40 THEN
       SET overtime_rate = pay_rate * 1.5;
       SET total_pay = total_pay + ((worked_hours - 40) * overtime_rate);
     END IF;
     
     -- Insert calculated payroll data into the Payroll table
     INSERT INTO Payroll (EmployeeID, TotalPay, PayPeriodStart, PayPeriodEnd)
     VALUES (employee_id, total_pay, CURDATE() - INTERVAL 1 WEEK, CURDATE());
   END LOOP;

   -- Close the cursor
   CLOSE cur;
END $$

DELIMITER ;

-- Check the Payroll table for the results
SELECT * FROM Payroll;


-- ==============================
-- Use case 7, Steps 1-2
-- Procedure #1: receieving phone order
-- ==============================
DELIMITER $$
DROP PROCEDURE IF EXISTS Phone_Order $$

CREATE PROCEDURE Phone_Order (
    IN C_ID INT,  -- CustomerID
    IN P_ID INT,  -- ProductID
    IN INPUT_Quantity INT  -- Quantity of the product
)
BEGIN 
    DECLARE Available INT;
    DECLARE Product_Price DECIMAL(10,2);
    DECLARE PhoneOrderID INT;

    -- Insert a new order for the customer with a 'Pending' status and PickupDate set to 1 day after the current date
    INSERT INTO PhoneOrders (CustomerID, OrderDate, PickupDate, Status) 
    VALUES (C_ID, NOW(), NOW() + INTERVAL 1 DAY, 'Pending');

    -- Get the PhoneOrderID of the newly inserted order
    SET PhoneOrderID = LAST_INSERT_ID ();

    -- Retrieve available stock and price for the product
    SELECT StockQuantity, Price INTO Available, Product_Price 
    FROM Product WHERE ProductID = P_ID;

    -- Check if there is enough stock for the requested quantity
    IF Available >= INPUT_Quantity THEN 
        -- Insert the product into the PhoneOrderItem table (tracks the products in this order)
        INSERT INTO PhoneOrderItem (PhoneOrderID, ProductID, Quantity, Price) 
        VALUES (PhoneOrderID, P_ID, INPUT_Quantity, Product_Price);

        -- Update the stock quantity for the product in the Product table
        UPDATE Product SET StockQuantity = StockQuantity - INPUT_Quantity 
        WHERE ProductID = P_ID;
    ELSE 
        -- If there is not enough stock, cancel the order
        UPDATE PhoneOrders SET Status = 'Cancelled' WHERE PhoneOrderID = PhoneOrderID;
    END IF;

    -- Return the PhoneOrderID of the new order
    SELECT PhoneOrderID;
END $$

DELIMITER ;

-- Testing Phone_Order
CALL Phone_Order(1, 1, 2);  -- CustomerID 1, ProductID 1, Quantity 2

-- ==============================
-- Use case 7, Step 3
-- Procedure #2: This Procdeure updates the order was picked Up
-- ==============================
DELIMITER $$

DROP PROCEDURE IF EXISTS Update_Order_Status $$

CREATE PROCEDURE Update_Order_Status (
    IN PhoneOrderID INT,  -- The order ID
    IN Status VARCHAR(20)  -- The new status of the order (e.g., 'Completed' or 'Cancelled')
)
BEGIN
    -- Update the order status
    UPDATE PhoneOrders 
    SET Status = Status 
    WHERE PhoneOrderID = PhoneOrderID;

    -- Return the updated order details
    SELECT PhoneOrderID, Status;
END $$

DELIMITER ;

-- Testing the Update_Order_Status procedure
SET SQL_SAFE_UPDATES = 0;
CALL Update_Order_Status(1, 'Completed');
SET SQL_SAFE_UPDATES = 1;
-- Verifying the update
SELECT * FROM PhoneOrders WHERE PhoneOrderID = 1;

-- ==============================
-- Use Case 7, Step 3 -> IF statement (cancel after 2 days if customer doesn't pick up)
-- Procedure #3
-- ==============================
DELIMITER $$

DROP PROCEDURE IF EXISTS Cancel_Pickup_Order_After_2_Days $$

CREATE PROCEDURE Cancel_Pickup_Order_After_2_Days()
BEGIN
    -- Update the status of orders that are more than 2 days old and still 'Pending'
    UPDATE PhoneOrders
    SET Status = 'Cancelled'
    WHERE DATEDIFF(CURDATE(), OrderDate) > 2
    AND Status = 'Pending';
    
    --  add a SELECT statement to confirm which orders were updated
    SELECT PhoneOrderID, CustomerID, PickupDate, Status
    FROM PhoneOrders
	WHERE DATEDIFF(CURDATE(), OrderDate) > 2
    AND Status = 'Cancelled';
END $$

DELIMITER ;

-- run Query 
SET SQL_SAFE_UPDATES = 0;
CALL Cancel_Pickup_Order_After_2_Days();
SET SQL_SAFE_UPDATES = 1;








