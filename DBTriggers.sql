CREATE OR ALTER TRIGGER Food.PreventRestaurantDelete
ON Food.Restaurants
INSTEAD OF DELETE
AS
BEGIN
    UPDATE Restaurants
    SET IsActive = 0
    WHERE RestaurantID IN (SELECT RestaurantID FROM deleted);
END;

CREATE OR ALTER TRIGGER Food.ValidatePaymentAmount
ON Food.Payments
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Amount <= 0)
    BEGIN
        RAISERROR('Error: Payment amount cannot be zero or negative.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

CREATE OR ALTER TRIGGER Food.LogUsers ON Users AFTER INSERT, UPDATE, DELETE AS
BEGIN
    DECLARE @Action VARCHAR(10);
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @Action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted) SET @Action = 'INSERT';
    ELSE SET @Action = 'DELETE';
    INSERT INTO Food.SystemLogs (TableName, Action, Description) VALUES ('Users', @Action, 'Modification in Users table.');
END;

CREATE OR ALTER TRIGGER Food.LogRestaurants ON Restaurants AFTER INSERT, UPDATE, DELETE AS
BEGIN
    DECLARE @Action VARCHAR(10);
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @Action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted) SET @Action = 'INSERT';
    ELSE SET @Action = 'DELETE';
    INSERT INTO Food.SystemLogs (TableName, Action, Description) VALUES ('Restaurants', @Action, 'Modification in Restaurants table.');
END;

CREATE OR ALTER TRIGGER Food.LogCategories ON Categories AFTER INSERT, UPDATE, DELETE AS
BEGIN
    DECLARE @Action VARCHAR(10);
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @Action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted) SET @Action = 'INSERT';
    ELSE SET @Action = 'DELETE';
    INSERT INTO Food.SystemLogs (TableName, Action, Description) VALUES ('Categories', @Action, 'Modification in Categories table.');
END;

CREATE OR ALTER TRIGGER Food.LogCoupons ON Coupons AFTER INSERT, UPDATE, DELETE AS
BEGIN
    DECLARE @Action VARCHAR(10);
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @Action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted) SET @Action = 'INSERT';
    ELSE SET @Action = 'DELETE';
    INSERT INTO Food.SystemLogs (TableName, Action, Description) VALUES ('Coupons', @Action, 'Modification in Coupons table.');
END;

CREATE OR ALTER TRIGGER Food.LogAddresses ON Addresses AFTER INSERT, UPDATE, DELETE AS
BEGIN
    DECLARE @Action VARCHAR(10);
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @Action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted) SET @Action = 'INSERT';
    ELSE SET @Action = 'DELETE';
    INSERT INTO Food.SystemLogs (TableName, Action, Description) VALUES ('Addresses', @Action, 'Modification in Addresses table.');
END;

CREATE OR ALTER TRIGGER Food.LogMenuItems ON MenuItems AFTER INSERT, UPDATE, DELETE AS
BEGIN
    DECLARE @Action VARCHAR(10);
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @Action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted) SET @Action = 'INSERT';
    ELSE SET @Action = 'DELETE';
    INSERT INTO Food.SystemLogs (TableName, Action, Description) VALUES ('MenuItems', @Action, 'Modification in MenuItems table.');
END;

CREATE OR ALTER TRIGGER Food.LogReviews ON Reviews AFTER INSERT, UPDATE, DELETE AS
BEGIN
    DECLARE @Action VARCHAR(10);
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @Action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted) SET @Action = 'INSERT';
    ELSE SET @Action = 'DELETE';
    INSERT INTO Food.SystemLogs (TableName, Action, Description) VALUES ('Reviews', @Action, 'Modification in Reviews table.');
END;

CREATE OR ALTER TRIGGER Food.LogOrders ON Orders AFTER INSERT, UPDATE, DELETE AS
BEGIN
    DECLARE @Action VARCHAR(10);
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @Action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted) SET @Action = 'INSERT';
    ELSE SET @Action = 'DELETE';
    INSERT INTO Food.SystemLogs (TableName, Action, Description) VALUES ('Orders', @Action, 'Modification in Orders table.');
END;

CREATE OR ALTER TRIGGER Food.LogOrderDetails ON OrderDetails AFTER INSERT, UPDATE, DELETE AS
BEGIN
    DECLARE @Action VARCHAR(10);
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @Action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted) SET @Action = 'INSERT';
    ELSE SET @Action = 'DELETE';
    INSERT INTO Food.SystemLogs (TableName, Action, Description) VALUES ('OrderDetails', @Action, 'Modification in OrderDetails table.');
END;

CREATE OR ALTER TRIGGER Food.LogOrderStatusHistory ON OrderStatusHistory AFTER INSERT, UPDATE, DELETE AS
BEGIN
    DECLARE @Action VARCHAR(10);
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @Action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted) SET @Action = 'INSERT';
    ELSE SET @Action = 'DELETE';
    INSERT INTO Food.SystemLogs (TableName, Action, Description) VALUES ('OrderStatusHistory', @Action, 'Modification in OrderStatusHistory table.');
END;

CREATE OR ALTER TRIGGER Food.LogPayments ON Payments AFTER INSERT, UPDATE, DELETE AS
BEGIN
    DECLARE @Action VARCHAR(10);
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @Action = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted) SET @Action = 'INSERT';
    ELSE SET @Action = 'DELETE';
    INSERT INTO Food.SystemLogs (TableName, Action, Description) VALUES ('Payments', @Action, 'Modification in Payments table.');
END;

/*Testing Trigger
DELETE FROM Restaurants WHERE RestaurantID = 1;
SELECT RestaurantID, Name, IsActive FROM Restaurants WHERE RestaurantID = 1;

INSERT INTO Payments (OrderID, Amount, IsSuccessful) 
VALUES (1, -50000, 0);

INSERT INTO MenuItems (RestaurantID, CategoryID, Name, Price, IsAvailable) 
VALUES (1, 1, 'Test Burger', 150000, 1);
UPDATE MenuItems 
SET Price = 160000 
WHERE Name = 'Test Burger';
SELECT * FROM SystemLogs ORDER BY LogDate DESC;*/