CREATE OR ALTER PROCEDURE SubmitNewOrder
    @UID INT,
    @RestID INT,
    @AddrID INT,
    @Total DECIMAL(18,2)
AS
BEGIN
    INSERT INTO Orders (UserID, RestaurantID, AddressID, TotalAmount)
    VALUES (@UID, @RestID, @AddrID, @Total);
    
    DECLARE @NewOrderID INT = SCOPE_IDENTITY();
    
    INSERT INTO OrderStatusHistory (OrderID, Status)
    VALUES (@NewOrderID, 'Not registered');
END;

CREATE OR ALTER PROCEDURE ChangeOrderStatus
    @OrdID INT,
    @NewStatus NVARCHAR(50)
AS
BEGIN
    INSERT INTO OrderStatusHistory (OrderID, Status)
    VALUES (@OrdID, @NewStatus);
END;

CREATE OR ALTER PROCEDURE AddNewReview
    @UID INT,
    @RestID INT,
    @Rate INT,
    @Txt NVARCHAR(250)
AS
BEGIN
    IF @Rate >= 1 AND @Rate <= 5
    BEGIN
        INSERT INTO Reviews (UserID, RestaurantID, Rating, Comment)
        VALUES (@UID, @RestID, @Rate, @Txt);
    END
END;

/*Testing Procedure
EXEC SubmitNewOrder @UID = 2, @RestID = 2, @AddrID = 2, @Total = 350000;
EXEC ChangeOrderStatus @OrdID = 1, @NewStatus = 'preparing';
EXEC AddNewReview @UID = 2, @RestID = 2, @Rate = 4, @Txt = 'Perfect quality';*/

