USE SalesAdventureWorksDW2022
go

-- Dropping the foreign keys
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'FK_SalesFact_TerritoryDim' 
		   AND parent_object_id = Object_id('SalesFact'))
	ALTER TABLE SalesFact 
	DROP CONSTRAINT FK_SalesFact_TerritoryDim;

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'TerritoryDim')
	DROP TABLE TerritoryDim
go
CREATE TABLE TerritoryDim
  (
	 territory_PK       INT NOT NULL IDENTITY(1, 1),   
     territory_BK       INT NOT NULL,				  -- Bussines key
     territory_name     NVARCHAR(50),
     territory_country  NVARCHAR(400),
     territory_group    NVARCHAR(50),
     
	 -- Metadata
	 source_system_code TINYINT NOT NULL,			  
    
	 -- SCD
 	 start_date         DATETIME NOT NULL DEFAULT (Getdate()),  
     end_date           DATETIME,							   
     is_current         TINYINT NOT NULL DEFAULT (1),		   
    
	 CONSTRAINT PK_TerritoryDim PRIMARY KEY CLUSTERED (territory_PK)
  );

-- Insert unknown record to hundle messing values while doing ETL
SET IDENTITY_INSERT TerritoryDim ON

INSERT INTO TerritoryDim
            (territory_PK,
             territory_BK,
             territory_name,
             territory_country,
             territory_group,
             source_system_code,
             start_date,
             end_date,
             is_current)
VALUES     (0,
            0,
            'Unknown',
            'Unknown',
            'Unknown',
            0,
            '1900-01-01',
            NULL,
            1)

SET IDENTITY_INSERT TerritoryDim OFF

-- Create Foreign Key
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'SalesFact')
  ALTER TABLE SalesFact
    ADD CONSTRAINT FK_SalesFact_TerritoryDim FOREIGN KEY (territory_SK)
    REFERENCES TerritoryDim(territory_PK);

-- create indexes
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'TerritoryDim_territoryBK'
                  AND object_id = Object_id('TerritoryDim'))
	DROP INDEX TerritoryDim.TerritoryDim_territoryBK;
go
CREATE INDEX TerritoryDim_territoryBK
ON TerritoryDim(territory_BK); 


