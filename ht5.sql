create database Academy4
use Academy4

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
    [Name] nvarchar(100) not null check ([Name] <> '') unique
)

insert into Faculties ( [Name]) values
('Computer Science'),
('Mathematics'),
('Physics'),
('Biology'),
('Chemistry')

create table Departments (
    Id int primary key identity(1,1),
	Building int not null check(Building between 1 and 5),
    Financing money not null check (Financing >= 0) default(0),
    [Name] nvarchar(100) not null check ([Name] <> '') unique,
    FacultyId int not null,
    foreign key (FacultyId) references Faculties(Id)
)

insert into Departments (Building ,Financing, [Name], FacultyId) values
(2,50000, 'Software Engineering', 1),
(4,70000, 'Data Science', 1),
(5,60000, 'Applied Mathematics', 2),
(1,75000, 'Theoretical Physics', 3),
(3,80000, 'Molecular Biology', 4)

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
	IsProfessor bit not null default(0),
    [Name] nvarchar(max) not null check ([Name] <> ''),
    Salary money not null check (Salary > 0),
    Surname nvarchar(max) not null check (Surname <> ''),
)

insert into Teachers (IsProfessor, [Name], Salary, Surname) values
(1,'Alex', 3000, 'Smith' ),
(1,'John', 3200,'Doe'),
(0,'Elena', 2900,'Brown'),
(1,'Michael', 3100,'Johnson'),
(0,'Sophia', 2800,'Wilson')

create table Lectures (
    Id int primary key identity(1,1),
	Date date not null check(Date <> getdate()),
    SubjectId int not null,
    TeacherId int not null,
    foreign key (SubjectId) references Subjects(Id),
    foreign key (TeacherId) references Teachers(Id)
)

insert into Lectures (Date, SubjectId, TeacherId) values
('2025/01/01', 1, 1),
('2025/01/02', 2, 2),
('2025/01/03', 3, 3),
('2025/01/04', 4, 4),
('2025/01/05', 5, 5)

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

create table Students
(
	Id int primary key identity(1,1),
	[Name] nvarchar(max) not null check ([Name] <> ''),
	Rating int not null check(Rating between 0 and 5),
	Surname nvarchar(max) not null check (Surname <> '')
)

create table GroupsStudents
(
	Id int primary key identity(1,1),
	GroupId int not null,
	StudentId int not null,
	foreign key (GroupId) references Groups(Id),
	foreign key (StudentId) references Students(Id)
)


select Building
from Departments
group by Building
having SUM(Financing) > 75000

select g.[Name]
from Groups g
join Departments d on g.DepartmentId = d.Id
join GroupsLectures gl on g.Id = gl.GroupId
join Lectures l on gl.LectureId = l.Id
where g.[Year] = 5 AND d.[Name] = 'Software Engineering'
group by g.[Name]
having COUNT(gl.LectureId) > 5

select g.[Name]
from Groups g
join GroupsStudents gs on g.Id = gs.GroupId
join Students s on gs.StudentId = s.Id
group by g.[Name]
having AVG(s.Rating) > (
    select AVG(s.Rating)
    from GroupsStudents gs
    join Students s on gs.StudentId = S.Id
    join Groups g on gs.GroupId = g.Id
    where g.[Name] = 'CS202'
)


select [Name], Surname
from Teachers
where Salary > 
(
select AVG(Salary) 
from Teachers 
where IsProfessor = 1
)


select g.[Name]
from Groups g
join GroupsCurators gc on g.Id = gc.GroupId
group by g.[Name]
having COUNT(gc.CuratorId) > 1

select g.[Name]
   from Groups g
   join GroupsStudents gs on g.Id = gs.GroupId
   join Students s on gs.StudentId = s.Id
   group by g.[Name]
   having AVG(s.Rating) < 
(
       select MIN(Avgrating)
       from (
           select AVG(s.Rating) as Avgrating
           from Groups g
           join GroupsStudents gs on g.Id = gs.GroupId
           join Students s on gs.StudentId = s.Id
           where g.[Year] = 5
           group by g.[Name]
       ) as Minratings
   )


select f.[Name]
from Faculties f
join Departments d on f.Id = d.FacultyId
group by f.[Name]
having SUM(d.Financing) > 
(
    select SUM(d.Financing)
    from Departments d
    join Faculties f on d.FacultyId = f.Id
    where f.[Name] = 'Mathematics'
)

select 
    (
        select COUNT(gs.StudentId)
        from GroupsStudents gs
        join Groups g on gs.GroupId = g.Id
        join Departments d on g.DepartmentId = d.Id
        where d.[Name] = 'Applied Mathematics'
    ) as StudentCount,
    (
        select COUNT(distinct l.SubjectId)
        from Lectures l
        join GroupsLectures gl on l.Id = gl.LectureId
        join Groups g on gl.GroupId = g.Id
        join Departments d on g.DepartmentId = d.Id
        where d.[Name] = 'Applied Mathematics'
    ) as SubjectCount