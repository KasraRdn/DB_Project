INSERT INTO Food.Users (FirstName, LastName, PhoneNumber, Password) VALUES
('Ali', 'Rezaei', '09121112233', 'Hash1234'),
('Sara', 'Kamali', '09134445566', 'Hash5678'),
('Reza', 'Mohammadi', '09157778899', 'Hash9012'),
('Neda', 'Ahmadi', '09190001122', 'Hash3456'),
('Omid', 'Hosseini', '09351234567', 'Hash7890');

INSERT INTO Food.Restaurants (Name, PhoneNumber, Address, IsActive) VALUES
('Nayeb Kebab', '02188776655', 'Tehran, Valiaser St', 1),
('Shila FastFood', '02144332211', 'Tehran, Enghelab Sq', 1),
('Saliz Restaurant', '03136655444', 'Isfahan, Chaharbagh', 1),
('Haft Khan', '07132223344', 'Shiraz, Quran Gate', 1),
('Aida Sandwich', '02177889900', 'Tehran, Tehranpars', 0);

INSERT INTO Food.Categories (Title) VALUES
('Traditional Iranian'),
('Fast Food'),
('Beverages'),
('Appetizers'),
('Desserts');

INSERT INTO Food.Coupons (Code, DiscountPercent, IsActive) VALUES
('WELCOME10', 10.00, 1),
('YALDA20', 20.00, 1),
('NOROUZ15', 15.00, 1),
('STUDENT5', 5.00, 1),
('VIP30', 30.00, 0);

INSERT INTO Food.Addresses (UserID, City, Street, PostalCode) VALUES
(1, 'Tehran', 'Vanak, No 12', '1998765432'),
(2, 'Isfahan', 'Bozorgmehr, No 4', '8154321987'),
(3, 'Shiraz', 'Zand, No 88', '7134567890'),
(4, 'Tehran', 'Tajrish, No 3', '1987654321'),
(5, 'Mashhad', 'Sajad, No 45', '9187654321');

INSERT INTO Food.MenuItems (RestaurantID, CategoryID, Name, Price, IsAvailable) VALUES
(1, 1, 'Koobideh Kebab', 350000, 1),
(2, 2, 'Pepperoni Pizza', 280000, 1),
(3, 1, 'Beryani', 400000, 1),
(4, 3, 'Doogh', 30000, 1),
(5, 2, 'Hotdog', 150000, 0);

INSERT INTO Food.Reviews (UserID, RestaurantID, Rating, Comment) VALUES
(1, 1, 5, 'Great kebab, very delicious!'),
(2, 3, 4, 'Good food but late delivery.'),
(3, 4, 5, 'Best traditional food in town.'),
(4, 2, 2, 'Pizza was cold.'),
(5, 1, 5, 'Excellent quality as always.');

INSERT INTO Food.Orders (UserID, RestaurantID, AddressID, CouponID, TotalAmount) VALUES
(1, 1, 1, 1, 315000), 
(2, 3, 2, NULL, 400000), 
(3, 4, 3, 2, 24000), 
(4, 2, 4, NULL, 280000), 
(5, 1, 5, 4, 332500); 

INSERT INTO Food.OrderDetails (OrderID, ItemID, Quantity, UnitPrice) VALUES
(1, 1, 1, 350000),
(2, 3, 1, 400000),
(3, 4, 1, 30000),
(4, 2, 1, 280000),
(5, 1, 1, 350000);

INSERT INTO Food.OrderStatusHistory (OrderID, Status) VALUES
(1, 'Delivered'),
(2, 'Delivered'),
(3, 'Preparing'),
(4, 'Pending'),
(5, 'Canceled');

INSERT INTO Food.Payments (OrderID, Amount, IsSuccessful) VALUES
(1, 315000, 1),
(2, 400000, 1),
(3, 24000, 1),
(4, 280000, 0), 
(5, 332500, 1);

/*INSERT INTO Food.TaxiFoodDeliveries(OrderId, PickupAddress, DropoffAddress, FoodDeliveryStatus)
VALUES (1, 'Tehran, Valiaser St, Restaurant', 'Tehran, Vanak, Costumer', 'Pending');*/

/*Testing Inserted Datas
Select * From Food.Users;
Select * From Food.Restaurants;
Select * From Food.Categories;
Select * From Food.Coupons;
Select * From Food.Addresses;
Select * From Food.MenuItems;
Select * From Food.Reviews;
Select * From Food.Orders;
Select * From Food.OrderDetails;
Select * From Food.OrderStatusHistory;
Select * From Food.Payments;
SELECT * FROM Taxi.FoodDeliveries;*/