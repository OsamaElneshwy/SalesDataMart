USE SalesAdventureWorksDW2022
go

-- Dropping the foreign keys
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'FK_SalesFact_ProductDim'
           AND parent_object_id = Object_id('SalesFact'))
	ALTER TABLE SalesFact
    DROP CONSTRAINT FK_SalesFact_ProductDim;

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'ProductDim')
	DROP TABLE ProductDim
go
CREATE TABLE ProductDim
  (
     product_PK          INT NOT NULL IDENTITY(1, 1),      
     product_BK          INT NOT NULL,		 -- Business key
     product_name        NVARCHAR(50),
     Product_description NVARCHAR(400),
     product_subcategory NVARCHAR(50),
     product_category    NVARCHAR(50),
     color               NVARCHAR(15),
     model_name          NVARCHAR(50),
     reorder_point       SMALLINT,
     standard_cost       MONEY,

	 -- Metadata
     source_system_code  TINYINT NOT NULL,    

	 -- SCD
     start_date          DATETIME NOT NULL DEFAULT (Getdate()),       
     end_date            DATETIME,                                   
     is_current          TINYINT NOT NULL DEFAULT (1),                
     CONSTRAINT PK_ProductDim PRIMARY KEY CLUSTERED (product_PK)
  );

-- Insert unknown record to hundle messing values while doing ETL
SET IDENTITY_INSERT ProductDim ON

INSERT INTO ProductDim
            (product_PK,
             product_BK,
             product_name,
             Product_description,
             product_subcategory,
             product_category,
             color,
             model_name,
             reorder_point,
             standard_cost,
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
             'Unknown',
             0,
             0,
             0,
             '1900-01-01',
             NULL,
             1)

SET IDENTITY_INSERT ProductDim OFF

-- Create Foreign Key
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'SalesFact')
  ALTER TABLE SalesFact
    ADD CONSTRAINT FK_SalesFact_ProductDim FOREIGN KEY (product_SK)
    REFERENCES ProductDim(product_PK);

-- Create Indexes
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'ProductDim_productBK'
                  AND object_id = Object_id('ProductDim'))
	DROP INDEX ProductDim.ProductDim_productBK;
go
CREATE INDEX ProductDim_productBK
ON ProductDim(product_BK);

IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'ProductDim_productCategory'
                  AND object_id = Object_id('ProductDim'))
	DROP INDEX ProductDim.ProductDim_productCategory
go
CREATE INDEX ProductDim_productCategory
ON ProductDim(product_category);
