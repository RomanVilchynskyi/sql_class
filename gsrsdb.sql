create database sports_store
use sports_store

create table Products (
    Id int primary key identity(1,1),
    Name nvarchar(255) not null,
    Quantity int not null,
    CostPrice float not null,
    Manufacturer nvarchar(255) not null,
    SalePrice float not null
)

INSERT INTO Products (Name, Quantity, CostPrice, Manufacturer, SalePrice)
VALUES 
    ('Basketball', 20, 15.9, 'Nike', 29.9),
    ('Tennis Racket', 10, 45.5, 'Wilson', 79.9),
    ('Running Shoes', 30, 40.0, 'Adidas', 89.9);

create table Clients (
    Id int primary key identity(1,1),
    FullName nvarchar(255) not null,
    Email nvarchar(255) unique not null,
    Phone nvarchar(20) not null,
    DiscountPercentage int default(0)
)

INSERT INTO Clients (FullName, Email, Phone, DiscountPercentage)
VALUES 
    ('John Smith', 'john.smith@email.com', '123-456-7890', 5),
    ('Emily Johnson', 'emily.j@email.com', '987-654-3210', 10),
    ('Michael Brown', 'michael.b@email.com', '555-666-7777', 0);

create table Sales (
    Id int primary key identity(1,1),
    SalePrice float not null,
    Quantity int not null,
    SaleDate date not null,
    ProductId int not null,
    ClientId int,
    foreign key (ProductId) references Products(Id),
    foreign key (ClientId) references Clients(Id)
)

INSERT INTO Sales (SalePrice, Quantity, SaleDate, ProductId, ClientId)  
VALUES  
    (29.99, 2, '2024-03-01', 1, 1),   
    (79.99, 1, '2024-02-28', 2, 2),
    (89.99, 1, '2024-03-02', 3, NULL);   
  


create table SalesHistory (
    Id int primary key identity(1,1),
    SalePrice float not null,
    Quantity int not null,
    SaleDate date not null,
    ProductId int not null,
    ClientId int,
    foreign key (ProductId) references Products(Id),
    foreign key (ClientId) references Clients(Id)
)

create table Archive (
    Id int primary key identity(1,1),
    Name nvarchar(255) not null,
    Manufacturer nvarchar(255) not null
)


create or alter trigger tg_Sales_AfterInsert
on Sales
after insert
as
begin
    insert into SalesHistory (SalePrice, Quantity, SaleDate, ProductId, ClientId)
    select SalePrice, Quantity, SaleDate, ProductId, ClientId
    from inserted
end

INSERT INTO Sales (SalePrice, Quantity, SaleDate, ProductId, ClientId)
VALUES (29.99, 2, '2024-03-04', 1, 1)

create or alter trigger trg_Sales_AfterUpdate
on Sales
after update
as
begin
    declare @ProductId int
    declare @Quantity int
    
    select @ProductId = ProductId, @Quantity = Quantity from inserted
    
    if @Quantity = 0
    begin

        insert into Archive (Name, Manufacturer)
        select Name, Manufacturer
        from Products
        where Id = @ProductId

        update Products
        set Quantity = 0
        where Id = @ProductId
    end
end

update Sales
set Quantity = 0
WHERE Id = 1


create or alter trigger tg_Clients_AfterInsert
on Clients
after insert
as
begin
    declare @Email nvarchar(255)
    
    select @Email = Email from inserted
    
    if exists(select 1 from Clients where Email = @Email)
    begin
        raiserror('Client with that email already exists', 16, 1)
        rollback transaction
    end
end

INSERT INTO Clients (FullName, Email, Phone, DiscountPercentage)
VALUES ('Anna White', 'john.smith@email.com', '123-123-1234', 5)

create or alter trigger tg_Clients_BeforeDelete
on Clients
instead of delete
as
begin
    raiserror('Cannot delete that account', 16, 1)
    rollback transaction
end

delete from Clients
where Id = 1

create or alter trigger tg_Sales_AfterInsert_UpdateDiscount
on Sales
after insert
as
begin
    declare @ClientId int
    declare @TotalSpent float

    select @ClientId = ClientId from inserted
    
    select @TotalSpent = SUM(SalePrice * Quantity)
    from Sales
    where ClientId = @ClientId

    if @TotalSpent > 50000
    begin
        update Clients
        set DiscountPercentage = 15
        where Id = @ClientId
    end
end

INSERT INTO Sales (SalePrice, Quantity, SaleDate, ProductId, ClientId)
VALUES (20000, 1, '2024-03-05', 1, 1);

create or alter trigger tg_Products_BeforeInsert
on Products
instead of insert
as
begin
    declare @Manufacturer nvarchar(255)
    
    select @Manufacturer = Manufacturer from inserted
    
    if @Manufacturer = 'Nike' 
    begin
        raiserror('Cannot add goods with that manufacturer', 16, 1)
        rollback transaction
    end
    
    insert into Products (Name, Quantity, CostPrice, Manufacturer, SalePrice)
    select Name, Quantity, CostPrice, Manufacturer, SalePrice from inserted
end

INSERT INTO Products (Name, Quantity, CostPrice, Manufacturer, SalePrice)
VALUES ('Sneakers', 10, 50.0, 'Nike', 100.0);

create or alter trigger tg_Sales_BeforeInsert
on Sales
instead of insert
as
begin
    declare @ProductId int
    declare @Quantity int
    declare @AvailableQuantity int

    select @ProductId = ProductId, @Quantity = Quantity from inserted
    
    select @AvailableQuantity = Quantity from Products where Id = @ProductId
    
    if @Quantity > @AvailableQuantity
    begin
        raiserror('Not enough goods in stock', 16, 1)
        rollback transaction
    end
    
    insert into Sales (SalePrice, Quantity, SaleDate, ProductId, ClientId)
    select SalePrice, Quantity, SaleDate, ProductId, ClientId from inserted
    
    update Products
    set Quantity = Quantity - @Quantity
    where Id = @ProductId
end


INSERT INTO Sales (SalePrice, Quantity, SaleDate, ProductId, ClientId)
VALUES (29.99, 50, '2024-03-06', 1, 1);