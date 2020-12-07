create database KurierzyLogistyka
use KurierzyLogistyka
create table [Firmy kurierskie]
(
	ID_Firmy smallint identity(1,1) primary key not null,
	Nazwa varchar(10),
	[Kraj pochodzenia] varchar(30),
	Wlasciciel varchar(50),
	[Rok zalozenia] date,
	[Zasieg panstw] int
)
create table Paczki
(
	ID_RodzajuPaczki smallint identity(1,1) primary key not null,
	[Wielkosc paczki] varchar(20),
	[Maksymalna_waga_kg] int,
	[Zabezpieczenia] varchar(30),
	[Koszt_ubezpieczenia] money
)
create table Zamowienia
(
	ID_Firmy smallint foreign key references [Firmy kurierskie](ID_Firmy),
	ID_Zamowienia int identity(1,1) primary key not null,
	Miasto varchar(30),
	[Nazwa przesylki] varchar(max) default 'BRAK',
	ID_RodzajuPaczki smallint foreign key references Paczki(ID_RodzajuPaczki)
)
create table [Szczegoly zamowien]
(
	ID_Zamowienia int foreign key references Zamowienia(ID_Zamowienia),
	ID_RodzajuPaczki smallint foreign key references Paczki(ID_RodzajuPaczki),
	[Imie klienta] varchar(50),
	[Nazwisko klienta] varchar(50),
	Adres varchar(50),
	[Kod pocztowy] char(6) check(len([Kod pocztowy])=6),
	Miasto varchar(50),
	[Data zamowienia] date,
	ID_Firmy smallint foreign key references [Firmy kurierskie](ID_Firmy),
	[Ubezpieczenie paczki] varchar(3)
)
create table Kurierzy
(
	ID_Firmy smallint foreign key references [Firmy kurierskie](ID_Firmy) not null,
	ID_Pracownika int identity(1,1) primary key not null,
	Imie varchar(30),
	Nazwisko varchar(30),
	[Data urodzenia] date,
	[Data zatrudnienia] date,
	Telefon char(9) check(len(Telefon)=9)
)

insert into [Firmy kurierskie](Nazwa, [Kraj pochodzenia], Wlasciciel, [Rok zalozenia], [Zasieg panstw])
values ('UPS','Stany Zjednoczone','David Abney','1907-08-28', 200),
('DHL','Niemcy', 'John Pearson', '1969-01-01',220),
('FedEx', 'Stany Zjednoczone','Frederick W. Smith', '1971-06-18',220)
,('DPD', 'Francja', 'Paul-Marie Chavanne', '1976-01-01', 220)
,('GLS','Holandia','Rico Back','1999-10-01', 100)

insert into Paczki([Wielkosc paczki],Maksymalna_waga_kg, Zabezpieczenia, Koszt_ubezpieczenia)
values ('Bardzo mała',1,'BRAK',5),('Mała',5,'Folia bąbelkowa',8),('Średnia',15,'Styropian',12)
, ('Duża',25,'Styropian',20),('Bardzo duża',50,'Styropian',30)

insert into Zamowienia(ID_Firmy,Miasto,[Nazwa przesylki],ID_RodzajuPaczki)
values (1,'Warszawa','Dekoracje',3),(4,'Hrubieszów',default,2),(2,'Katowice','Monstery',3),
(5,'Kraków',default,5),(4,'Gdynia','Części samochodowe',4),(1,'Radom',default,1)

insert into [Szczegoly zamowien](ID_Zamowienia,ID_RodzajuPaczki,[Imie klienta],[Nazwisko klienta],Adres,[Kod pocztowy],Miasto,[Data zamowienia],ID_Firmy,[Ubezpieczenie paczki])
values(1,3,'Adrianna','Kożuch','ul.Wiejska 14/6','00-001','Warszawa','2020-01-01',1,'NIE'),
(2,2,'Jarosław','Nowak','ul.Słoneczka 67b/7','22-500','Hrubieszów','2020-01-14', 4, 'NIE'),
(3,3,'Maciej','Zbogdaniec','ul.Krzyżacka14/10','40-000','Katowice','2020-01-28',2,'TAK'),
(4,5,'Oliwia','Widmo','ul.Dziwna 5','30-001','Kraków','2020-02-01',5,'TAK'),
(5,4,'Kacper','Kosteczki','ul.Główna 56/8','80-209','Gdynia','2020-02-04',4,'NIE'),
(6,1,'Marcela','Kostucha','ul.Mickiewicza 44','26-600','Radom','2020-02-10',1,'NIE')

insert into Kurierzy(ID_Firmy,Imie,Nazwisko,[Data urodzenia],[Data zatrudnienia],Telefon)
values(2,'Adrian','Małecki','1999-05-12','2019-06-14','156845637'),
(2,'Michał','Wodecki','1995-7-20','2018-12-04','654765876'),
(1,'Brajan','Kiełbasa','2000-03-18','2020-01-09','423564756'),
(5,'Aleksander','Rzeka','1989-05-28','2010-12-03','584726384'),
(2,'Natalia','Jajko','1990-07-17','2015-11-29','957428523')


-------------Wyswietl informacje o kurierach, ktorzy pracują tylko dla firmy DHL
select k.Imie
, k.Nazwisko
, k.Telefon
, k.[Data urodzenia]
, k.[Data zatrudnienia]
, k.ID_Pracownika
from Kurierzy k inner join [Firmy kurierskie] fk on k.ID_Firmy=fk.ID_Firmy
where fk.Nazwa like 'DHL'

--------------Wyswietl zamowienia, których wielkość była co najmniej średnia
select z.ID_Zamowienia
, z.[Nazwa przesylki]
, z.Miasto
, p.[Wielkosc paczki]
from Zamowienia z inner join Paczki p on z.ID_RodzajuPaczki=p.ID_RodzajuPaczki
where p.[Wielkosc paczki] like 'Duża' or p.[Wielkosc paczki] like 'Średnia' or p.[Wielkosc paczki] like 'Bardzo duża'
