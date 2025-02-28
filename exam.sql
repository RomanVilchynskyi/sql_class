create database AroundTheWorldIn80Days
use AroundTheWorldIn80Days

create table Employees (
    Id int primary key,
    FullName nvarchar(255) not null,
    Position nvarchar(100) not null,
    Phone nvarchar(20),
    Email nvarchar(100),
    HireDate date not null
)

insert into Employees (Id, FullName, Position, Phone, Email, HireDate)
values 
(1, 'John Doe', 'Manager', '123-456-7890', 'johndoe@example.com', '2023-01-15'),
(2, 'Jane Smith', 'Tour Coordinator', '987-654-3210', 'janesmith@example.com', '2022-06-10'),
(3, 'Michael Johnson', 'Sales Representative', '555-123-4567', 'michaelj@example.com', '2021-09-23');

create table Clients (
    Id int primary key,
    FullName nvarchar(255) not null,
    Phone nvarchar(20),
    Email nvarchar(100),
    BirthDate date not null
)

insert into Clients (Id, FullName, Phone, Email, BirthDate)
values 
(1, 'Alice Green', '555-234-5678', 'alicegreen@example.com', '1985-04-21'),
(2, 'Bob White', '555-345-6789', 'bobwhite@example.com', '1992-11-10'),
(3, 'Charlie Black', '555-456-7890', 'charlieblack@example.com', '1987-02-28'),
(4, 'David Blue', '555-567-8901', 'davidblue@example.com', '2000-05-14');


create table Tours (
    Id int primary key,
    Name nvarchar(255) not null,
    Price int not null,
    StartDate date not null,
    EndDate date not null,
    Transport nvarchar(100),
    MaxTourists int not null,
    EmployeeId int,
    foreign key (EmployeeId) references Employees(Id)
)

insert into Tours (Id, Name, Price, StartDate, EndDate, Transport, MaxTourists, EmployeeId)
values 
(1, 'European Adventure', 1500, '2023-07-01', '2023-07-14', 'Bus, Train', 30, 1),
(2, 'Tropical Paradise', 2500, '2023-08-05', '2023-08-12', 'Flight', 50, 2),
(3, 'American Road Trip', 2000, '2023-06-15', '2023-06-30', 'Car, Flight', 40, 3);

create table TourCountries (
    TourId int,
    Country nvarchar(100) not null,
    City nvarchar(100) not null,
    VisitDate date not null,
    foreign key (TourId) references Tours(Id)
)

insert into TourCountries (TourId, Country, City, VisitDate)
values 
(1, 'Germany', 'Berlin', '2023-07-02'),
(3, 'France', 'Paris', '2023-07-05'),
(2, 'Brazil', 'Rio de Janeiro', '2023-08-06'),
(1, 'Argentina', 'Buenos Aires', '2023-08-08'),
(1, 'USA', 'New York', '2023-06-16'),
(2, 'USA', 'Los Angeles', '2023-06-20')

create table TourSights (
    Id int primary key,
    Name nvarchar(255) not null,
    Included int not null, 
    ExtraCost int default(0),  
    TourId int,
    foreign key (TourId) references Tours(Id)
)

insert into TourSights (Id, Name, Included, ExtraCost, TourId)
values 
(1, 'Brandenburg Gate', 1, 0, 2),
(2, 'Eiffel Tower', 1, 0, 3),
(3, 'Christ the Redeemer', 1, 0, 2),
(4, 'Iguazu Falls', 1, 100, 1),
(5, 'Statue of Liberty', 1, 0, 1),
(6, 'Hollywood Sign', 1, 0, 3);

create table TourHotels (
    Id int primary key,
    Name nvarchar(255) not null,
    TourId int,
    foreign key (TourId) references Tours(Id)
)

insert into TourHotels (Id, Name,TourId)
values 
(1, 'Berlin Marriott Hotel', 1),
(2, 'Hotel Le Meurice Paris', 3),
(3, 'Hotel Fasano Rio de Janeiro', 2),
(4, 'Gran Melia Iguazu Hotel', 3),
(5, 'The Langham New York', 2),
(6, 'The Hollywood Roosevelt Hotel', 1);

create table TourClients (
    TourId int,
    ClientId int,
    foreign key (TourId) references Tours(Id),
    foreign key (ClientId) references Clients(Id)
)

insert into TourClients (TourId, ClientId)
values 
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 1),
(3, 2);

create table ArchivedTours (
    Id int primary key,
    Name nvarchar(255) not null,
    Price int not null,
    StartDate date not null,
    EndDate date not null,
    Transport nvarchar(100),
    MaxTourists int not null,
    EmployeeId int,
    ArchiveDate datetime default getdate(),
    foreign key (EmployeeId) references Employees(Id)
)


select * 
from Employees

select * 
from Clients
select * 
from Tours
select * 
from TourCountries
select * 
from TourSights
select * 
from TourHotels




create or alter view ActualTours 
as
select *
from Tours
where EndDate >= CAST(GETDATE() as date)

select * 
from ActualTours


create or alter proc ToursByCountry
    @Country nvarchar(100)
as
begin
    select t.*
    from Tours t
    join TourCountries tc on t.Id = tc.TourId
    where tc.Country = @Country
end;

exec ToursByCountry 'USA'

create or alter view PopularCountries 
as
select top 1 Country
from TourCountries
group by Country
order by COUNT(*) desc

select * 
from PopularCountries

create or alter view PopularActualTour 
as
select t.*
from Tours t
where t.Id = (
    select top 1 t2.Id
    from Tours t2
    join TourClients tc on t2.Id = tc.TourId
    where t2.EndDate >= CAST(GETDATE() as date)
    group by t2.Id
    order by COUNT(tc.ClientId) desc
)

select *
from PopularActualTour

create or alter view PopularArchivedTour as
select top 1 t.*
from ArchivedTours t
join TourClients tc on t.Id = tc.TourId
group by t.Id, t.Name, t.Price, t.StartDate, t.EndDate, t.Transport, t.MaxTourists, t.EmployeeId
order by count(tc.ClientId) desc

select *
from PopularArchivedTour

create or alter view LeastPopularActualTour 
as
select t.*
from Tours t
where t.Id = (
    select top 1 t2.Id
    from Tours t2
    join TourClients tc on t2.Id = tc.TourId
    where t2.EndDate >= CAST(GETDATE() as date)
    group by t2.Id
    order by COUNT(tc.ClientId) asc
)

select * from LeastPopularActualTour


create or alter proc ToursByClientName
    @FullName nvarchar(255)
as
begin
    select t.*
    from Tours t
    join TourClients tc on t.Id = tc.TourId
    join Clients c on tc.ClientId = c.Id
    where c.FullName = @FullName
end

exec ToursByClientName 'Alice Green'

create or alter function IsClientInTour
    (@FullName nvarchar(255))
returns bit
as
begin
    declare @Result bit
    if exists (
        select 1
        from Tours t
        join TourClients tc on t.Id = tc.TourId
        join Clients c on tc.ClientId = c.Id
        where c.FullName = @FullName and t.StartDate <= GETDATE() and t.EndDate >= GETDATE()
    )
    begin
        set @Result = 1
    end
    else
    begin
        set @Result = 0
    end;
    return @Result
end;

select dbo.IsClientInTour('Alice Green')


create or alter proc ClientLocation
    @FullName nvarchar(255)
as
begin
    declare @TourId int;
    select @TourId = t.Id
    from Tours t
    join TourClients tc on t.Id = tc.TourId
    join Clients c on tc.ClientId = c.Id
    where c.FullName = @FullName and t.StartDate <= GETDATE() and t.EndDate >= GETDATE()

    if @TourId is null
    begin
        raiserror('Client is not in a tour', 16, 1)
        return
    end
    else
    begin
        select tc.TourId, tc.Country, tc.City, tc.VisitDate
        from TourCountries tc
        where tc.TourId = @TourId and tc.VisitDate <= GETDATE()
    end
end

exec ClientLocation 'Bob White'


create or alter view ActiveClient 
as
select c.*
from Clients c
where c.Id = (
    select top 1 c2.Id
    from Clients c2
    join TourClients tc on c2.Id = tc.ClientId
    group by c2.Id
    order by Count(tc.TourId) desc
)

select * 
from ActiveClient


create or alter proc ToursByTransport
    @Transport nvarchar(100)
as
begin
    select Id, Name,  Price, StartDate, EndDate, Transport, MaxTourists, EmployeeId
    from Tours
    where Transport = @Transport
end

exec ToursByTransport 'Flight'

create or alter trigger CheckClientExists
on Clients
after insert
as
begin
    if exists (
        select 1
        from Clients
        where FullName in (select FullName from inserted)
        and Id not in (select Id from inserted)
    )
    begin
        raiserror('Client with the same FullName already exists', 16, 1)
        rollback transaction
        return
    end
end

insert into Clients (Id, FullName, Phone, Email, BirthDate)
values (8, 'Alice Green', '555-234-5678', 'alicegreen@example.com', '1985-04-21')


create or alter trigger ArchivePastTours
on Tours
after update
as
begin
    insert into ArchivedTours (Id, Name, Price, StartDate, EndDate, Transport, MaxTourists, EmployeeId)
    select Id, Name, Price, StartDate, EndDate, Transport, MaxTourists, EmployeeId
    from inserted
    where EndDate < getdate()

    delete from Tours
    where Id in (select Id from inserted) and EndDate < getdate()
end

update Tours
set EndDate = '2023-01-01'
where Id = 4

create or alter view PopularHotel 
as
select top 1 th.Id, th.Name, th.TourId
from TourHotels th
join Tours t on th.TourId = t.Id
join TourClients tc on t.Id = tc.TourId
group by th.Id, th.Name, th.TourId
order by COUNT(tc.ClientId) desc

select * from PopularHotel

create or alter trigger CheckTourCapacity
on TourClients
instead of insert
as
begin
    declare @TourId int
    declare @MaxTourists int
    declare @CurrentTourists int
    declare @ClientId int

    select @TourId = TourId, @ClientId = ClientId 
	from inserted
    select @MaxTourists = MaxTourists 
	from Tours 
	where Id = @TourId
    select @CurrentTourists = COUNT(*) 
	from TourClients 
	where TourId = @TourId

    if @CurrentTourists >= @MaxTourists
    begin
        raiserror('Maximum tour capacity reached', 16, 1)
        return
    end
    else
    begin
        insert into TourClients (TourId, ClientId)
        select TourId, ClientId from inserted
    end
end

select COUNT(*) 
from TourClients 
where TourId = 1