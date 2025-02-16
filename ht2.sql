create database Academy

use Academy

create table Departments
(
	Id int not null primary key identity(1,1),
	Financing money not null default(0) check(Financing <> 0),
	[Name] nvarchar(100) not null check([Name] <> '') unique
)

insert into Departments (Financing, [Name]) values (24998.73, 'ComputerScience');
insert into Departments (Financing, [Name]) values (15331.76, 'EconomicsAndFinance');
insert into Departments (Financing, [Name]) values (11094.45, 'Medicine');
insert into Departments (Financing, [Name]) values (25607.14, 'SoftwareDevelopment');
insert into Departments (Financing, [Name]) values (16540.33, 'Law');

create table Faculties
(
	Id int not null primary key identity(1,1),
	Dean nvarchar(max) not null check(Dean <> ''),
	[Name] nvarchar(100) not null check([Name] <> '') unique
)

insert into Faculties (Dean, [Name]) values ('Raul', 'InformationTechnology');
insert into Faculties (Dean, [Name]) values ('Marilin', 'Business¿ndEconomics');
insert into Faculties (Dean, [Name]) values ('Aldo', 'Medicine');
insert into Faculties (Dean, [Name]) values ('Cassi', 'ComputerSciens');
insert into Faculties (Dean, [Name]) values ('Christophe', 'Law');

create table Groups
(
	Id int not null primary key identity(1,1),
	[Name] nvarchar(100) not null check([Name] <> '') unique,
	Rating int not null check(Rating between 0 and 5),
	[Year] int not null check([Year] between 1 and 5)
)

insert into Groups ([Name], Rating, [Year]) values ('Eben', 4, 5);
insert into Groups ([Name], Rating, [Year]) values ('Lani', 1, 1);
insert into Groups ([Name], Rating, [Year]) values ('Estel', 3, 3);
insert into Groups ([Name], Rating, [Year]) values ('Eachelle', 0, 1);
insert into Groups ([Name], Rating, [Year]) values ('Jamaal', 2, 2);

create table Teachers
(
	Id int not null primary key identity(1,1),
	EmploymentDate date not null check(EmploymentDate !< '1990/01/01'),
	IsAssistant bit not null default(0),
	IsProfessor bit not null default(0),
	[Name] nvarchar(max) not null check([Name] <> ''),
	Position nvarchar(max) not null check(Position <> ''),
	Premium money not null default(0) check(Premium <> 0),
	Salary money not null check(Salary !< 0 and Salary <> 0),
	Surname nvarchar(max) not null check(Surname <> '')
)

insert into Teachers (EmploymentDate, IsAssistant, IsProfessor, [Name], Position, Premium, Salary, Surname) values ('2022/12/15', 1, 0, 'Garrot', 'Manager', 162.02, 1257.51, 'Ballintyne');
insert into Teachers (EmploymentDate, IsAssistant, IsProfessor, [Name], Position, Premium, Salary, Surname) values ('1990/09/01', 1, 1, 'Osgood', 'Developer', 213.78, 983.06, 'Temporal');
insert into Teachers (EmploymentDate, IsAssistant, IsProfessor, [Name], Position, Premium, Salary, Surname) values ('1992/07/28', 1, 0, 'Zia', 'Director', 222.18, 1072.96, 'Ebanks');
insert into Teachers (EmploymentDate, IsAssistant, IsProfessor, [Name], Position, Premium, Salary, Surname) values ('2007/12/16', 1, 0, 'Burnard', 'Developer', 123.81, 647.93, 'Chern');
insert into Teachers (EmploymentDate, IsAssistant, IsProfessor, [Name], Position, Premium, Salary, Surname) values ('2020/04/07', 0, 1, 'Adelaida', 'Manager', 84.35, 565.30, 'Kohlert');
drop table Teachers

select *
from Departments
order by Id  Desc	

select [Name] as 'Group Name', Rating as 'Group Rating'
from Groups

select  Surname,  (Salary / Premium) * 100 as PercentageOfSalaryToPremium,  (Salary / (Salary + Premium)) * 100 as PercentageOfSalaryToTotal  
from Teachers

select 'The dean of faculty ' + [Name] + ' is ' + Dean
from Faculties

select Surname
from Teachers
where IsProfessor = 1 and Salary > 1050

select [Name]
from Departments
where Financing	< 11000 or Financing > 25000

select [Name]
from Faculties
where [Name] <> 'ComputerSciens'

select Surname, Position 
from Teachers
where IsProfessor = 0

select Surname, Position, Salary, Premium
from Teachers
where IsAssistant = 1 and Premium between 160 and 550

select Surname, Salary
from Teachers
where IsAssistant = 1

select Surname, Position
from Teachers
where EmploymentDate > '2000/01/01'

select [Name] as 'Name of Department'
from Departments
where [Name] < 'SoftwareDevelopment'
order by [Name] Asc

select Surname  
from Teachers  
where IsAssistant = 1  and (Salary + Premium) <= 1200

select Name  
from Groups  
where [Year] = 5 and Rating between 2 and 4

select Surname  
from Teachers  
where IsAssistant = 1 and (Salary < 550 or Premium < 200)