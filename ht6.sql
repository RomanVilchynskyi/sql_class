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


create view DoctorsList 
as
select Id, Surname, Name, Premium, Salary
from Doctors

select * 
from DoctorsList

create view CardiologyWards 
as
select w.Id, w.Name as WardName, w.Places, d.Name as DepartmentName
from Wards w
join Departments d on w.DepartmentId = d.Id
where d.Name = 'Cardiology'

select * 
from CardiologyWards

create view TopDoctorByExaminations 
as
select TOP 1 d.Id, d.Surname, d.Name, COUNT(de.Id) as ExaminationCount
from DoctorsExaminations de
join Doctors d on de.DoctorId = d.Id
group by d.Id, d.Surname, d.Name
order by COUNT(de.Id) desc

select *
from TopDoctorByExaminations


create view Top3DoctorsByPremium 
as
select top 3 Id, Surname, Name, Premium
from Doctors
order by Premium desc
 
select *
from Top3DoctorsByPremium


create view DoctorWithTheHighestSalary 
as
select top 1 Id, Surname, Name, Salary
from Doctors
order by Salary desc

select *
from DoctorWithTheHighestSalary