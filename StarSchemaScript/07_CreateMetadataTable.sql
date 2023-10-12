USE SalesAdventureWorksDW2022
GO

-- create control table
IF EXISTS (SELECT * FROM sys.tables where name = 'meta_control_table')
	DROP TABLE meta_control_table;

CREATE TABLE MetadataControl 
(
	id int IDENTITY (1, 1),
	source_table nvarchar(50) NOT NULL,
	last_load_date datetime
);

INSERT INTO MetadataControl (source_table, last_load_date)
VALUES ('sales order header', '1900-01-01');




