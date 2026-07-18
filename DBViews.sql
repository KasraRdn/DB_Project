CREATE VIEW Food.ActiveMenus AS
SELECT 
    R.Name RestaurantName,
    C.Title Category,
    M.Name FoodName,
    M.Price
FROM Food.Restaurants R
JOIN Food.MenuItems M ON R.RestaurantID = M.RestaurantID
JOIN Food.Categories C ON M.CategoryID = C.CategoryID
WHERE R.IsActive = 1 AND M.IsAvailable = 1;

CREATE VIEW Food.RestaurantPerformance AS
SELECT 
    R.Name RestaurantName,
    COUNT(O.OrderID) TotalOrders,
    SUM(O.TotalAmount) TotalRevenue,
    Food.GetRestaurantRating(R.RestaurantID) AverageRating
FROM Food.Restaurants R
LEFT JOIN Food.Orders O ON R.RestaurantID = O.RestaurantID
GROUP BY R.Name, R.RestaurantID;

CREATE VIEW Food.OrderInvoices AS
SELECT 
    O.OrderID,
    U.FirstName + ' ' + U.LastName CustomerName,
    R.Name RestaurantName,
    Food.GetFinalPrice(O.OrderID) FinalPayableAmount,
    Food.GetLatestStatus(O.OrderID) CurrentStatus
FROM Food.Orders O
JOIN Food.Users U ON O.UserID = U.UserID
JOIN Food.Restaurants R ON O.RestaurantID = R.RestaurantID;

/* Testing Views*/
--SELECT * FROM Food.ActiveMenus;
--SELECT * FROM Food.RestaurantPerformance;
--SELECT * FROM Food.OrderInvoices;