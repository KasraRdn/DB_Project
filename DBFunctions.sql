CREATE OR ALTER FUNCTION Food.GetRestaurantRating (@RestID INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @AvgRating FLOAT;

    SELECT @AvgRating = ROUND(AVG(CAST(Rating AS FLOAT)), 2)
    FROM Food.Reviews
    WHERE RestaurantID = @RestID;
    
    RETURN ISNULL(@AvgRating, 0);
END;

CREATE OR ALTER FUNCTION Food.GetLatestStatus (@OrdID INT)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @LastStatus NVARCHAR(50);

    SELECT TOP 1 @LastStatus = Status
    FROM Food.OrderStatusHistory
    WHERE OrderID = @OrdID
    ORDER BY ChangeDate DESC, HistoryID DESC;
    
    RETURN ISNULL(@LastStatus, 'Unspecified');
END;

CREATE OR ALTER FUNCTION  Food.GetFinalPrice (@OrdID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @Final DECIMAL(18,2);
		
    SELECT @Final = O.TotalAmount - ISNULL((O.TotalAmount * C.DiscountPercent / 100), 0)
    FROM Food.Orders O
    LEFT JOIN Food.Coupons C ON O.CouponID = C.CouponID
    WHERE O.OrderID = @OrdID;
    
    RETURN @Final;
END;

/*Testing Functions
SELECT dbo.GetRestaurantRating(1) AS AverageRating;
SELECT dbo.GetLatestStatus(1) AS CurrentOrderStatus;
SELECT dbo.GetFinalPrice(1) AS FinalPriceToPay;*/
