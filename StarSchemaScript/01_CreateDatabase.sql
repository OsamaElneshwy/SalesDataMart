USE master
go

IF Db_id('SalesAdventureWorksDW2022') IS NOT NULL
  DROP DATABASE SalesAdventureWorksDW2022;

CREATE DATABASE SalesAdventureWorksDW2022
go
