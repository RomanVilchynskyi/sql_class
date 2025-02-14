use Academy


create table Students
(
	Id int primary key identity(1,1),
	[Name] nvarchar(50) NOT NULL check([Name] <> ''),
	Surname nvarchar(50) not null check(Surname <> ''),
	Email varchar(30) not null unique,
	Birthdate date not null check(Birthdate < getdate()), -- getdate() - повертає поточну дату
	AverageMark real null check(AverageMark between 1 and 12), -- AverageMark >= 1 and AverageMark <= 12
	IsDebtor bit not null default(0),
	Lessons int not null default(0) check(Lessons >= 0),
	NonAttendances int not null default(0) check(NonAttendances >= 0),
	Visitings as Lessons - NonAttendances,
	check(NonAttendances <= Lessons)
)


insert into Students (Name, Surname, Email, Birthdate, AverageMark, IsDebtor, Lessons, NonAttendances) values ('Alix', 'Hinstridge', 'ahinstridge0@shinystat.com', '2006/06/29', 2.7, 1, 243, 105);
insert into Students (Name, Surname, Email, Birthdate, AverageMark, IsDebtor, Lessons, NonAttendances) values ('Raimund', 'Scini', 'rscini1@xing.com', '2004/02/29', 1.8, 1, 295, 81);
insert into Students (Name, Surname, Email, Birthdate, AverageMark, IsDebtor, Lessons, NonAttendances) values ('Durant', 'McPhaden', 'dmcphaden2@linkedin.com', '2022/01/24', 7.3, 0, 216, 133);
insert into Students (Name, Surname, Email, Birthdate, AverageMark, IsDebtor, Lessons, NonAttendances) values ('Dilan', 'Cowen', 'dcowen3@businesswire.com', '2001/06/05', 10.4, 1, 237, 3);
insert into Students (Name, Surname, Email, Birthdate, AverageMark, IsDebtor, Lessons, NonAttendances) values ('Tami', 'Huzzey', 'thuzzey4@howstuffworks.com', '2002/12/10', 6.6, 0, 211, 28);
insert into Students (Name, Surname, Email, Birthdate, AverageMark, IsDebtor, Lessons, NonAttendances) values ('Brendin', 'Barrs', 'bbarrs5@businessweek.com', '2009/07/13', 10.5, 1, 227, 31);
insert into Students (Name, Surname, Email, Birthdate, AverageMark, IsDebtor, Lessons, NonAttendances) values ('Daisy', 'Spaducci', 'dspaducci6@columbia.edu', '2020/12/08', 9.0, 0, 255, 58);
insert into Students (Name, Surname, Email, Birthdate, AverageMark, IsDebtor, Lessons, NonAttendances) values ('Erl', 'Baytrop', 'ebaytrop7@linkedin.com', '2011/12/26', 1.3, 0, 240, 48);
insert into Students (Name, Surname, Email, Birthdate, AverageMark, IsDebtor, Lessons, NonAttendances) values ('Cary', 'Quartermaine', 'cquartermaine8@nbcnews.com', '2004/07/06', 1.8, 0, 267, 179);
insert into Students (Name, Surname, Email, Birthdate, AverageMark, IsDebtor, Lessons, NonAttendances) values ('Alfredo', 'Rizzone', 'arizzone9@youtube.com', '2002/03/04', 3.7, 0, 293, 152);

select * from Students

select [Name]+' ' + Surname as 'Full Name', AverageMark * 10 as 'Mark'
from Students

select 'Students ' + Surname + ' has ' + CAST(AverageMark as nvarchar) as 'Students marks'
from Students

select 'Students ' + Surname + ' has ' + CONVERT(nvarchar, AverageMark) as 'Students marks'
from Students

select top 5 *
from Students

select top 65 percent *
from Students

select distinct IsDebtor
from Students

create table Groups
(
	Id int primary key identity(1,1),
	Name nvarchar(50) unique not null
)

insert into Groups
values
	('PD421'),
	('PV421'),
	('PD321'),
	('PV321')
select * from Groups

select Surname, s.Name ,g.Id
from Students as s, Groups as g


select *
from Students
where IsDebtor = 1

select *
from Students
where AverageMark >= 10

select *
from Students
where MONTH(Birthdate)>= 6 and MONTH(Birthdate) <= 8

select *
from Students
where MONTH(Birthdate)between 6 and 8

select *
from Students
where MONTH(Birthdate) = 1 or MONTH(Birthdate) = 2 or MONTH(Birthdate) = 12

select *
from Students
where MONTH(Birthdate) in (1,2,12)

select *
from Students
where Name like 'A%' 

select *
from Students
where Name like 'A%o' 

select *
from Students
where Email like '%@xing.com' 

select *
from Students
where Name like '%a_' 

select *
from Students
where Name like '[aoiuye]%[^aoiuye]' 

select *
from Students
where Name COLLATE Latin1_General_BIN like '[A-D]%' 

select *
from Students
where Name COLLATE Latin1_General_BIN like '[A-D]%' 
order by Name Asc

select *
from Students
where Name COLLATE Latin1_General_BIN like '[A-D]%' 
order by Name Asc, Surname Desc

select *
from Students
where Name COLLATE Latin1_General_BIN like '[A-D]%' 
order by IsDebtor Asc, AverageMark


update Students
set 
	AverageMark += 1,
	Name = 'Stepan'
where Name = 'Semen'

delete from Students
where IsDebtor = 1

----------------------------------------------------------

create database Hospital

use Hospital

create table Departments
(
	Id int primary key identity(1,1),
	Building int not null check(Building between 1 and 5),
	Financing money not null default(0) check(Financing > 0),
	[Floor] int not null check([Floor] >= 1),
	[Name] nvarchar(100) not null check([Name] <> '') unique
)
drop table Departments
insert into Departments (Building, Financing, [Floor], [Name]) values (5, 21378, 5, 'Ezmeralda');
insert into Departments (Building, Financing, [Floor], [Name]) values (3, 15110, 1, 'Agata');
insert into Departments (Building, Financing, [Floor], [Name]) values (1, 23152, 5, 'Kristoffer');
insert into Departments (Building, Financing, [Floor], [Name]) values (3, 23546, 5, 'Zea');
insert into Departments (Building, Financing, [Floor], [Name]) values (3, 19455, 5, 'Rivi');

create table Diseases
(
	Id int primary key identity(1,1),
	[Name] nvarchar(100) not null check([Name] <> ''),
	Severity int not null default(1) check(Severity >= 1) 
)
drop table Diseases
insert into Diseases ([Name], Severity) values ('Rak', 1);
insert into Diseases ([Name], Severity) values ('COVID-19', 1);
insert into Diseases ([Name], Severity) values ('Stroke', 3);
insert into Diseases ([Name], Severity) values (' yellowFever', 3);
insert into Diseases ([Name], Severity) values ('malaria', 3);

create table Doctors
(
	Id int primary key identity(1,1),
	[Name] nvarchar(max) not null check([Name] <> ''),
	Phone char(10) not null,
	Premium money not null default(0) check(Premium > 0),
	Salary money not null check(Salary >= 0),
	Surname nvarchar(max) not null check(Surname <> '')
)
drop table Doctors
insert into Doctors ([Name], Phone, Premium, Salary, Surname) values ('Ty', 346393179, '12.20', '13211.85', 'Ellesworthe');
insert into Doctors ([Name], Phone, Premium, Salary, Surname) values ('Stephana', 429860437, '96.40', '12666.29', 'Havile');
insert into Doctors ([Name], Phone, Premium, Salary, Surname) values ('Zebulon', 813254376, '65.51', '7288.46', 'Wildbore');
insert into Doctors ([Name], Phone, Premium, Salary, Surname) values ('Arie', 165387690, '55.10', '13409.70', 'Goodacre');
insert into Doctors ([Name], Phone, Premium, Salary, Surname) values ('Edie', 313124387, '15.75', '11370.36', 'Penrose');

create table Examination 
(
	Id int primary key identity(1,1),
	[DayOfWeek] int not null check([DayOfWeek] between 1 and 7),
	EndTime time not null,
	[Name] nvarchar(100) not null check([Name] <> '') unique,
	StartTime time not null check(StartTime between '8:00' and '18:00'),
	check(EndTime > StartTime)
)

insert into Examination ([DayOfWeek], EndTime, [Name], StartTime) values (1, '10:47', 'Chickie', '12:52');
insert into Examination ([DayOfWeek], EndTime, [Name], StartTime) values (5, '3:25', 'Randell', '9:06');
insert into Examination ([DayOfWeek], EndTime, [Name], StartTime) values (7, '5:54', 'Rubia', '4:38');
insert into Examination ([DayOfWeek], EndTime, [Name], StartTime) values (1, '2:24', 'Christin', '1:59');
insert into Examination ([DayOfWeek], EndTime, [Name], StartTime) values (7, '10:12', 'Naoma', '9:29');

select * 
from Departments
select * 
from Diseases
select * 
from Doctors

select Surname + ' ' + Phone as  'Surname and Phone'
from Doctors

select distinct [FLOOR]
from Departments

select [Name] + ' of disease' + Cast(Severity as nvarchar) + ' of disease'
from Diseases

select *
from Departments
where Building = 5 and Financing < 30000

select *
from Departments
where Building = 3 and Financing between 12000 and 15000

