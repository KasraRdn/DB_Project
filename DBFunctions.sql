CREATE FUNCTION GetRestaurantRating (@RestID INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @AvgRating FLOAT;
    SELECT @AvgRating = ROUND(AVG(CAST(Rating AS FLOAT)), 2)
    FROM Reviews
    WHERE RestaurantID = @RestID;
    
    RETURN ISNULL(@AvgRating, 0);
END;

CREATE FUNCTION GetLatestStatus (@OrdID INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @LastStatus NVARCHAR(50);
    SELECT TOP 1 @LastStatus = Status
    FROM OrderStatusHistory
    WHERE OrderID = @OrdID
    ORDER BY ChangeDate DESC, HistoryID DESC;
    
    RETURN ISNULL(@LastStatus, 'Unspecified');
END;

CREATE FUNCTION GetFinalPrice (@OrdID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @Final DECIMAL(18,2);
    SELECT @Final = O.TotalAmount - ISNULL((O.TotalAmount * C.DiscountPercent / 100), 0)
    FROM Orders O
    LEFT JOIN Coupons C ON O.CouponID = C.CouponID
    WHERE O.OrderID = @OrdID;
    
    RETURN @Final;
END;