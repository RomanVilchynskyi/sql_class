create database Hospital

use Hospital

create table Departments
(
    Id int primary key not null identity(1,1),
    Building int not null check(Building between 1 and 5),
    [Name] nvarchar(100) not null check([Name] <> '') unique
)

insert into Departments (Building, [Name]) 
values 
(1, 'Cardiology '),
(3, 'Neurology '),
(5, 'Orthopedics '),
(2, 'Pediatrics '),
(4, 'Gastroenterology ');
drop table Departments
create table Doctors
(
    Id int primary key not null identity(1,1),
    [Name] nvarchar(max) not null check([Name] <> ''),
    Premium money not null default(0) check(Premium >= 0),
    Salary money not null check(Salary > 0),
    Surname nvarchar(max) not null check(Surname <> '')
)

insert into Doctors ([Name], Premium, Salary, Surname) 
values 
('Ty', 12.20, 13211.85, 'Ellesworthe'),
('Stephana', 96.40, 12666.29, 'Havile'),
('Zebulon', 65.51, 7288.46, 'Wildbore'),
('Arie', 55.10, 13409.70, 'Goodacre'),
('Edie', 15.75, 11370.36, 'Penrose')

create table Examinations
(
    Id int primary key not null identity(1,1),
    [Name] nvarchar(100) not null check([Name] <> '') unique
)

insert into Examinations ([Name]) 
values 
('Mathematics'),
('Physics'),
('Chemistry'),
('Biology'),
('Computer Science');

create table Sponsors
(
    Id int primary key not null identity(1,1),
    [Name] nvarchar(100) not null check([Name] <> '') unique
)

insert into Sponsors ([Name]) 
values 
('Oleg'),
('Vitalik'),
('Denis'),
('Evhen');

create table Wards
(
    Id int primary key not null identity(1,1),
    [Name] nvarchar(20) not null check([Name] <> '') unique,
    Places int not null check(Places > 0),
    DepartmentId int not null,
    foreign key(DepartmentId) references Departments(Id)
)

insert into Wards ([Name], Places, DepartmentId)
values 
('101', 3, 1),
('102', 5, 1),
('201', 4, 2),
('202', 2, 2);
drop table Wards
create table DoctorsExaminations
(
    Id int primary key identity(1,1),
    EndTime time not null,
    StartTime time not null check(StartTime between '08:00' and '18:00'),
    DoctorId int not null,
    ExaminationId int not null,
    WardId int not null,
    foreign key (DoctorId) references Doctors(Id),
    foreign key (ExaminationId) references Examinations(Id),
    foreign key (WardId) references Wards(Id),
    check(EndTime > StartTime)
)

insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId)
values 
('09:30', '08:00', 1, 1, 1),
('12:00', '10:15', 2, 2, 2),
('14:00', '13:00', 3, 3, 3),
('17:00', '15:30', 4, 4, 4),
('18:00', '17:00', 5, 5, 1)
drop table DoctorsExaminations
create table Donations
(
    Id int primary key not null identity(1,1),
    Amount money not null check(Amount > 0),
    [Date] date not null default(getdate()) check([Date] <= getdate()),
    DepartmentId int not null,
    SponsorId int not null,
    foreign key(DepartmentId) references Departments(Id),
    foreign key(SponsorId) references Sponsors(Id)
)

insert into Donations (Amount, [Date], DepartmentId, SponsorId)
values 
(1500.00, '2025-02-01', 1, 1),
(2500.00, '2025-02-10', 2, 2),
(1000.00, '2025-02-15', 3, 3)

drop table Donations

select * from Departments
select * from Doctors
select * from DoctorsExaminations
select * from Donations
select * from Examinations
select * from Sponsors
select * from Wards

select d.[Name]
from Departments d
where d.Building = (
    select Building
    from Departments
    where [Name] = 'Cardiology'
)

select d.[Name]
from Departments d
where d.Building IN (
    select Building
    from Departments
    where [Name] IN ('Gastroenterology', 'Surgery')
)

select d.[Name]
from Departments d
join Donations dn on d.Id = dn.DepartmentId
group by d.[Name]
order by SUM(dn.Amount) ASC

select d.Surname
from Doctors d
where d.Salary > (
    select Salary
    from Doctors
    where [Name] = 'Ty' AND Surname = 'Ellesworthe'
)

select w.[Name]
from Wards w
where w.Places > (
    select AVG(w2.Places)
    from Wards w2
    join Departments d on w2.DepartmentId = d.Id
    where d.[Name] = 'Cardiology'
)

select d.[Name], d.Surname
from Doctors d
where (d.Salary + d.Premium) > (
    select (d2.Salary + d2.Premium + 100)
    from Doctors d2
    where d2.[Name] = 'Ty' AND d2.Surname = 'Ellesworthe'
)

select d.[Name]
from Departments d
join Wards w on d.Id = w.DepartmentId
join DoctorsExaminations de on w.Id = de.WardId
where de.DoctorId = (
    select Id
    from Doctors
    where [Name] = 'Ty' AND Surname = 'Ellesworthe'
)