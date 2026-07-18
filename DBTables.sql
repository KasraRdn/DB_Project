CREATE SCHEMA Food;

CREATE TABLE Food.Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    Password NVARCHAR(100) NOT NULL
);

CREATE TABLE Food.Restaurants (
    RestaurantID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Address NVARCHAR(250) NOT NULL,
    IsActive BIT DEFAULT 1
);

CREATE TABLE Food.Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(50) NOT NULL
);

CREATE TABLE Food.Coupons (
    CouponID INT IDENTITY(1,1) PRIMARY KEY,
    Code VARCHAR(20) UNIQUE NOT NULL,
    DiscountPercent DECIMAL(5,2) NOT NULL,
    IsActive BIT DEFAULT 1
);

CREATE TABLE Food.SystemLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    TableName NVARCHAR(50) NOT NULL,
    Action NVARCHAR(50) NOT NULL,
    Description NVARCHAR(MAX),
    LogDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Food.Addresses (
    AddressID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Street NVARCHAR(50) NOT NULL,
    PostalCode VARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES Food.Users(UserID)
);

CREATE TABLE Food.MenuItems (
    ItemID INT IDENTITY(1,1) PRIMARY KEY,
    RestaurantID INT NOT NULL,
    CategoryID INT NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    IsAvailable BIT DEFAULT 1,
    FOREIGN KEY (RestaurantID) REFERENCES Food.Restaurants(RestaurantID),
    FOREIGN KEY (CategoryID) REFERENCES Food.Categories(CategoryID)
);

CREATE TABLE Food.Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    RestaurantID INT NOT NULL,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    Comment NVARCHAR(250),
    FOREIGN KEY (UserID) REFERENCES Food.Users(UserID),
    FOREIGN KEY (RestaurantID) REFERENCES Food.Restaurants(RestaurantID)
);

CREATE TABLE Food.Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    RestaurantID INT NOT NULL,
    AddressID INT NOT NULL,
    CouponID INT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Food.Users(UserID),
    FOREIGN KEY (RestaurantID) REFERENCES Food.Restaurants(RestaurantID),
    FOREIGN KEY (AddressID) REFERENCES Food.Addresses(AddressID),
    FOREIGN KEY (CouponID) REFERENCES Food.Coupons(CouponID)
);

CREATE TABLE Food.OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Food.Orders(OrderID),
    FOREIGN KEY (ItemID) REFERENCES Food.MenuItems(ItemID)
);

CREATE TABLE Food.OrderStatusHistory (
    HistoryID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    ChangeDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (OrderID) REFERENCES Food.Orders(OrderID)
);

CREATE TABLE Food.Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    IsSuccessful BIT DEFAULT 0,
    PaymentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (OrderID) REFERENCES Food.Orders(OrderID)
);

CREATE TABLE Food.TaxiFoodDeliveries (
    FoodDeliverId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL REFERENCES Food.Orders(OrderID),
    PickupAddress NVARCHAR(255) NOT NULL,
    DropoffAddress NVARCHAR(255) NOT NULL,
    FoodDeliveryStatus NVARCHAR(20) DEFAULT 'Pending'
);