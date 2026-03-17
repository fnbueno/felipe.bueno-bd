create database b;
use b;
drop database b;
create database b;
use b;

create table projeto(
IdProjeto int auto_increment primary key,
Tipo varchar(40) not null,
Descrição varchar(100) not null
);
create table Cargo (
Idcargo int(10) primary key auto_increment,
Descricaocargo varchar(80) not null,
Departamento varchar(60) not null
);
create table Empregado (
Idempregado int(10) primary key auto_increment,
Nome varchar(100) not null,
Idcargo int);
