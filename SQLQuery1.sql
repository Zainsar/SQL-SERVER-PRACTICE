create database Practical;


-- create table customer

create table Customers (
CustomerID int primary key,
FirstName varchar(255),
LastName varchar(255),
Email varchar(255),
PhoneNumber bigint

)


  
insert into Customers (CustomerID, FirstName,LastName,Email,PhoneNumber) values 
(1,'Muhammad', 'Talha', 'talha@gmail.com', 03322445566),
(2,'Ali', 'Khan', 'ali@gmail.com', 08822445566),
(3,'Muhammad', 'Saad', 'saad@gmail.com', 05522445566),
(4,'Muhammad', 'Talha', 'kashif@gmail.com', 06622445566),
(5,'Tahir', 'Ahmed', 'tahir@gmai.com', 07722445566),
(6,'Aliyan', 'khan', 'aliyan@gmail.com', 08822445566),
(7,'Danish', 'rustam', 'danish@gmail.com', 09922445566),
(8,'Syed', 'daniyal', 'daniyal@gmail.com', 02522445566),
(9,'Bazil', 'Ali', 'bazil@gmail.com', 07522445566),
(10,'Abdul', 'Hadi', 'hadi@gmail.com', 09922445566)


select * from Customers

-- create table orders
create table Orders (
OrderID int primary key,
CustomerID int ,
OrderDate bigint,
TotalAmmount int, 
Foreign key(CustomerID) references Customers(CustomerID)
)

insert into Orders (OrderID,CustomerID,OrderDate,TotalAmmount) values 
(1,1, 2006-9-30 , 1000),
(2,2,2007-9-1 , 2000),
(3,3,2008-9-2 , 3000),
(4,4,2009-9-3 , 4000),
(5,5,2010-9-4 , 5000),
(6,6,2010-9-5 , 6000),
(7,7,2011-9-6 , 7000),
(8,8,2012-9-7 , 8000),
(9,9,2013-9-8 , 9000),
(10,10,2014-9-9 , 10000)

select * from Orders

 -- create table names Products
 create table products(
 ProductID int primary key,
 ProductName varchar(255),
 UnitPrice bigint,
 StockQuantity bigint

 )

 insert into products (ProductID,ProductName,UnitPrice,StockQuantity) values 
 (1,'Pasta', 100, 200),
(2,'Pizza', 200, 300),
(3,'Burger', 300, 400),
(4,'ZingerBurger', 400, 500),
(5,'ChickenBurger', 500, 600),
(6,'BeefBurger', 600, 700),
(7,'MuttonBurger', 700, 800),
(8,'FrenchFries', 800, 900),
(9,'Roll', 900, 1000),
(10,'Samosas', 1000, 1100)

select * from products

create table orderDetails (
OrderDetailsID int not null identity,
OrderID int not null,
ProductID int,
Quantity int not null,
UnitPrice int not null,
Foreign key(ProductID) references products(ProductID),
Foreign key(OrderID) references Orders(OrderID) 
)

  
  
 insert into orderDetails(OrderID,ProductID,Quantity,UnitPrice) values 
 (1,1, 10, 1000),
(2,2,20 , 2000),
(3,3,30 , 3000),
(4,4,40 , 4000),
(5,5,50 , 5000),
(6,6,60 , 6000),
(7,7,70, 7000),
(8,8,50, 8000),
(9,9,70, 9000),
(10,10,100, 10000)

select * from orderDetails

--1
create login OrderClerk with password = 'order'
create user OrderClerk for login OrderClerk
grant insert,update on dbo.orders to OrderClerk

--2









 