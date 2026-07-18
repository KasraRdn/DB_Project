CREATE OR ALTER PROCEDURE Food.SubmitNewOrder
    @UID INT,
    @RestID INT,
    @AddrID INT,
    @Total DECIMAL(18,2)
AS
BEGIN
    INSERT INTO Food.Orders (UserID, RestaurantID, AddressID, TotalAmount)
    VALUES (@UID, @RestID, @AddrID, @Total);
    
    DECLARE @NewOrderID INT = SCOPE_IDENTITY();
    
    INSERT INTO Food.OrderStatusHistory (OrderID, Status)
    VALUES (@NewOrderID, 'Not registered');
END;

CREATE OR ALTER PROCEDURE Food.ChangeOrderStatus
    @OrdID INT,
    @NewStatus NVARCHAR(50)
AS
BEGIN
    INSERT INTO Food.OrderStatusHistory (OrderID, Status)
    VALUES (@OrdID, @NewStatus);
END;

CREATE OR ALTER PROCEDURE Food.AddNewReview
    @UID INT,
    @RestID INT,
    @Rate INT,
    @Txt NVARCHAR(250)
AS
BEGIN
    IF @Rate >= 1 AND @Rate <= 5
    BEGIN
        INSERT INTO Food.Reviews (UserID, RestaurantID, Rating, Comment)
        VALUES (@UID, @RestID, @Rate, @Txt);
    END
END;

/* Testing Procedure */
--EXEC Food.SubmitNewOrder @UID = 2, @RestID = 2, @AddrID = 2, @Total = 350000;
--SELECT * FROM Food.Orders ORDER BY OrderID DESC;
--SELECT * FROM Food.OrderStatusHistory ORDER BY HistoryID DESC;

--EXEC Food.ChangeOrderStatus @OrdID = 1, @NewStatus = 'preparing';
--SELECT * FROM Food.OrderStatusHistory WHERE OrderID = 1 ORDER BY HistoryID DESC;

--EXEC Food.AddNewReview @UID = 2, @RestID = 2, @Rate = 4, @Txt = 'Perfect quality';
--SELECT * FROM Food.Reviews ORDER BY ReviewID DESC;