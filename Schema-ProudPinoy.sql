DROP SCHEMA proudpinoydb;
CREATE SCHEMA proudpinoydb   
CHARACTER SET = utf8mb4 
  COLLATE = utf8mb4_0900_ai_ci;
USE proudpinoydb;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

-- Set SQL Mode for consistent behavior
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- ==============================
-- SECTION   
 -- 1: CUSTOMER MANAGEMENT
-- Tables related to customer data and their interactions
-- ==============================
-------------------------------------------------
-- Create the 'Customers' table to store customer information


CREATE TABLE `Customer` (
  `CustomerID` INT AUTO_INCREMENT,
  `FirstName` VARCHAR(100) NOT NULL,
  `LastName` VARCHAR(100)NOT NULL,
  `PhoneNumber` VARCHAR(15) UNIQUE,
  `Email` VARCHAR(100),
  PRIMARY KEY (`CustomerID`)

);

-- Create the 'Products' table to store product information

CREATE TABLE `Product` (
  `ProductID` INT AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Description` TEXT,
  `Price` DECIMAL(10,2) NOT NULL,
  `StockQuantity` INT DEFAULT 0,
  `Barcode` VARCHAR(20) UNIQUE,
  PRIMARY KEY (`ProductID`)
  
);

-- Store customer phone orders 

CREATE TABLE `PhoneOrders` (
  `PhoneOrderID` INT AUTO_INCREMENT,
  `CustomerID` INT,
  `OrderDate` DATETIME NOT NULL ,
  `PickupDate` DATETIME NOT NULL,
  `Status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`PhoneOrderID`),
  FOREIGN KEY (`CustomerID`) REFERENCES `Customer`(`CustomerID`) ON DELETE CASCADE ,   
  INDEX idx_phoneorders_customerid (`CustomerID`) 
);  

-- Create the 'PhoneOrderitem' table to store details about each product in an order

CREATE TABLE `PhoneOrderItem` (
  `PhoneOrderItemID` INT AUTO_INCREMENT,
  `PhoneOrderID` INT,
  `ProductID` INT,
  `Quantity` INT NOT NULL,
  `Price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`PhoneOrderItemID`),
  FOREIGN KEY (`PhoneOrderID`) REFERENCES `PhoneOrders`(`PhoneOrderID`) ON DELETE CASCADE ,
  FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`) ON DELETE CASCADE ,
   INDEX idx_phoneorderitem_phoneorderid (`PhoneOrderID`),  -- Index for performance
  INDEX idx_phoneorderitem_productid (`ProductID`)  -- Index for performance
);

------------------------------------ 
-- SECTION 2: PRODUCT MANAGEMENT
-- Tables related to products, categories, and inventory
------------------------------------- 


-- Organize products into categories


CREATE TABLE `Category` (
  `CategoryID` INT AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Description` TEXT,
MinPrice DECIMAL(10,2) NOT NULL,               
  PRIMARY KEY (`CategoryID`)
);

-- Link products to categories

CREATE TABLE `Product_Category` (
  `ProductID` INT NOT NULL,
  `CategoryID` INT NOT NULL,
  PRIMARY KEY (`ProductID` ,`CategoryID`),
  FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`) ON DELETE CASCADE, 
  FOREIGN KEY (`CategoryID`) REFERENCES `Category`(`CategoryID`) ON DELETE CASCADE , 
   INDEX idx_product_category_productid (`ProductID`),
  INDEX idx_product_category_categoryid (`CategoryID`)
);



-- Track inventory changes (for auditing)

CREATE TABLE `InventoryLog` (
  `LogID` INT AUTO_INCREMENT,
  `ProductID` INT,
  `ChangeType`ENUM('Incoming', 'Outgoing', 'Adjustment') NOT NULL, --  Use ENUM for controlled values
  `QuantityChange` INT  NOT NULL,
  `LogDate` DATETIME  NOT NULL,
  `EmployeeID` INT, -- To track who made the inventory change 
  PRIMARY KEY (`LogID`),
FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`) ON DELETE CASCADE ,
FOREIGN KEY (`EmployeeID`) REFERENCES `Employee`(`EmployeeID`) ON DELETE SET NULL ,
  INDEX idx_inventorylog_productid (`ProductID`)  -- Index for performance


  
);

-- Manage low-stock alerts

CREATE TABLE `LowStockAlert` (
  `StockAlertID` INT AUTO_INCREMENT,
  `ProductID` INT,
  `CurrentStock` INT NOT NULL ,
  `AlertDate` DATETIME NOT NULL ,
  `Status` VARCHAR(20),
  PRIMARY KEY (`StockAlertID`),
FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`) ON DELETE CASCADE ,
  INDEX idx_lowstockalert_productid (`ProductID`)  -- Index for performance

 
);

-- ==============================
-- SECTION 3: TRANSACTION MANAGEMENT
-- Tables related to customer purchases and payments
-- ==============================

-- Store transaction details (point-of-sale transactions)

CREATE TABLE `Transaction` (
  `TransactionID` INT AUTO_INCREMENT,
  `CustomerID` INT,
  `TransactionDate` DATETIME NOT NULL,
  `TotalAmount` DECIMAL(10,2) NOT NULL,
 `PaymentMethod` ENUM ('Credit Card', 'Debit Card',  'Cash') NOT NULL,
 `EmployeeID` INT,
 
  PRIMARY KEY (`TransactionID`),
  FOREIGN KEY (`CustomerID`) REFERENCES `Customer`(`CustomerID`) ON DELETE CASCADE ,
  FOREIGN KEY (`EmployeeID`) REFERENCES `Employee`(`EmployeeID`) ON DELETE SET NULL ,
    INDEX idx_transaction_customerid (`CustomerID`)  -- Index for performance

);

-- Store details of items in a transaction

CREATE TABLE `TransactionItem` (
  `TransactionItemID` INT AUTO_INCREMENT,
  `TransactionID` INT,
  `ProductID` INT,
  `Quantity` INT NOT NULL ,
  `Price` DECIMAL(10,2) NOT NULL ,
  PRIMARY KEY (`TransactionItemID`),
  FOREIGN KEY (`TransactionID`) REFERENCES `Transaction`(`TransactionID`) ON DELETE CASCADE,
  FOREIGN KEY (`ProductID`) REFERENCES `Product` (`ProductID`) ON DELETE CASCADE ,
  INDEX idx_transactionitem_transactionid (`TransactionID`),  -- Index for performance
  INDEX idx_transactionitem_productid (`ProductID`)  -- Index for performance

);


-- ==============================
-- SECTION 4: EMPLOYEE AND PAYROLL MANAGEMENT
-- Tables related to employees, their schedules, and payroll
-- ==============================

-- Store employee details

CREATE TABLE `Employee` (
    `EmployeeID` INT AUTO_INCREMENT,
    `FirstName` VARCHAR(100) NOT NULL,
    `LastName` VARCHAR(100) NOT NULL,
    `Role` VARCHAR(50) NOT NULL,
    `PayRate` DECIMAL(10,2) NOT NULL,
    `ManagerID` INT, -- Add ManagerID as a foreign key
PRIMARY KEY (`EmployeeID`) ,
FOREIGN KEY (`ManagerID`) REFERENCES `Employee`(`EmployeeID`) ON DELETE SET NULL -- Self-referencing foreign key

);



-- Manage employee schedules

CREATE TABLE `Schedule` (
  `ScheduleID` INT AUTO_INCREMENT,
  `EmployeeID` INT,
  `WorkDate` DATE NOT NULL ,
  `StartTime` TIME NOT NULL ,
  `EndTime` TIME NOT NULL ,
  `Status` VARCHAR(20),
  PRIMARY KEY (`ScheduleID`),
  FOREIGN KEY (`EmployeeID`) REFERENCES `Employee`(`EmployeeID`)  ON DELETE CASCADE,
    INDEX idx_schedule_employeeid (`EmployeeID`)  -- Index for performance

);

-- Record payroll information

CREATE TABLE `Payroll` (
  `PayrollID` INT AUTO_INCREMENT,
  `EmployeeID` INT,
  `PayPeriodStart` DATE NOT NULL ,
  `PayPeriodEnd` DATE NOT NULL,
  `TotalHours` DECIMAL(6,2)  NULL,
  `TotalPay` DECIMAL(10,2) NOT NULL,
  `Status` VARCHAR(50) NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`PayrollID`),
  FOREIGN KEY (`EmployeeID`) REFERENCES `Employee`(`EmployeeID`)  ON DELETE CASCADE
);


-- Track employee work hours

CREATE TABLE `EmployeeHours` (
    `EmployeeHoursID` INT AUTO_INCREMENT,
    `EmployeeID` INT,
    `ScheduleID` INT,
    `ClockInTime` DATETIME NOT NULL,
    `ClockOutTime` DATETIME, 
    PRIMARY KEY (`EmployeeHoursID`),
    FOREIGN KEY (`EmployeeID`) REFERENCES `Employee`(`EmployeeID`) ON DELETE CASCADE,
    FOREIGN KEY (`ScheduleID`) REFERENCES `Schedule`(`ScheduleID`) ON DELETE CASCADE
    
);


-- ==============================
-- SECTION 5: SUPPLIER AND SHIPMENT MANAGEMENT
-- Tables related to suppliers and incoming shipments
-- ==============================


CREATE TABLE `Supplier` (
  `SupplierID` INT AUTO_INCREMENT,
  `SupplierName` VARCHAR(100) NOT NULL,
  `ContactNumber` VARCHAR(15),
  `Email` VARCHAR(100) UNIQUE,
  `Address` VARCHAR(100),
  PRIMARY KEY (`SupplierID`)
);

-- Create the Supplier_Product table to link suppliers and products
CREATE TABLE Supplier_Product (
    SupplierID INT,
    ProductID INT,
    PRIMARY KEY (SupplierID, ProductID),  -- Composite Primary Key
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE,  
    INDEX idx_supplier_product_supplierid (SupplierID),  
    INDEX idx_supplier_product_productid (ProductID)   
);


CREATE TABLE `ShipmentOrder` (
  `ShipmentOrderID` INT AUTO_INCREMENT,
  `SupplierID` INT ,
  `DateReceived` DATE,
  `Status` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`ShipmentOrderID`),
  FOREIGN KEY (`SupplierID`) REFERENCES `Supplier`(`SupplierID`) ON DELETE CASCADE ,
  INDEX idx_shipmentorder_supplierid (`SupplierID`)
);



CREATE TABLE `ShipmentItem` (
  `ShipmentItemID` INT AUTO_INCREMENT,
  `ProductID` INT,
  `ShipmentOrderID` INT,
  `Quantity` INT NOT NULL ,
  PRIMARY KEY (`ShipmentItemID`),
  FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`) ON DELETE CASCADE ,
  FOREIGN KEY (`ShipmentOrderID`) REFERENCES `ShipmentOrder`(`ShipmentOrderID`) ON DELETE CASCADE ,
   INDEX idx_shipmentitem_shipmentorderid (`ShipmentOrderID`) , 
   INDEX idx_shipmentitem_productid (`ProductID`)
);



-- ==============================
-- SECTION 6: PROMOTION AND DISCOUNT MANAGEMENT
-- Tables related to managing promotions and discounts
-- ==============================

CREATE TABLE `Promotion` (
  `PromotionID` INT AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Description` TEXT,
  `StartDate` DATE NOT NULL ,
  `EndDate` DATE NOT NULL,
  `DiscountPercentage` DECIMAL(5, 2) NOT NULL DEFAULT 0,  -- New column for discount percentage
  PRIMARY KEY (`PromotionID`) , 
  INDEX idx_promotion_startdate (`StartDate`),  
  INDEX idx_promotion_enddate (`EndDate`)  
);



CREATE TABLE `Discount` (
  `DiscountID` INT AUTO_INCREMENT,
  `DiscountName` VARCHAR(100) NOT NULL ,
  `DiscountType` VARCHAR(20) NOT NULL ,
  `DiscountValue` DECIMAL(10,2) NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  PRIMARY KEY (`DiscountID`) ,
  INDEX idx_discount_startdate (`StartDate`),
   INDEX idx_discount_enddate (`EndDate`)
);




CREATE TABLE `ProductDiscount` (
  `ProductID` INT NOT NULL,
  `DiscountID` INT NOT NULL,
  PRIMARY KEY (`ProductID`, `DiscountID`), -- Composite Primary Key
  FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`) ON DELETE CASCADE,
  FOREIGN KEY (`DiscountID`) REFERENCES `Discount`(`DiscountID`) ON DELETE CASCADE,
  INDEX idx_productdiscount_productid (`ProductID`),
  INDEX idx_productdiscount_discountid (`DiscountID`)
);


CREATE TABLE `PromotionProduct` (
  `PromotionProductID` INT AUTO_INCREMENT,
  `PromotionID` INT,
  `ProductID` INT,
  PRIMARY KEY (`PromotionProductID`),
  FOREIGN KEY (`PromotionID`) REFERENCES `Promotion`(`PromotionID`) ON DELETE CASCADE ,
  FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`) ON DELETE CASCADE ,
  INDEX idx_promotionproduct_promotionid (`PromotionID`), 
  INDEX idx_promotionproduct_productid (`ProductID`)  

);

-- ==============================
-- SECTION 7: SALES REPORTING
-- Tables related to generating sales reports
-- ==============================

CREATE TABLE `SalesReport` (
  `ReportID` INT AUTO_INCREMENT,
  `EmployeeID` INT,
  `StartDate` DATE NOT NULL ,
  `EndDate` DATE NOT NULL ,
  `DateGenerated` DATETIME NOT NULL,
  PRIMARY KEY (`ReportID`),
  FOREIGN KEY (`EmployeeID`) REFERENCES `Employee`(`EmployeeID`)  ON DELETE CASCADE ,
  INDEX idx_salesreport_employeeid (`EmployeeID`), 
  INDEX idx_salesreport_startdate (`StartDate`),  
  INDEX idx_salesreport_enddate (`EndDate`)  
  
);

CREATE TABLE `SalesReportDetail` (
  `SalesReportDetailID` INT AUTO_INCREMENT,
  `ReportID` INT,
  `ProductID` INT,
  `QuantitySold` INT NOT NULL ,
  `TotalRevenue` DECIMAL(10,2) NOT NULL ,
  PRIMARY KEY (`SalesReportDetailID`) , 
FOREIGN KEY (`ProductID`) REFERENCES `Product`(`ProductID`)  ON DELETE CASCADE, 
FOREIGN KEY (`ReportID`) REFERENCES `SalesReport`(`ReportID`)  ON DELETE CASCADE ,
INDEX idx_salesreportdetail_reportid (`ReportID`), 
  INDEX idx_salesreportdetail_productid (`ProductID`) 
);


-- ==============================
-- SECTION 10:  PRICING LOG
-- Tables related to product pricing history
-- ==============================

CREATE TABLE `PricingLog` (
  `PricingLogID` INT AUTO_INCREMENT,
  `ProductID` INT,
  `OldPrice` DECIMAL(10,2) NOT NULL,
  `NewPrice` DECIMAL(10,2) NOT NULL ,
  `ChangeDate` DATETIME NOT NULL,
  `EmployeeID` INT,  
  `Message` TEXT,
  PRIMARY KEY (`PricingLogID`),
  FOREIGN KEY (`EmployeeID`) REFERENCES `Employee`(`EmployeeID`) ON DELETE CASCADE, 
  FOREIGN KEY (`ProductID`) REFERENCES `Product` (`ProductID`) ON DELETE CASCADE , 
  INDEX idx_pricinglog_productid (`ProductID`), -- Index to speed up lookups
  INDEX idx_pricinglog_employeeid (`EmployeeID`) -- Index to speed up lookups

);



-- Create the 'Payments' table to store payment information

CREATE TABLE `Payment` (
  `PaymentID` INT AUTO_INCREMENT,
  `TransactionID` INT,
  `PaymentDate` DATETIME,
  `AmountPaid` DECIMAL(10,2),
 `PaymentMethod` ENUM ('Credit Card', 'Debit Card', 'Cash') NOT NULL,
  PRIMARY KEY (`PaymentID`),
  FOREIGN KEY (`TransactionID`) REFERENCES `Transaction`(`TransactionID`)  ON DELETE CASCADE 
);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
