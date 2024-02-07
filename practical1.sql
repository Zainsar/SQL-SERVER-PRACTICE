
CREATE DATABASE PRACTICAL

USE PRACTICAL

--Create a table named Customers with columns: CustomerID, FirstName, LastName, Email, and PhoneNumber.
CREATE TABLE CUSTOMERS (
CustomerID int not null unique identity,
FirstName varchar(255),
LastName varchar(255),
Email varchar(255),
PhoneNumber varchar(255)
)

--Insert sample data into the Customers, Products, and Orders tables.
insert into CUSTOMERS (FirstName , LastName , Email , PhoneNumber) values('Zain' , 'Sarfraz' , 'zainsarfraz82@gmail.com' , '03172667345'),
('Sohaib' , 'Sarfraz' , 'sohaibsarfraz82@gmail.com' , '03172667345'),
('Rimsha' , 'Sarfraz' , 'rimshasarfraz82@gmail.com' , '03172667345'),
('Hadi' , 'Muneeer' , 'hadi82@gmail.com' , '03172667345'),
('Mahnoor' , 'Sarfraz' , 'mahnoorsarfraz82@gmail.com' , '03172667345'),
('Abdur' , 'Rehman' , 'rehmansarfraz82@gmail.com' , '03172667345'),
('Mariyum' , 'Muineer' , 'mariyum82@gmail.com' , '03172667345'),
('Waqar' , 'Ali' , 'waqar82@gmail.com' , '03172667345'),
('Taha' , 'Zahid' , 'Taha82@gmail.com' , '03172667345')

--Create a table named Orders with columns: OrderID, CustomerID, OrderDate, and TotalAmount.
CREATE TABLE ORDERS(
OrderID int not null unique identity,
CustomerID int,
OrderDate date,
TotalAmount int
foreign key (CustomerID) references CUSTOMERS(CustomerID)
)

insert into ORDERS (CustomerID, OrderDate, TotalAmount) values(2,'2023-12-13',3400),
(3,'2023-12-15',3000),
(4,'2023-12-18',3400),
(5,'2023-12-17',3600),
(6,'2023-12-14',3600),
(7,'2023-12-15',3400),
(8,'2023-12-11',3080),
(9,'2023-12-12',3060),
(9,'2023-9-13',3080),
(7,'2023-10-13',4700),
(3,'2023-11-13',3350)

--Create a table named OrderDetails with columns: OrderDetailID, OrderID, ProductID, Quantity, and UnitPrice.
CREATE TABLE ORDERDETAILS(
OrderDetailID int not null unique Identity,
OrderId int,
ProductID int,
Quantity int,
UnitPrice decimal(6)
foreign key (OrderID) references ORDERS(OrderID),
foreign key (ProductID) references PRODUCTS(ProductID)
)


--Create a table named Products with columns: ProductID, ProductName, UnitPrice, and InStockQuantity.
CREATE TABLE PRODUCTS(
ProductID int not null unique identity,
ProductName Varchar(255),
UnitPrice varchar(255),
InstockQuantity int
)

insert into PRODUCTS (ProductName,UnitPrice,InstockQuantity) values('Bags','3500',3),
('handcarry','4500',4),
('itar','3500',5),
('perfume','45500',6),
('blet','3500',7),
('mobile','6500',8),
('cars','3300',3),
('toys','3600',4),
('earring','3200',2),
('bangal','35500',5)

--1) Create a new user named Order_Clerk with permission to insert new orders and update order details in the Orders and OrderDetails tables.
create login Sarfraz with Password ='Zain'

create user Order_Clerk for Login Sarfraz
GO
grant insert,update on dbo.ORDERS to Order_Clerk
grant insert,update on dbo.ORDERDETAILS to Order_Clerk

--2) Create a trigger named update_Stock_Audit that logs any updates made to the InStockQuantity column of the Products table into a Stock_Update_Audit table.

CREATE trigger update_Stock_Audit on PRODUCTS 
for Update
as
begin 
print 'someone trying to update'
end

create table Stock_Update_Audit(
stock_Audit Varchar(255)
)

update PRODUCTS SET InStockQuantity ='5' where ProductID = 2

--3) Write a SQL query that retrieves the FirstName, LastName, OrderDate, and TotalAmount of orders along with the customer details by joining the Customers and Orders tables.

SELECT C.FirstName , C.LastName , O.OrderDate , O.TotalAmount from CUSTOMERS as C join ORDERS as O on C.CustomerID = O.CustomerID

--4) Write a SQL query that retrieves the ProductName, Quantity, and TotalPrice of products ordered in orders with a total amount greater than the average total amount of all orders.
SELECT p.ProductName , o.Quantity,count(p.UnitPrice) as TotalPrice FROM PRODUCTS as p join ORDERDETAILS as o on p.ProductID = o.OrderDetailID 