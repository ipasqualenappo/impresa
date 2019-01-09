drop database if exists impresa;
create schema impresa; 
use impresa;

/*INIZIO CREAZIONE TABELLE*/
create table intermediario(
	codpar char(20) not null primary key,
	nominativo char(30) not null,
	email char(30),
	nciv char(5),
	via char(40),
	cap numeric(5)
);

create table fonderia(
	codpar char(20) not null primary key,
	nominativo char(30) not null,
	email char(30),
	nciv char(5),
	via char(40),
	cap numeric(5)
);

create table fornitore(
	codpar char(20) not null primary key,
	nominativo char(30) not null,
	email char(30),
	nciv char(5),
	via char(40),
	cap numeric(5)
);

create table affittuario(
	codpar char(20) not null primary key,
	nominativo char(30) not null,
	email char(30),
	nciv char(5),
	via char(40),
	cap numeric(5)
);

create table trasportatore(
	codpar char(20) not null primary key,
	nominativo char(30) not null,
	email char(30),
	nciv char(5),
	via char(40),
	cap numeric(5)
);

create table attoAffitto(
	codice char(10) not null primary key,
	data date not null,
	affittuario char(20) references affittuario(codpar)
);

create table attoMateriali(
	codice char(10) not null primary key,
	data date not null,
	fonderia char(20) references fonderia(codpar),
	fornitore char(20) references fornitore(codpar),
check((fonderia is null and fornitore is not null)or(fonderia is not null and fornitore is null))
);

create table attoTrasporto(
	codice char(10) not null primary key,
	data date not null,
	importo numeric(8) not null,
	trasportatore char(20) not null references trasportatore(codpar),
	attoMateriali char(10) not null references attoMateriali(codice)
);
create table telefonoInt(
	numero numeric(18) not null primary key,
	intermediario char(20) not null references intermediario(codpar)
);
create table faxInt(
	numero numeric(18) not null primary key,
	intermediario char(20) not null references intermediario(codpar)
);
create table faxFor(
	numero numeric(18) not null primary key,
	fornitore char(20) not null references fornitore(codpar)
);
create table telefonoFor(
	numero numeric(18) not null primary key,
	fornitore char(20) not null references fornitore(codpar)
);
create table telefonoFon(
	numero numeric(18) not null primary key,
	fonderia char(20) not null references fonderia(codpar)
);
create table faxFon(
	numero numeric(18) not null primary key,
	fonderia char(20) not null references fonderia(codpar)
);
create table faxAff(
	numero numeric(18) not null primary key,
	affittuario char(20) not null references affittuario(codpar)
);
create table telefonoAff(
	numero numeric(18) not null primary key,
	affittuario char(20) not null references affittuario(codpar)
);
create table telefonoTra(
	numero numeric(18) not null primary key,
	trasportatore char(20) not null references trasportatore(codpar)
);

create table faxTra(
	numero numeric(18) not null primary key,
	trasportatore char(20) not null references trasportatore(codpar)
);
create table gas(
	codice char(10) not null primary key,
	nome char(15) not null,
	purezza numeric(3) not null,
	check(purezza>=0 and purezza<=100)
);
create table bombola(
	codice char(10) not null primary key,
	capacita numeric(3) not null,
	check(capacita>0),
	scadenza date not null,
	stato char(15),
	check(stato='vuota' or stato='disponibile' or stato='in affitto'),
	prezzo numeric(7),
	check(prezzo>0),
	gas char(10) not null references gas(codice)
);
create table metallo(
	codice char(10) not null primary key,
	nome char(15) not null,
	quantita numeric(6) not null,
	check(quantita>=0),
	resa numeric(3),
	check(resa>=0 and resa<=100)
);
create table intermediazione(
	intermediario char(20) not null references intermediario(codpar),
	fonderia char(20) not null references fonderia(codpar),
	primary key(intermediario, fonderia),
	percentuale numeric(3),
	check(percentuale>=0 and percentuale<=100)
);
create table elencazioneBom(
	bombola char(10) not null references bombola(codice),
	attoAffitto char(10) not null references attoAffitto(codice),
	primary key(bombola, attoAffitto)
);
create table elencazioneMet(
	metallo char(10) not null references metallo(codice),
	attoMateriali char(10) not null references attoMateriali(codice),
	primary key(metallo, attoMateriali),
	quantita numeric(6) not null,
	check(quantita>0),
	prezzo numeric(8) not null,
	check(prezzo>0)
);


/*INIZIO POPOLAZIONE DEL DATABASE*/

insert into intermediario(codpar,nominativo,email,nciv,via,cap)
	values("1234","Pasquale","pnappo6@gmail.com","34","Manzoni","80040");

insert into fonderia(codpar,nominativo,email,nciv,via,cap)
	values("1235","Angelo","nappo@gmail.com","45","Sambuci","80050");

insert into fornitore(codpar,nominativo,email,nciv,via,cap)
	values("1236","Giuseppe","peppe@gmail.com","78","Bertolli","80056");

insert into affittuario(codpar,nominativo,email,nciv,via,cap)
	values("1237","Alfredo","alfredo@gmail.com","44","Bosco","80040"); 

insert into trasportatore(codpar,nominativo,email,nciv,via,cap)
	values("1238","Vincenzo","vincenzo@gmail.com","41","Bruni","80040");

insert into attoAffitto(codice,data,affittuario)
	values("1239","2015-03-12","1237");

insert into attoMateriali(codice,data,fonderia,fornitore)
	values("1240","2015-05-15","1235","Angelo");

insert into attoTrasporto(codice,data,importo,trasportatore,attoMateriali)
	values("15624","2015-03-14","200","1238","1240");
    
insert into telefonoInt(numero,intermediario)
	values("3342542784","1234");

insert into faxInt(numero,intermediario)
	values("021450125487","1234");

insert into faxFor(numero,fornitore)
	values("0215412145","1236");
    
insert into telefonoFor(numero,fornitore)
	values("3302524641","1236");    

insert into telefonoFon(numero,fonderia)
	values("125412451","1235");

insert into faxFon(numero,fonderia)	
	values("121512154","1235");

insert into faxAff(numero,affittuario)	
	values("12541215","1237");

insert into telefonoAff(numero,affittuario)
	values("153465154","1237");

insert into telefonoTra(numero,trasportatore)
	values("15415125","1238");

insert into faxTra(numero,trasportatore)
	values("125412651","1238");

insert into gas(codice,nome,purezza)
	values("1241","elio","100");

insert into bombola(codice,capacita,scadenza,stato,prezzo,gas)
	values("1242","123","2015-04-15","345","40","1241");

insert into metallo(codice,nome,quantita,resa)
	values("1243","Rame","1245","546");

insert into intermediazione(intermediario,fonderia,percentuale)
	values("1234","1235","34");

insert into elencazioneBom(bombola,attoAffitto)
	values("1242","1239");

insert into elencazioneMet(metallo,attoMateriali,quantita,prezzo)
     values("1243","1240","40","25");




	