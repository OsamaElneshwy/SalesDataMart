USE SalesAdventureWorksDW2022
go

-- Dropping the foreign keys
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'FK_SalesFact_CustomerDim'
           AND parent_object_id = Object_id('SalesFact'))
	ALTER TABLE SalesFact
    DROP CONSTRAINT FK_SalesFact_CustomerDim;

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'CustomerDim')
	DROP TABLE CustomerDim
go
CREATE TABLE CustomerDim
  (
     customer_PK        INT NOT NULL IDENTITY(1, 1),            
     customer_BK        INT NOT NULL,              -- Business key
     customer_name      NVARCHAR(150),
     address1           NVARCHAR(100),
     address2           NVARCHAR(100),
     city               NVARCHAR(30),
     phone              NVARCHAR(25),

	 -- Metadata
     source_system_code TINYINT NOT NULL,                         

	 -- SCD
     start_date         DATETIME NOT NULL DEFAULT (Getdate()),    
     end_date           DATETIME NULL,							  
     is_current         TINYINT NOT NULL DEFAULT (1),             
     CONSTRAINT PK_CustomerDim PRIMARY KEY CLUSTERED (customer_PK)
  );

-- Insert unknown record to hundle messing values while doing ETL
SET IDENTITY_INSERT CustomerDim ON

INSERT INTO CustomerDim
            (customer_PK,
             customer_BK,
             customer_name,
             address1,
             address2,
             city,
             phone,
             source_system_code,
             start_date,
             end_date,
             is_current)
VALUES      (0,
             0,
             'Unknown',
             'Unknown',
             'Unknown',
             'Unknown',
             'Unknown',
             0,
             '1900-01-01',
             NULL,
             1)

SET IDENTITY_INSERT CustomerDim OFF

-- Create Foreign Key
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'SalesFact')
  ALTER TABLE SalesFact
    ADD CONSTRAINT FK_SalesFact_CustomerDim FOREIGN KEY (customer_SK)
    REFERENCES CustomerDim(customer_PK);

-- Create Indexes
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'CustomerDim_customerBK'
                  AND object_id = Object_id('CustomerDim'))
	DROP INDEX CustomerDim.CustomerDim_customerBK
go
CREATE INDEX CustomerDim_customerBK
ON CustomerDim(customer_BK);

IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'CustomerDim_city'
                  AND object_id = Object_id('CustomerDim'))
	DROP INDEX CustomerDim.CustomerDim_city
go
CREATE INDEX CustomerDim_city
ON CustomerDim(city); 
