create database UniversityPB_421
use UniversityPB_421


---------------- Groups -----------------
create table Groups
(
	Id int primary key identity(1,1),
	Name nvarchar(50) not null check(Name <> '') unique
)

insert Groups
values	('Dublin'),
		('Delaware'),
		('New-York'),
		('Masachusets')


---------------- Students -----------------
	-- FOREIGN KEY (column) REFERENCES table(column) - встановлює зовнішній ключ для зв'язку з таблицею
create table Students
(
	Id int primary key identity(1,1),
	[Name] nvarchar(50) NOT NULL check([Name] <> ''),
	Surname nvarchar(50) not null check(Surname <> ''),
	Email varchar(30) not null unique,
	Birthdate date not null check(Birthdate < getdate()), -- getdate() - повертає поточну дату
	AverageMark real null check(AverageMark between 1 and 12) default(1), -- AverageMark >= 1 and AverageMark <= 12
	Lessons int not null default(0) check(Lessons >= 0),
	NonAttendances int not null default(0) check(NonAttendances >= 0),
	Visitings as Lessons - NonAttendances,
	GroupId int null references Groups(Id),
	check(NonAttendances <= Lessons)
	/*GroupId int,
	foreign key(GroupId) references Groups(Id),*/
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

-- при встановленні зв'язку на запис таблиці він повинен існувати, інакше не дозволить

select * from Students

---------------- Teachers -----------------
create table Teachers
(
	Id int primary key identity(1,1),
	Name nvarchar(50) not null,
	HireDate date default(getdate()),
	Phone char(20) null
)

insert into Teachers ([Name], HireDate, Phone) values ('Gwen Grewes', '2011-06-25', '+63 (478) 962-8864');
insert into Teachers ([Name], HireDate, Phone) values ('Shelton Marqyes', '2012-08-17', '+255 (963) 668-6077');
insert into Teachers ([Name], HireDate, Phone) values ('Tabbie McQuaker', '2011-06-12', '+62 (428) 203-4691');
insert into Teachers ([Name], HireDate, Phone) values ('Boony Wormald', '2011-02-24', '+63 (671) 632-3585');
insert into Teachers ([Name], HireDate, Phone) values ('Yehudi Potteril', '2021-03-16', '+51 (270) 775-4259');

select* from Teachers
-- проміжна таблиця для реалізації зв'язку Many to Many
create table TeachersGroups
(
	TeacherId int references Teachers(Id),
	GroupId int references Groups(Id),
	primary key(TeacherId,GroupId)
)


-- встановлюємо зв'язки між Teachers та Groups
insert into TeachersGroups
values
	(1,1),
	(1,2),
	(2,3),
	(3,3)

create view GoodStudents
as 
	select Name, Surname, Email, AverageMark
	from Students
	where AverageMark >= 10

select * from GoodStudents
where Name like '[A-D]%'

alter view GoodStudents
as 
	select Name, Surname, Email, AverageMark
	from Students
	where AverageMark >= 8

alter view GoodStudents(Fullname, Email, Mark)
as 
	select Name + ' ' + Surname, Email, AverageMark
	from Students
	where AverageMark >= 10

select * from GoodStudents
where Email like '%.com' and Mark >= 11

create or alter view GoodStudentsWithParams(Fullname, EmailAddress, Mark)
with encryption 
as
	select Name + ' ' + Surname, Email, AverageMark
	from Students
	where AverageMark >= 10

create or alter view Top3GoodStudents
as
	select top 3 * from GoodStudentsWithParams
	order by Mark desc

select * from Top3GoodStudents

drop view Top3GoodStudents


create or alter view StudentFullInfo(StudentName, Email, Mark, GroupName)
as 
	select s.Name, s.Email, s.AverageMark, g.Name
	from Students s join Groups g on s.GroupId  = g.Id

select * from StudentFullInfo
order by GroupName

insert into GoodStudents
value ('Denis2','Bondar2', 'denis@gmail.com', '2000/02/02', 10.5)

select * from Students

declare @var int, @a char(5)
select @var = 5, @a = 'Hello'
print 'Value variable @var = ' + convert(char(10), @var)
print 'Value veriable @a = ' + @a

declare @MyTable table(Id int not null, number int)
insert @MyTable
select top 5 Id, Lessons
from Students

select * from @MyTable

declare @a int;
set @a = 5
if @a > 0
	begin 
		print 'Positive' 
	end
else
	print 'Negative'

if(select Count(Id) from Students) > 50
	begin
		print ' > 50'
	end

if exists(select * from Students where Birthdate between '2015/01/01' and CURRENT_TIMESTAMP)
	begin
		print 'Info about students'
		select * from Students where Birthdate between '2015/01/01' and CURRENT_TIMESTAMP
	end

if (DATENAME(dw, GETDATE())) = 'Monday'
begin
	print 'Monday'
end

select Name as 'Student name', Marks = case
									when AverageMark < 7 then 'Bad'
									when AverageMark >=  7 then 'Good'
									end
from Students

select Name, 'Season' = case
when Month(Birthdate) in (6,7,8) then 'Summer'
when Month(Birthdate) in (12,1,2) then 'winter'
end
from Students

create or alter procedure greeting
@username nvarchar(50)
as
print 'Hello, dear ' + @username 


execute greeting 'Denis'

create proc del_student
@email nvarchar(50)
as 
	delete from Students
	where Email = @email

execute del_student 'amcphilip3@gnu.org'
select * from Students

create proc set_mark
@email nvarchar(50),
@new_mark real
as
	update Students
	set AverageMark = @new_mark
	where Email = @email

exec set_mark 'sdwelley5@europa.eu', 11.9

create proc get_student_avg_mark
@group_name nvarchar(50),
@avg_mark real output
as
select @avg_mark = Avg(AverageMark)
from Students as s join Groups g on s.GroupId = g.Id
where g.Name = @group_name
set @avg_mark = ROUND(@avg_mark,1)

declare @result real;
exec get_student_avg_mark 'New-York', @result output
print @result

create proc get_max_min_date
@max_date date output,
@min_date date output
as
select @max_date = Max(Birthdate), @min_date = Min(Birthdate)
from Students

declare @date_max date, @date_min date
exec get_max_min_date @date_max output, @date_min output
select @date_max as 'The oldest Student Birthdate', @date_min as 'The youngest Student'

create proc sp_student_by_mark
@mark_from int,
@mark_to int
as
select Name + ' ' + Surname as [Full Name], Email, AverageMark
from Students
where AverageMark between @mark_from and @mark_to
order by AverageMark desc

exec sp_student_by_mark 7,8
---------------------------------------------
create database Music

use Music

create table Albums (
    Id int primary key identity(1,1),
    AlbumName nvarchar(100),
    ArtistId int,
    Date date,
    StyleId int,
    PublisherId int,
    foreign key (StyleId) references Styles(Id),
    foreign key (PublisherId) references Publishers(Id)
)

drop table Albums
INSERT INTO Albums (AlbumName, ArtistId, Date, StyleId, PublisherId) 
VALUES ('Abbey Road', 1, '1969-09-26', 1, 1)


create table Styles (
    Id int primary key identity(1,1),
    Name nvarchar(100) not null
)
drop table Styles
insert into Styles (Name) 
values ('Rock'), ('Pop'), ('Jazz'), ('Classical')
create table Artists (
    Id int primary key identity(1,1),
    Name nvarchar(100) not null
)

create table Publishers (
    Id int primary key identity(1,1),
    Name nvarchar(100) not null,
    Country nvarchar(100) not null
)
drop table Publishers
insert into Publishers (Name, Country) 
values ('Sony Music', 'USA'), 
	('Universal Music', 'UK')


create table Songs (
    Id int primary key identity(1,1),
    Name nvarchar(100) not null,
    AlbumId int,
    Duration time,
    StyleId int,
    ArtistId int,
    foreign key (AlbumId) references Albums(Id),
    foreign key (StyleId) references Styles(Id),
    foreign key (ArtistId) references Artists(Id)
)
drop table Songs
INSERT INTO Songs (Name, AlbumId, Duration, StyleId, ArtistId) 
VALUES ('Come Together', 1, '00:04:20', 2, 2)

create proc GetAllAlbumsInfo
as
begin
    select 
        a.Id as AlbumId, a.AlbumName, a.Date as ReleaseDate, s.Name as Style, p.Name as Publisher, ar.Name as Artist
    from Albums a
    join Styles s on a.StyleId = s.Id
    join Publishers p on a.PublisherId = p.Id
    join Artists ar on a.ArtistId = ar.Id
end
