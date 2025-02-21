create database Academy3
use Academy3

create table Faculties (
    Id int primary key not null identity(1,1),
    Name nvarchar(100) not null unique
)

insert into Faculties (Name) values
    ('Engineering'),
    ('Business'),
    ('Medicine'),
    ('Law'),
    ('Computer Science')

create table Departments (
    Id int primary key not null identity(1,1),
    Financing money not null check (Financing >= 0) default(0),
    Name nvarchar(100) not null unique,
    FacultyId int not null,
    foreign key (FacultyId) references Faculties(Id)
)

insert into Departments (Financing, Name, FacultyId) values
    (500000, 'Mechanical Engineering', 1),
    (400000, 'Finance', 2),
    (600000, 'Neurology', 3),
    (300000, 'Criminal Law', 4),
    (700000, 'Artificial Intelligence', 5)

create table Groups (
    Id int primary key not null identity(1,1),
    Name nvarchar(10) not null unique,
    Year int not null check (Year between 1 and 5),
    DepartmentId int not null,
    foreign key (DepartmentId) references Departments(Id)
)

insert into Groups (Name, Year, DepartmentId) values
    ('ME-101', 1, 1),
    ('FIN-202', 2, 2),
    ('NEU-303', 3, 3),	
    ('LAW-404', 4, 4),
    ('AI-505', 5, 5)

create table Teachers (
    Id int primary key not null identity(1,1),
    Name nvarchar(max) not null,
    Surname nvarchar(max) not null,
    Salary money not null check (Salary > 0)
)

insert into Teachers (Name, Surname, Salary) values
    ('John', 'Smith', 75000),
    ('Emily', 'Johnson', 82000),
    ('Michael', 'Williams', 91000),
    ('Sarah', 'Brown', 68000),
    ('James', 'Taylor', 89000)

create table Subjects (
    Id int primary key not null identity(1,1),
    Name nvarchar(100) not null unique
)
insert into Subjects (Name) values
    ('Thermodynamics'),
    ('Investment Analysis'),
    ('Brain Surgery'),
    ('International Law'),
    ('Machine Learning')
create table Lectures (
    Id int primary key not null identity(1,1),
    DayOfWeek int not null check (DayOfWeek between 1 and 7),
    LectureRoom nvarchar(max) not null,
    SubjectId int not null,
    TeacherId int not null,
    foreign key (SubjectId) references Subjects(Id),
    foreign key (TeacherId) references Teachers(Id)
)
insert into Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) values
    (1, 'B101', 1, 1),
    (2, 'C202', 2, 2),
    (3, 'D303', 3, 3),
    (4, 'E404', 4, 4),
    (5, 'F505', 5, 5)
create table GroupsLectures (
    Id int primary key not null identity(1,1),
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



select Count(t.Id) 
from Teachers t 
join Departments d on t.Id = d.Id 
where d.Name = 'Artificial Intelligence'

select Count(l.Id)
from Lectures l
join Teachers t on l.TeacherId = t.Id
where t.Name = 'Sarah' and t.Surname = 'Brown'

select Count(Id)
from Lectures 
where LectureRoom = 'C202'

select LectureRoom, count(Id) as LectureCount 
from Lectures 
group by LectureRoom

select count(g.Id) 
from Groups g 
join GroupsLectures gl on g.Id = gl.GroupId 
join Lectures l on gl.LectureId = l.Id 
join Teachers t on l.TeacherId = t.Id 
where t.Name = 'John' and t.Surname = 'Smith'

select avg(t.Salary) 
from Teachers t 
join Departments d on t.Id = d.Id 
join Faculties f on d.FacultyId = f.Id 
where f.Name = 'Computer Science'

select avg(Financing) 
from Departments

select t.Name, t.Surname, count(l.SubjectId) as SubjectCount 
from Teachers t 
join Lectures l on t.Id = l.TeacherId 
group by t.Name, t.Surname

select DayOfWeek, count(Id) as LectureCount 
from Lectures 
group by DayOfWeek 
order by DayOfWeek

select l.LectureRoom, count(d.Id) as DepartmentCount 
from Lectures l 
join Teachers t on l.TeacherId = t.Id 
join Departments d on t.Id = d.Id 
group by l.LectureRoom


select f.Name, count(s.Id) as SubjectCount 
from Faculties f 
join Departments d on f.Id = d.FacultyId 
join Groups g on d.Id = g.DepartmentId 
join GroupsLectures gl on g.Id = gl.GroupId 
join Lectures l on gl.LectureId = l.Id 
join Subjects s on l.SubjectId = s.Id 
group by f.Name


select t.Name, t.Surname, l.LectureRoom, count(l.Id) as LectureCount 
from Lectures l 
join Teachers t on l.TeacherId = t.Id 
group by t.Name, t.Surname, l.LectureRoom 
order by t.Surname, l.LectureRoom