create database University

use University

create table Groups
(
	Id int primary key identity(1,1),
	Name nvarchar(100) not null check(Name <> '') unique
)

insert Groups
values	('Dublin'),
		('Delaware'),
		('New-York'),
		('Masachusets')
 
create table Students
(
	Id int primary key identity(1,1),
	[Name] nvarchar(50) NOT NULL check([Name] <> ''),
	Surname nvarchar(50) not null check(Surname <> ''),
	Email varchar(30) not null unique,
	Birthdate date not null check(Birthdate < getdate()), 
	AverageMark real null check(AverageMark between 1 and 12) default(1),
	Lessons int not null default(0) check(Lessons >= 0),
	NonAttendances int not null default(0) check(NonAttendances >= 0),
	Visitings as Lessons - NonAttendances,
	GroupId int null references Groups(Id),	
	check(NonAttendances <= Lessons)
	--GroupId int,
	--foreign key(GroupId) references Groups(Id),
)

insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Arabela', 'Jeanet', 'ajeanet0@nih.gov', '2001-02-14', 7.1, 184, 130, null);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Bunnie', 'Giorgioni', 'bgiorgioni1@nbcnews.com', '2009-02-05', 9.8, 235, 52, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Sergent', 'Rollings', 'srollings2@prlog.org', '2010-04-19', 11.1, 180, 137, 2);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Annabella', 'McPhilip', 'amcphilip3@gnu.org', '2008-12-30', 8.6, 235, 20, 1);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Jaymee', 'McClintock', 'jmcclintock4@t-online.de', '2008-06-04', 5.5, 216, 36, null);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Sophi', 'Dwelley', 'sdwelley5@europa.eu', '2001-08-28', 7.9, 161, 20, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Lynn', 'Corneljes', 'lcorneljes6@army.mil', '2007-11-08', 9.7, 240, 117, 1);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Kippar', 'Gagie', 'kgagie7@wunderground.com', '2010-07-08', 9.7, 174, 67, 2);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Arden', 'Widdicombe', 'awiddicombe8@addtoany.com', '2007-04-28', 10.7, 204, 13,null);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Noella', 'Alam', 'nalam9@list-manage.com', '2006-11-03', 10.0, 192, 64, 2);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Celisse', 'Climpson', 'cclimpsona@sbwire.com', '2005-10-22', 9.6, 174, 17, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Don', 'Izaks', 'dizaksb@wired.com', '2010-08-03', 7.2, 218, 76, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Berte', 'Baudichon', 'bbaudichonc@answers.com', '2001-09-29', 11.5, 173, 0, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Son', 'Deaton', 'sdeatond@live.com', '2013-07-07', 9.8, 159, 3, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Oran', 'Frere', 'ofreree@163.com', '2001-03-30', 11.2, 228, 13, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Archer', 'Rupprecht', 'arupprechtf@house.gov', '2002-08-02', 8.6, 230, 130, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Stacy', 'Lovie', 'slovieg@springer.com', '2011-01-06', 7.2, 164, 10, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Ted', 'Yglesia', 'tyglesiah@china.com.cn', '2007-09-05', 7.9, 206, 33, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Brien', 'Kemmer', 'bkemmeri@arizona.edu', '2011-07-09', 5.6, 223, 63, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Rani', 'Bottomley', 'rbottomleyj@ebay.com', '2011-05-05', 7.9, 195, 32, 2);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Aldus', 'Geaney', 'ageaneyk@webeden.co.uk', '2009-05-15', 8.4, 232, 116, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Cristin', 'McCooke', 'cmccookel@nba.com', '2005-01-24', 10.0, 211, 5, 1);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Sybille', 'Tolomio', 'stolomiom@mashable.com', '2010-06-03', 8.7, 244, 65, 2);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Alvina', 'Maharry', 'amaharryn@sbwire.com', '2011-03-30', 10.3, 243, 42, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Kimball', 'Gethin', 'kgethino@latimes.com', '2008-09-28', 9.4, 171, 82, 1);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Elsi', 'Lammerts', 'elammertsp@creativecommons.org', '2001-06-06', 10.9, 154, 150, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Philly', 'O'' Cloney', 'pocloneyq@telegraph.co.uk', '2007-04-14', 7.8, 247, 68, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Nichole', 'De Gregoli', 'ndegregolir@symantec.com', '2004-08-25', 7.6, 204, 85, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Lotta', 'Meddemmen', 'lmeddemmens@csmonitor.com', '2009-09-27', 9.2, 182, 79, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Else', 'Gabriely', 'egabrielyt@cpanel.net', '2011-07-02', 5.4, 163, 26, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Mariya', 'Clilverd', 'mclilverdu@paypal.com', '2013-07-30', 9.1, 211, 84, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Marco', 'Zecchini', 'mzecchiniv@cisco.com', '2010-05-12', 11.5, 196, 132, 1);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Leoline', 'Chiommienti', 'lchiommientiw@kickstarter.com', '2012-01-31', 7.6, 154, 139, 1);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Allison', 'Auletta', 'aaulettax@stanford.edu', '2007-12-10', 11.0, 239, 74, 1);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Davidde', 'Pancoast', 'dpancoasty@yale.edu', '2004-03-23', 10.2, 150, 133, 1);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Star', 'Saffe', 'ssaffez@scientificamerican.com', '2006-04-01', 8.9, 189, 4, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Will', 'Van Der Weedenburg', 'wvanderweedenburg10@ebay.co.uk', '2006-01-09', 8.1, 173, 74, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Ilene', 'Kryszka', 'ikryszka11@cyberchimps.com', '2013-03-11', 8.1, 201, 42, 1);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Clark', 'Emerson', 'cemerson12@dailymail.co.uk', '2001-12-28', 9.2, 185, 145, 1);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Lilllie', 'Parkyns', 'lparkyns13@tripadvisor.com', '2006-06-28', 6.9, 180, 29, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Valenka', 'Roggeman', 'vroggeman14@studiopress.com', '2001-03-06', 9.7, 154, 115, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Kirsteni', 'Corbet', 'kcorbet15@mlb.com', '2013-07-13', 7.6, 242, 25, 2);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Harrietta', 'Ineson', 'hineson16@dropbox.com', '2004-10-10', 9.4, 153, 104, 1);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Oswald', 'Gaddie', 'ogaddie17@indiatimes.com', '2000-12-19', 10.7, 179, 29, 2);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Syd', 'Bucktharp', 'sbucktharp18@slashdot.org', '2011-05-03', 8.0, 240, 6, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Maison', 'Scarratt', 'mscarratt19@goo.ne.jp', '2003-05-31', 8.5, 222, 138, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Willabella', 'Calder', 'wcalder1a@multiply.com', '2006-01-11', 7.7, 175, 135, 4);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Lindy', 'Jaslem', 'ljaslem1b@ed.gov', '2013-05-06', 11.2, 205, 10, 3);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Elfrieda', 'Ceely', 'eceely1c@goo.ne.jp', '2009-05-16', 10.3, 234, 108, 2);
insert into Students ([Name], Surname, Email, Birthdate, AverageMark, Lessons, NonAttendances, GroupId) values ('Elise', 'Gait', 'egait1d@blogspot.com', '2005-11-11', 6.1, 221, 110, 2);


select * from Groups
select * from Students

create table Teachers
(
	Id int primary key identity(1,1),
	[Name] nvarchar(50) NOT NULL,
	HireDate date default(getdate()),
	Phone char(20) null,

)

insert into Teachers ([Name], HireDate, Phone) values ('Gwen Grewes', '2011-06-25', '+63 (478) 962-8864');
insert into Teachers ([Name], HireDate, Phone) values ('Shelton Marqyes', '2012-08-17', '+255 (963) 668-6077');
insert into Teachers ([Name], HireDate, Phone) values ('Tabbie McQuaker', '2011-06-12', '+62 (428) 203-4691');
insert into Teachers ([Name], HireDate, Phone) values ('Boony Wormald', '2011-02-24', '+63 (671) 632-3585');
insert into Teachers ([Name], HireDate, Phone) values ('Yehudi Potteril', '2021-03-16', '+51 (270) 775-4259');


select * from Teachers

create table TeachersGroups
(
	TeacherId int references Teachers(Id),
	GroupId int references Groups(Id),
	primary key(TeacherId, GroupId)
)

insert into TeachersGroups
values
	(1,1),
	(1,2),
	(2,3),
	(3,3)

select s.Name, s.AverageMark, s.GroupId, g.Id, g.Name
from Students as s, Groups as g
where s.GroupId = g.Id
order by g.Id 

select top 3 s.Name, s.AverageMark, s.GroupId, g.Id, g.Name
from Students as s, Groups as g
where s.GroupId = g.Id and g.Name = 'Dublin'
order by s.AverageMark Desc	

select t.Name, t.Phone, g.Name
from Teachers as t, TeachersGroups as tg, Groups as g
where tg.TeacherId = t.Id and tg.GroupId = g.Id and t.Name = 'Gwen Grewes'

select s.Name, s.AverageMark, s.GroupId, g.Id, g.Name
from Students as s join Groups as g on s.GroupId = g.Id
where g.Name = 'New-York'

select top 3 s.Name, s.AverageMark, s.GroupId, g.Id, g.Name
from Students as s join Groups as g on s.GroupId = g.Id
where g.Name = 'New-York' and s.AverageMark >= 7
order by s.AverageMark Desc

select t.Name, t.Phone, g.Name
from Teachers as t join TeachersGroups as tg on t.Id = tg.TeacherId
					join Groups as g on tg.GroupId = g.Id

select t.Name, t.Phone, g.Name
from Students as s
				join Groups as g on s.GroupId = g.Id
				join TeachersGroups as tg on tg.GroupId = g.Id
				join Teachers as t on tg.TeacherId = t.Id

where s.Name = 'Celisse'

select s.Name, g.Name
from Students as s left join Groups as g on s.GroupId = g.Id


select s.Name, g.Name
from Students as s left join Groups as g on s.GroupId = g.Id
where s.GroupId is null

----------------------------------------

create database Hospital

use Hospital

create table Departments
(
	Id int primary key not null identity(1,1),
	[Name] nvarchar(100) not null check([Name] <> '') unique
)
insert into Departments ( [Name]) values ('Ezmeralda');
insert into Departments ( [Name]) values ('Agata');
insert into Departments ( [Name]) values ('Kristoffer');
insert into Departments ( [Name]) values ('Zea');
insert into Departments ( [Name]) values ('Rivi');

drop table Departments
create table Doctors
(
	Id int primary key not null identity(1,1),
	[Name] nvarchar(max) not null check([Name] <> ''),
	Premium money not null default(0) check(Premium <> 0),
	Salary money not null check(Salary !< 0 and Salary <> 0),
	Surname nvarchar(max) not null check(Surname <> '')
)
insert into Doctors ([Name], Premium, Salary, Surname) values ('Ty', 12.20, 13211.85, 'Ellesworthe');
insert into Doctors ([Name], Premium, Salary, Surname) values ('Stephana',  96.40, 12666.29, 'Havile');
insert into Doctors ([Name], Premium, Salary, Surname) values ('Zebulon',  65.51, 7288.46, 'Wildbore');
insert into Doctors ([Name], Premium, Salary, Surname) values ('Arie',  55.10, 13409.70, 'Goodacre');
insert into Doctors ([Name], Premium, Salary, Surname) values ('Edie',  15.75, 11370.36, 'Penrose');
drop table Doctors

create table DoctorsSpecializations
(
    Id int primary key not null identity(1,1),
    DoctorId int not null,
    SpecializationId int not null,
    foreign key(DoctorId) references Doctors(Id),
    foreign key(SpecializationId) references Specializations(Id)
)

insert into DoctorsSpecializations (DoctorId, SpecializationId)
values 
(1, 1),
(2, 2), 
(3, 3), 
(4, 4);

drop table DoctorsSpecializations

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
create table Specializations
(
    Id int primary key not null identity(1,1),
    [Name] nvarchar(100) not null  check([Name] <> '') unique
)

insert into Specializations ([Name])
values 
('Cardiologist'),
('Neurologist'),
('Pediatrician'),
('Orthopedic')
drop table Specializations
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
('Evhen')

drop table Sponsors
create table Vacations
(
    Id int primary key not null identity(1,1),
    EndDate date not null check(EndDate > StartDate),
    StartDate date not null,
    DoctorId int not null,
    foreign key(DoctorId) references Doctors(Id)
)

insert into Vacations (EndDate, StartDate, DoctorId)
values 
('2025-02-20', '2025-02-10', 1),  
('2025-03-01', '2025-02-25', 2)
drop table Vacations
create table Wards
(
    Id int primary key not null identity(1,1),
    [Name] nvarchar(20) not null check([Name] <> '') unique,
    DepartmentId int not null,
    foreign key(DepartmentId) references Departments(Id)
)

insert into wards ([name], departmentid)
values 
('Палата 101', 1),  
('Палата 102', 1), 
('Палата 201', 2), 
('Палата 202', 2)
drop table Wards

