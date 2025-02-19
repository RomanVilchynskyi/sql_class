create database Academy2
use Academy2

create table Curators (
    Id int primary key identity(1,1),
    [Name] nvarchar(max) not null check ([Name] <> ''),
    Surname nvarchar(max) not null check (Surname <> '')
)

insert into Curators ([Name], Surname) values
('Ivan', 'Petrov'),
('Oleg', 'Ivanov'),
('Serhiy', 'Kovalchuk'),
('Andriy', 'Tkachenko'),
('Mykola', 'Shevchenko')

create table Faculties (
    Id int primary key identity(1,1),
    Financing money not null check (Financing >= 0) default(0),
    [Name] nvarchar(100) not null check ([Name] <> '') unique
)

insert into Faculties (Financing, [Name]) values
(100000, 'Computer Science'),
(200000, 'Mathematics'),
(150000, 'Physics'),
(180000, 'Biology'),
(120000, 'Chemistry')

create table Departments (
    Id int primary key identity(1,1),
    Financing money not null check (Financing >= 0) default(0),
    [Name] nvarchar(100) not null check ([Name] <> '') unique,
    FacultyId int not null,
    foreign key (FacultyId) references Faculties(Id)
)

insert into Departments (Financing, [Name], FacultyId) values
(50000, 'Software Engineering', 1),
(70000, 'Data Science', 1),
(60000, 'Applied Mathematics', 2),
(75000, 'Theoretical Physics', 3),
(80000, 'Molecular Biology', 4)

create table Groups (
    Id int primary key identity(1,1),
    [Name] nvarchar(10) not null check ([Name] <> '') unique,
    [Year] int not null check ([Year] between 1 and 5),
    DepartmentId int not null,
    foreign key (DepartmentId) references Departments(Id)
)

insert into Groups ([Name], [Year], DepartmentId) values
('CS101', 1, 1),
('CS202', 2, 1),
('DS301', 3, 2),
('AM401', 4, 3),
('TP501', 5, 4)

create table GroupsCurators (
    Id int primary key identity(1,1),
    CuratorId int not null,
    GroupId int not null,
    foreign key (CuratorId) references Curators(Id),
    foreign key (GroupId) references Groups(Id)
)

insert into GroupsCurators (CuratorId, GroupId) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5)

create table Subjects (
    Id int primary key identity(1,1),
    [Name] nvarchar(100) not null check ([Name] <> '') unique
)

insert into Subjects ([Name]) values
('Programming'),
('Algorithms'),
('Mathematical Analysis'),
('Physics'),
('Biochemistry')

create table Teachers (
    Id int primary key identity(1,1),
    [Name] nvarchar(max) not null check ([Name] <> ''),
    Surname nvarchar(max) not null check (Surname <> ''),
    Salary money not null check (Salary > 0)
)

insert into Teachers ([Name], Surname, Salary) values
('Alex', 'Smith', 3000),
('John', 'Doe', 3200),
('Elena', 'Brown', 2900),
('Michael', 'Johnson', 3100),
('Sophia', 'Wilson', 2800)

create table Lectures (
    Id int primary key identity(1,1),
    LectureRoom nvarchar(max) not null check (LectureRoom <> ''),
    SubjectId int not null,
    TeacherId int not null,
    foreign key (SubjectId) references Subjects(Id),
    foreign key (TeacherId) references Teachers(Id)
)

insert into Lectures (LectureRoom, SubjectId, TeacherId) values
('Room 101', 1, 1),
('Room 202', 2, 2),
('Room 303', 3, 3),
('Room 404', 4, 4),
('Room 505', 5, 5)

create table GroupsLectures (
    Id int primary key identity(1,1),
    GroupId int not null,
    LectureId int not null,
    foreign key (GroupId) references Groups(Id),
    foreign key (LectureId) references Lectures(Id)
)

insert into GroupsLectures (GroupId, LectureId) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5)

select t.[Name], t.Surname, g.[Name] 
from Teachers t cross join Groups g

select f.[Name] 
from Faculties f 
join Departments d on f.Id = d.FacultyId 
where d.Financing > f.Financing

select c.Surname, g.[Name] 
from Curators c 
join GroupsCurators gc on c.Id = gc.CuratorId 
join Groups g on gc.GroupId = g.Id

select t.[Name], t.Surname 
from Teachers t 
join Lectures l on t.Id = l.TeacherId 
join GroupsLectures gl on l.Id = gl.LectureId 
join Groups g on gl.GroupId = g.Id 
where g.[Name] = 'DS301'

select t.Surname, f.[Name] 
from Teachers t 
join Lectures l on t.Id = l.TeacherId 
join GroupsLectures gl on l.Id = gl.LectureId 
join Groups g on gl.GroupId = g.Id 
join Departments d on g.DepartmentId = d.Id 
join Faculties f on d.FacultyId = f.Id

select d.[Name], g.[Name]
from Departments d 
join Groups g on d.Id = g.DepartmentId

select s.[Name] 
from Subjects s 
join Lectures l on s.Id = l.SubjectId 
join Teachers t on l.TeacherId = t.Id 
where t.[Name] = 'Michael' and t.Surname = 'Johnson'

select distinct d.[Name] 
from Departments d 
join Groups g on d.Id = g.DepartmentId 
join GroupsLectures gl on g.Id = gl.GroupId 
join Lectures l on gl.LectureId = l.Id 
join Subjects s on l.SubjectId = s.Id 
where s.[Name] = 'Mathematical Analysis'

select g.[Name] 
from Groups g 
join Departments d on g.DepartmentId = d.Id 
join Faculties f on d.FacultyId = f.Id 
where f.[Name] = 'Computer Science'

select g.[Name], f.[Name] 
from Groups g 
join Departments d on g.DepartmentId = d.Id 
join Faculties f on d.FacultyId = f.Id 
where g.[Year] = 5
