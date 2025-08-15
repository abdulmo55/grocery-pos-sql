USE proudpinoydb;
SET SQL_SAFE_UPDATES = 0;

-- Sample Data for proudpinoydb Schema


-- Customer
INSERT INTO Customer (FirstName, LastName, PhoneNumber, Email) 
VALUES
('John', 'Doe', '123-456-7890', 'john.doe@email.com'),
('Jane', 'Smith', '987-654-3210', 'jane.smith@email.com'),
('Robert', 'Brown', '555-123-4567', 'robert.brown@email.com'),
('Emily', 'Johnson', '234-567-8901', 'emily.johnson@email.com'),
('Michael', 'Davis', '678-123-4567', 'michael.davis@email.com'),
('Sarah', 'Wilson', '789-456-1230', 'sarah.wilson@email.com'),
('David', 'Taylor', '321-654-9870', 'david.taylor@email.com'),
('Laura', 'White', '456-789-0123', 'laura.white@email.com'),
('James', 'Clark', '567-890-1234', 'james.clark@email.com'),
('Emma', 'Hall', '890-123-4567', 'emma.hall@email.com');



-- Product 
INSERT INTO Product (Name, Description, Price, StockQuantity, Barcode) VALUES
('Lemonade', 'COOL TASTE Calamansi Drink', 3.19, 22, '842630127655'),
('Tea', 'GEISHA Cinnamon Tea', 8.99, 28, '565638237655'),
('Coconut Drink', 'LIPA Coconut Water', 2.29, 31, '199843445566'),
('Milk Tea', 'RICO Bubble Milk Tea', 1.99, 93, '102233445566'),
('Fish', 'Bobo Frozen Fish', 9.99, 21, '743659235645'),
('Fish', 'Blona Beat Tuna', 2.99, 20, '028463246856'),
('Cracker', 'Graham Honey Cracker', 7.99, 24, '981463246856'),
('Candy', 'HOW HOW Chocolate Candy', 3.99, 33, '028463200956'),
('Dumpling', 'HANMANDO Frozen Seafood Dumpling', 6.99, 21, '854723246856'),
('Sauce', 'BOLINAO Fish Sauce', 3.99, 29, '008463246856'),
('Sauce', 'Coconut Soy Sauce', 3.89, 22, '909063246856'),
('Ice Cream', 'Pulo Ice Cream Ube', 14.99, 22, '028463246800'),
('Ice Cream', 'Pulo Ice Cream Ube Macapuno', 14.99, 20, '028463246801'),
('Almonds', 'Raw almonds', 7.99, 40, '456789010345'),
('Bananas', 'Fresh bananas', 0.59, 200, '567890123456'),
('Carrots', 'Organic carrots', 1.49, 120, '678901234567'),
('Tomatoes', 'Roma tomatoes', 2.99, 80, '789012345678'),
('Potatoes', 'Yukon gold potatoes', 0.79, 150, '890120456789'),
('Onions', 'Yellow onions', 0.49, 160, '901234567890'),
('Garlic', 'Fresh garlic', 0.99, 100, '012345678901'),
('Spinach', 'Fresh spinach', 2.49, 70, '123456789014'),
('Broccoli', 'Organic broccoli', 1.99, 60, '234567890125'),
('Cauliflower', 'Fresh cauliflower', 2.29, 55, '345678901236'),
('Bell Peppers', 'Assorted bell peppers', 1.89, 90, '456789012346'),
('Cucumbers', 'Crisp cucumbers', 0.79, 110, '567890123457'),
('Zucchini', 'Fresh zucchini', 0.89, 100, '678901234578'),
('Lettuce', 'Romaine lettuce', 1.29, 80, '789012345689'),
('Avocados', 'Hass avocados', 1.99, 70, '890123456790'),
('Peaches', 'Fresh peaches', 2.49, 60, '901234567891'),
('Strawberries', 'Fresh strawberries', 3.99, 50, '012345678912'),
('Blueberries', 'Organic blueberries', 4.99, 40, '123456789015'),
('Raspberries', 'Fresh raspberries', 5.49, 30, '234567890126'),
('Lemons', 'Fresh lemons', 0.79, 100, '345678901237'),
('Limes', 'Fresh limes', 0.79, 95, '456789012347'),
('Oranges', 'Navel oranges', 0.89, 85, '567890123458'),
('Pineapple', 'Fresh pineapple', 3.49, 45, '678901234579'),
('Grapes', 'Seedless grapes', 2.99, 50, '789012345690'),
('Cherries', 'Fresh cherries', 4.99, 25, '890123456791'),
('Watermelon', 'Seedless watermelon', 5.99, 20, '901234567892'),
('Cabbage', 'Green cabbage', 1.19, 100, '012345678913'),
('Kale', 'Organic kale', 2.29, 60, '123456789016'),
('Sweet Potatoes', 'Organic sweet potatoes', 1.49, 70, '234567890127'),
('Pumpkin', 'Fresh pumpkin', 3.49, 30, '345678901238'),
('Corn', 'Sweet corn', 0.99, 90, '456789012348'),
('Peas', 'Frozen peas', 1.89, 50, '567890123459'),
('Green Beans', 'Fresh green beans', 2.49, 60, '678901234580'),
('Mushrooms', 'Fresh button mushrooms', 2.99, 60, '901234567893'),
('Olive Oil', 'Extra virgin olive oil', 6.99, 30, '012345678914'),
('Vinegar', 'Balsamic vinegar', 3.49, 50, '123456789017'),
('Honey', 'Raw local honey', 5.99, 40, '234567890128'),
('Peanut Butter', 'Creamy peanut butter', 3.79, 80, '345678901239'),
('Jam', 'Strawberry jam', 2.49, 70, '456789012349'),
('Ketchup', 'Tomato ketchup', 2.29, 90, '567890123460'),
('Mustard', 'Yellow mustard', 1.79, 85, '678901234581'),
('Mayonnaise', 'Organic mayonnaise', 4.99, 50, '789012345692'),
('Soy Sauce', 'Low sodium soy sauce', 2.79, 40, '890123456793'),
('Hot Sauce', 'Spicy hot sauce', 3.29, 35, '901234567894'),
('Salsa', 'Mild salsa', 2.49, 60, '012345678915'),
('Tortilla Chips', 'Corn tortilla chips', 3.49, 50, '123456789018'),
('Granola', 'Organic granola', 4.99, 45, '234567890129'),
('Cocoa Powder', 'Unsweetened cocoa powder', 3.29, 30, '345678901240'),
('Chocolate', 'Dark chocolate bars', 2.99, 50, '456789012350'),
('Cookies', 'Chocolate chip cookies', 4.49, 25, '567890123461'),
('Ice Cream', 'Vanilla ice cream', 5.49, 20, '678901234582'),
('Frozen Pizza', 'Pepperoni pizza', 8.99, 15, '789012345693'),
('Pancake Mix', 'Buttermilk pancake mix', 3.79, 55, '890123456794'),
('Cereal Bars', 'Fruit cereal bars', 2.99, 70, '901234567895'),
('Nut Mix', 'Mixed nuts', 6.49, 40, '012345678916'),
('Dried Fruits', 'Mixed dried fruits', 5.99, 35, '123456789019'),
('Popcorn', 'Butter popcorn', 1.99, 60, '234567890130'),
('Frozen Vegetables', 'Mixed frozen vegetables', 2.49, 80, '345678901241'),
('Fish', 'Frozen salmon fillets', 12.99, 20, '456789012351'),
('Chicken', 'Organic chicken breasts', 9.99, 30, '567890123462'),
('Beef', 'Ground beef', 7.49, 25, '678901234583'),
('Pork', 'Pork chops', 8.49, 20, '789012345694'),
('Tofu', 'Firm tofu', 2.29, 50, '890123456795'),
('Noodles', 'Rice noodles', 2.49, 40, '901234567896'),
('Rice Cakes', 'Plain rice cakes', 1.99, 60, '012345678917'),
('Baking Powder', 'Baking powder', 1.29, 90, '123456789020'),
('Baking Soda', 'Baking soda', 0.99, 100, '234567890131'),
('Salt', 'Sea salt', 0.59, 150, '345678901242'),
('Pepper', 'Black pepper', 2.49, 70, '456789012352'),
('Spices', 'Mixed spices', 3.99, 55, '567890123463'),
('Herbs', 'Dried oregano', 2.19, 80, '678901234584'),
('Vanilla Extract', 'Pure vanilla extract', 5.49, 30, '789012345695'),
('Yeast', 'Active dry yeast', 1.49, 60, '890123456796'),
('Cream Cheese', 'Regular cream cheese', 2.79, 50, '901234567897'),
('Sour Cream', 'Sour cream', 1.99, 70, '012345678918'),
('Pudding Mix', 'Chocolate pudding mix', 1.59, 40, '123456789021'),
('Gelatin', 'Unflavored gelatin', 1.29, 55, '234567890132'),
('Coconut Milk', 'Canned coconut milk', 2.79, 45, '345678901243'),
('Chickpeas', 'Canned chickpeas', 1.29, 60, '567890123464'),
('Curry Paste', 'Red curry paste', 3.49, 30, '456789012353'),
('Tea', 'Herbal tea', 3.99, 25, '890123456789'),
('Banana', 'Fresh yellow bananas', 0.79, 100, '123456789012'),
('Milk', 'Whole milk', 3.99, 50, '987654321098'),
('Eggs', 'Grade A large eggs', 2.99, 75, '112233445566'),
('Bread', 'White bread loaf', 2.49, 40, '778899001122'),
('Coffee', 'Ground coffee', 7.99, 30, '445566778899'),
('Sugar', 'Granulated sugar', 4.99, 60, '121234345656'),
('Salt', 'Iodized salt', 1.99, 80, '787890901212'),
('Pepper', 'Black pepper', 3.49, 25, '454567678989'),
('Chicken', 'Whole chicken', 8.99, 35, '909012123434'),
('Beef', 'Ground beef', 5.99, 45, '565678789090');

-- Category

INSERT INTO Category (Name, Description, MinPrice) VALUES
('Fruits', 'Fresh and delicious fruits', 0.50),
('Vegetables', 'A variety of fresh vegetables', 0.75),
('Dairy', 'Milk, cheese, yogurt, and more', 1.00),
('Meat & Poultry', 'Beef, chicken, pork, etc.', 2.00),
('Seafood', 'Fish, shrimp, and other seafood', 3.00),
('Bakery', 'Bread, pastries, and cakes', 1.50),
('Pantry', 'Canned goods, pasta, rice, etc.', 0.75),
('Snacks', 'Chips, cookies, candy, etc.', 0.50),
('Beverages', 'Juices, soda, water, etc.', 1.00),
('Frozen Foods', 'Frozen meals, ice cream, etc.', 2.50);


-- Product_Category (linking products to their categories)

INSERT INTO Product_Category (ProductID, CategoryID) VALUES
(1, 1),  -- Banana - Fruits
(2, 3),  -- Milk - Dairy
(3, 3),  -- Eggs - Dairy
(4, 6),  -- Bread - Bakery
(5, 9),  -- Coffee - Beverages
(6, 7),  -- Sugar - Pantry
(7, 7),  -- Salt - Pantry
(8, 7),  -- Pepper - Pantry
(9, 4),  -- Chicken - Meat & Poultry
(10, 4); -- Beef - Meat & Poultry 

-- Employee

-- Insert data into the Employee table with ManagerID set to NULL initially
INSERT INTO Employee (FirstName, LastName, Role, PayRate, ManagerID) 
VALUES
('Alice', 'Brown', 'Cashier', 14.00, NULL),
('Bob', 'Smith', 'Cashier', 14.00, NULL),
('Charlie', 'Johnson', 'Cashier', 14.00, NULL),
('Diana', 'Taylor', 'Cashier', 14.00, NULL),
('Edward', 'Clark', 'Supervisor', 18.00, NULL),
('Fiona', 'White', 'Supervisor', 18.00, NULL),
('George', 'Davis', 'Manager', 20.00, NULL),
('Helen', 'Wilson', 'Manager', 20.00, NULL);



-- Schedule
INSERT INTO Schedule (EmployeeID, WorkDate, StartTime, EndTime, Status) 
VALUES
(1, '2024-11-21', '09:00:00', '17:00:00', 'Completed'),
(2, '2024-11-21', '10:00:00', '18:00:00', 'Completed'),
(3, '2024-11-21', '08:00:00', '16:00:00', 'Completed'),
(4, '2024-11-21', '12:00:00', '20:00:00', 'Completed'),
(5, '2024-11-21', '07:00:00', '15:00:00', 'Completed'),
(6, '2024-11-21', '11:00:00', '19:00:00', 'Completed'),
(7, '2024-11-21', '09:30:00', '17:30:00', 'Completed'),
(8, '2024-11-21', '08:30:00', '16:30:00', 'Completed');


-- EmployeeHours

INSERT INTO EmployeeHours (EmployeeID, ScheduleID, ClockInTime, ClockOutTime) 
VALUES
(1, 1, '2024-11-21 08:55:00', '2024-11-21 17:05:00'),
(2, 2, '2024-11-21 09:58:00', '2024-11-21 18:03:00'),
(3, 3, '2024-11-21 07:56:00', '2024-11-21 16:02:00'),
(4, 4, '2024-11-21 11:55:00', '2024-11-21 20:10:00'),
(5, 5, '2024-11-21 06:58:00', '2024-11-21 15:02:00'),
(6, 6, '2024-11-21 10:58:00', '2024-11-21 19:04:00'),
(7, 7, '2024-11-21 09:25:00', '2024-11-21 17:40:00'),
(8, 8, '2024-11-21 08:25:00', '2024-11-21 16:40:00');


-- Supplier
INSERT INTO Supplier (SupplierName, ContactNumber, Email, Address) VALUES
('Corinthian Distributors', '604-431-5058', 'sales1@corinthian.com', '8118 N Fraser Wy'),
('Farmers Market', '555-111-2222', 'farmers@email.com', '123 Main St'),
('Seafood Supplier', '555-333-4444', 'seafood@email.com', '456 Ocean Ave'),
('Green Grocers', '555-555-6666', 'green@email.com', '789 Green Blvd'),
('Fresh Organics', '555-777-8888', 'organics@email.com', '1010 Organic Way'),
('Bakers Delight', '555-999-0000', 'bakers@email.com', '2020 Bakery Rd'),
('Dairy Farm', '555-444-5555', 'dairy@email.com', '303 Dairy Ln'),
('Veggie World', '555-666-7777', 'veggie@email.com', '404 Veggie Dr'),
('Global Spices', '555-888-9999', 'spices@email.com', '505 Spice St');



-- Supplier_Product (linking suppliers to products)
INSERT INTO Supplier_Product (SupplierID, ProductID) VALUES
(1, 1),  -- Farmers Market - Rice
(1, 3),  -- Farmers Market - Mango
(2, 5),  -- Seafood Supplier - Bangus
(3, 2),  -- Green Grocers - Lettuce
(3, 4),  -- Green Grocers - Tomato
(4, 6),  -- Fresh Organics - Organic Apples
(5, 7),  -- Bakers Delight - Wheat Flour
(6, 8),  -- Dairy Farm - Milk
(7, 9),  -- Veggie World - Carrot
(8, 10); -- Global Spices - Cinnamon


-- ShipmentOrder
INSERT INTO ShipmentOrder (SupplierID, DateReceived, Status) VALUES
(1, '2024-11-15', 'Received'),
(2, '2024-11-18', 'Received'),
(3, '2024-11-20', 'Received'),  -- Green Grocers
(4, '2024-11-21', 'Received'),  -- Fresh Organics
(5, '2024-11-22', 'Pending'),   -- Bakers Delight
(6, '2024-11-23', 'Pending'),   -- Dairy Farm
(7, '2024-11-24', 'Received'),  -- Veggie World
(8, '2024-11-25', 'Pending');   -- Global Spices

-- ShipmentItem
INSERT INTO ShipmentItem (ProductID, ShipmentOrderID, Quantity) VALUES
(1, 1, 50),  -- Rice - Shipment 1
(3, 1, 20),  -- Mango - Shipment 1
(5, 2, 30),  -- Bangus - Shipment 2
(2, 7, 40),  -- Lettuce - Shipment 3
(4, 3, 60),  -- Tomato - Shipment 4
(6, 4, 100), -- Organic Apples - Shipment 5
(7, 5, 80),  -- Wheat Flour - Shipment 6
(8, 6, 200), -- Milk - Shipment 7
(9, 7, 150), -- Carrot - Shipment 8
(10, 8, 250); -- Cinnamon - Shipment 9

-- Promotion
INSERT INTO Promotion (Name, Description, StartDate, EndDate, DiscountPercentage) 
VALUES
('Pasko Holiday Sale', 'Discounts on Filipino Christmas favorites like bibingka, queso de bola, and hamon', '2024-12-15', '2025-01-15', 10.00),
('Fiesta Pack Promo', 'Special bundle deals on pancit noodles, lechon sauce, and lumpia wrappers', '2024-06-01', '2024-06-15', 12.00),
('Lutong Bahay Sale', 'Save on everyday essentials like rice, cooking oil, and canned goods', '2024-11-01', '2024-11-15', 8.00),
('Seafood Specials', 'Discounts on frozen bangus, pusit, and galunggong', '2024-09-01', '2024-09-07', 15.00),
('Summer Halo-Halo Treats', 'Deals on ingredients like ube halaya, nata de coco, and leche flan for halo-halo', '2024-05-15', '2024-05-31', 10.00);



-- PromotionProduct (linking promotions to products)

INSERT INTO PromotionProduct (PromotionID, ProductID) VALUES
(1, 1),  
(1, 2),  
(1, 3),  
(2, 4),  
(2, 5),  
(2, 6),  
(3, 1),  
(3, 7),  
(4, 8),  
(4, 9),  
(5, 10);  


-- Discount
INSERT INTO Discount (DiscountName, DiscountType, DiscountValue, StartDate, EndDate) VALUES
('Employee Discount', 'Fixed', 5.00, '2024-01-01', '2024-12-31'),
('Bulk Discount', 'Percentage', 10.00, '2024-01-01', '2024-12-31'),
('Senior Discount', 'Percentage', 7.00, '2024-01-01', '2024-12-31');




-- ProductDiscount (linking discounts to products)
INSERT INTO ProductDiscount (ProductID, DiscountID) VALUES
(1, 1),  -- Product 1 - Discount 1
(2, 1),  -- Product 2 - Discount 1
(3, 1),  -- Product 3 - Discount 1
(4, 2),  -- Product 4 - Discount 2
(5, 2),  -- Product 5 - Discount 2
(6, 2),  -- Product 6 - Discount 2
(7, 3),  -- Product 7 - Discount 3
(8, 3),  -- Product 8 - Discount 3
(9, 3),  -- Product 9 - Discount 4
(10, 3); -- Product 10 - Discount 4

-- PhoneOrders
INSERT INTO PhoneOrders (CustomerID, OrderDate, PickupDate, Status) VALUES
(1, '2024-11-20', '2024-11-23', 'Pending'),
(2, '2024-11-19', '2024-11-21', 'Completed'),
(3, '2024-11-18', '2024-11-20', 'Pending'),
(4, '2024-11-17', '2024-11-19', 'Completed'),
(5, '2024-11-16', '2024-11-18', 'Pending'),
(6, '2024-11-15', '2024-11-17', 'Completed'),
(7, '2024-11-14', '2024-11-16', 'Pending'),
(8, '2024-11-13', '2024-11-15', 'Completed'),
(9, '2024-11-12', '2024-11-14', 'Pending'),
(10, '2024-11-11', '2024-11-13', 'Completed');


-- PhoneOrderItem

INSERT INTO PhoneOrderItem (PhoneOrderID, ProductID, Quantity, Price) VALUES
(1, 1, 2, 25.00),  -- Rice - Phone Order 1
(2, 3, 1, 15.00),  -- Pancit Canton - Phone Order 2
(3, 4, 3, 10.00),  -- Soy Sauce - Phone Order 2
(4, 1, 1, 25.00),  -- Rice - Phone Order 3
(5, 5, 2, 8.00),   -- Fish Sauce - Phone Order 3
(6, 2, 2, 5.50),   -- Adobo Sauce - Phone Order 4
(7, 6, 1, 12.00),  -- Canned Tuna - Phone Order 4
(8, 3, 3, 15.00),  -- Pancit Canton - Phone Order 5
(9, 7, 1, 4.00);   -- Vinegar - Phone Order 5



-- Transaction

INSERT INTO Transaction (CustomerID, TransactionDate, TotalAmount, PaymentMethod, EmployeeID) VALUES
(1, '2024-11-22', 55.50, 'Credit Card', 2),  -- Phone Order 1
(2, '2024-11-21', 45.00, 'Cash', 3),        -- Phone Order 2
(3, '2024-11-23', 33.00, 'Debit Card', 1),  -- Phone Order 3
(4, '2024-11-24', 28.00, 'Cash', 2),        -- Phone Order 4
(5, '2024-11-25', 36.00, 'Credit Card', 4), -- Phone Order 5
(6, '2024-11-26', 28.00, 'Debit Card', 5),  -- Phone Order 6
(7, '2024-11-27', 26.50, 'Cash', 6),        -- Phone Order 7
(8, '2024-11-28', 37.00, 'Credit Card', 7), -- Phone Order 8
(9, '2024-11-29', 25.00, 'Cash', 8),        -- Phone Order 9
(10, '2024-11-30', 33.00, 'Debit Card', 7); -- Phone Order 10


INSERT INTO TransactionItem (TransactionID, ProductID, Quantity, Price) VALUES
(1, 1, 2, 25.00),
(1, 2, 1, 5.50),
(2, 3, 5, 2.00),
(3, 4, 3, 10.00),
(4, 5, 1, 15.00),
(5, 6, 2, 12.50),
(6, 7, 4, 7.00),
(7, 8, 1, 18.00),
(8, 9, 3, 6.00),
(9, 10, 2, 20.00),
(10, 39, 2, 5.99);

-- Inserting data into the InventoryLog table

INSERT INTO InventoryLog (ProductID, ChangeType, QuantityChange, LogDate, EmployeeID) VALUES
(1, 'Incoming', 50, '2024-11-18 09:00:00', 1),  -- 50 bananas added by Ana
(2, 'Incoming', 30, '2024-11-18 10:30:00', 1),  -- 30 milk cartons added by Ana
(3, 'Outgoing', 15, '2024-11-19 11:00:00', 1),  -- 15 eggs sold by Ana
(4, 'Outgoing', 10, '2024-11-19 14:00:00', 1),  -- 10 loaves of bread sold by Ana
(5, 'Incoming', 20, '2024-11-20 10:00:00', 3),  -- 20 coffee bags added by Andres
(6, 'Adjustment', -5, '2024-11-20 15:00:00', 2), -- 5 bags of sugar removed (damaged) by Jose
(7, 'Outgoing', 25, '2024-11-21 11:30:00', 1),  -- 25 salt packages sold by Ana
(8, 'Incoming', 15, '2024-11-21 14:00:00', 3),  -- 15 pepper containers added by Andres
(9, 'Outgoing', 8, '2024-11-21 16:00:00', 1),   -- 8 chickens sold by Ana
(10, 'Adjustment', 10, '2024-11-21 17:00:00', 2) ; -- 10 extra beef packages found by Jose


-- Low stock alert
INSERT INTO LowStockAlert (ProductID, CurrentStock, AlertDate, Status) VALUES 
(3, 10, '2024-11-21 10:00:00', 'Open'),   -- Eggs - 10 remaining
(8, 5, '2024-11-21 14:30:00', 'Open'),   -- Pepper - 5 remaining
(4, 12, '2024-11-20 09:15:00', 'Closed'), -- Bread - 12 remaining (alert closed)
(9, 8, '2024-11-19 16:45:00', 'Open'),   -- Chicken - 8 remaining
(1, 20, '2024-11-18 11:00:00', 'Closed'); -- Bananas - 20 remaining (alert closed) 

--- Payroll 
-- Payroll for the period from 2024-11-03 to 2024-11-16
INSERT INTO Payroll (EmployeeID, PayPeriodStart, PayPeriodEnd, TotalHours, TotalPay, Status) VALUES
(1, '2024-11-03', '2024-11-16', 40.00, 560.00, 'Paid'),
(2, '2024-11-03', '2024-11-16', 45.00, 900.00, 'Paid'),
(3, '2024-11-03', '2024-11-16', 38.50, 693.00, 'Paid'),
(4, '2024-11-03', '2024-11-16', 37.00, 666.00, 'Paid'),
(5, '2024-11-03', '2024-11-16', 42.00, 840.00, 'Paid'),
(6, '2024-11-03', '2024-11-16', 40.50, 612.50, 'Paid'),
(7, '2024-11-03', '2024-11-16', 41.25, 825.00, 'Paid'),
(8, '2024-11-03', '2024-11-16', 39.75, 796.50, 'Paid');

-- Payroll for the period from 2024-11-17 to 2024-11-30
INSERT INTO Payroll (EmployeeID, PayPeriodStart, PayPeriodEnd, TotalHours, TotalPay, Status) VALUES
(1, '2024-11-17', '2024-11-30', 35.75, 500.50, 'Pending'),
(2, '2024-11-17', '2024-11-30', 42.25, 845.00, 'Pending'),
(3, '2024-11-17', '2024-11-30', 39.00, 702.00, 'Pending'),
(4, '2024-11-17', '2024-11-30', 41.00, 748.00, 'Pending'),
(5, '2024-11-17', '2024-11-30', 44.50, 890.00, 'Pending'),
(6, '2024-11-17', '2024-11-30', 40.00, 600.00, 'Pending'),
(7, '2024-11-17', '2024-11-30', 39.25, 785.00, 'Pending'),
(8, '2024-11-17', '2024-11-30', 40.75, 798.50, 'Pending');


-- Sales Reports for the two managers
INSERT INTO SalesReport (EmployeeID, StartDate, EndDate, DateGenerated) VALUES
(7, '2024-11-04', '2024-11-10', '2024-11-11 10:00:00'),  -- Report for the week of Nov 4th - 10th (Manager 2)
(7, '2024-11-11', '2024-11-17', '2024-11-18 11:30:00'),  -- Report for the week of Nov 11th - 17th (Manager 2)
(8, '2024-11-04', '2024-11-10', '2024-11-11 12:00:00'),  -- Report for the week of Nov 4th - 10th (Manager 3)
(8, '2024-11-11', '2024-11-17', '2024-11-18 12:30:00');  -- Report for the week of Nov 11th - 17th (Manager 3)

-- Inserting data into the SalesReportDetail table


-- Sales Report Details for ReportID = 1
INSERT INTO SalesReportDetail (ReportID, ProductID, QuantitySold, TotalRevenue) VALUES
(1, 1, 120, 94.80),  -- Bananas - 120 sold
(1, 2, 50, 199.50),  -- Milk - 50 sold
(1, 3, 80, 239.20);  -- Eggs - 80 sold

-- Sales Report Details for ReportID = 2 (New Report for Manager 2)
INSERT INTO SalesReportDetail (ReportID, ProductID, QuantitySold, TotalRevenue) VALUES
(2, 1, 110, 85.50),  -- Bananas - 110 sold
(2, 2, 60, 239.40),  -- Milk - 60 sold
(2, 3, 90, 270.30);  -- Eggs - 90 sold




INSERT INTO PricingLog (ProductID, OldPrice, NewPrice, ChangeDate, EmployeeID, Message) VALUES
(1, 0.75, 0.79, '2024-11-15 10:00:00', 7, 'Banana price increased due to higher supplier cost'), 
(5, 8.49, 7.99, '2024-11-12 14:30:00', 7, 'Coffee price decreased for a promotional sale'); 


-- Payments for Transactions
INSERT INTO Payment (TransactionID, PaymentDate, AmountPaid, PaymentMethod) VALUES
(1, '2024-11-22 10:05:00', 55.50, 'Credit Card'),   -- Payment for Transaction 1
(2, '2024-11-21 12:03:00', 45.00, 'Cash'),          -- Payment for Transaction 2
(3, '2024-11-23 15:02:00', 33.00, 'Debit Card'),    -- Payment for Transaction 3
(4, '2024-11-24 09:30:00', 28.00, 'Cash'),          -- Payment for Transaction 4
(5, '2024-11-25 14:20:00', 36.00, 'Credit Card'),   -- Payment for Transaction 5
(6, '2024-11-26 17:10:00', 28.00, 'Debit Card'),    -- Payment for Transaction 6
(7, '2024-11-27 08:45:00', 26.50, 'Cash'),          -- Payment for Transaction 7
(8, '2024-11-28 19:00:00', 37.00, 'Credit Card'),   -- Payment for Transaction 8
(9, '2024-11-29 10:25:00', 25.00, 'Cash'),          -- Payment for Transaction 9
(10, '2024-11-30 16:50:00', 33.00, 'Debit Card');   -- Payment for Transaction 10


-- Update the ManagerID for Cashiers (assuming George Davis manages them)
UPDATE Employee AS E
INNER JOIN Employee AS M ON M.FirstName = 'George' AND M.LastName = 'Davis'
SET E.ManagerID = M.EmployeeID
WHERE E.Role = 'Cashier';

-- Update the ManagerID for Supervisors (assuming Helen Wilson manages them)

UPDATE Employee AS E
INNER JOIN Employee AS M ON M.FirstName = 'Helen' AND M.LastName = 'Wilson'
SET E.ManagerID = M.EmployeeID
WHERE E.Role = 'Supervisor'; 
