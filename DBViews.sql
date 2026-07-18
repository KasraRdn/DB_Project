CREATE VIEW ActiveMenus AS
SELECT 
    R.Name RestaurantName,
    C.Title Category,
    M.Name FoodName,
    M.Price
FROM Restaurants R
JOIN MenuItems M ON R.RestaurantID = M.RestaurantID
JOIN Categories C ON M.CategoryID = C.CategoryID
WHERE R.IsActive = 1 AND M.IsAvailable = 1;

CREATE VIEW RestaurantPerformance AS
SELECT 
    R.Name RestaurantName,
    COUNT(O.OrderID) TotalOrders,
    SUM(O.TotalAmount) TotalRevenue,
    dbo.GetRestaurantRating(R.RestaurantID) AverageRating
FROM Restaurants R
LEFT JOIN Orders O ON R.RestaurantID = O.RestaurantID
GROUP BY R.Name, R.RestaurantID;

CREATE VIEW OrderInvoices AS
SELECT 
    O.OrderID,
    U.FirstName + ' ' + U.LastName CustomerName,
    R.Name RestaurantName,
    dbo.GetFinalPrice(O.OrderID) FinalPayableAmount,
    dbo.GetLatestStatus(O.OrderID) CurrentStatus
FROM Orders O
JOIN Users U ON O.UserID = U.UserID
JOIN Restaurants R ON O.RestaurantID = R.RestaurantID;

/* Testing Views
SELECT * FROM ActiveMenus;
SELECT * FROM RestaurantPerformance;
SELECT * FROM OrderInvoices;*/