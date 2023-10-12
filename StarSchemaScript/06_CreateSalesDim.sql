USE SalesAdventureWorksDW2022
go

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'SalesFact')
	DROP TABLE SalesFact;
go
CREATE TABLE SalesFact
  (
     product_SK     INT NOT NULL,             -- surrogate key as a forigen key
     customer_SK    INT NOT NULL,             -- surrogate key as a forigen key
     territory_SK   INT NOT NULL,             -- surrogate key as a forigen key
     date_SK		INT NOT NULL,             -- surrogate key as a forigen key
     sales_order_id VARCHAR(50) NOT NULL,    -- as a primary key
     line_number    INT NOT NULL,			 -- as a primary key
     quantity       INT,					 -- Measure
     unit_price     MONEY,					 -- Measure
     unit_cost      MONEY,					 -- Measure
     tax_amount     MONEY,					 -- Measure
     freight        MONEY,					 -- Measure
     extended_sales MONEY,					 -- Measure
     extened_cost   MONEY,					 -- Measure

	 -- Metadata
     created_at     DATETIME NOT NULL DEFAULT(Getdate()),  
	 
     CONSTRAINT PK_SalesFact PRIMARY KEY CLUSTERED (sales_order_id, line_number),
     CONSTRAINT FK_SalesFact_ProductDim FOREIGN KEY (product_SK) REFERENCES ProductDim(product_PK),
     CONSTRAINT FK_SalesFact_CustomerDim FOREIGN KEY (customer_SK) REFERENCES CustomerDim(customer_PK),
     CONSTRAINT FK_SalesFact_TerritoryDim FOREIGN KEY (territory_SK) REFERENCES TerritoryDim(territory_PK),
     CONSTRAINT FK_SalesFact_DateDim FOREIGN KEY (date_SK) REFERENCES DateDim(date_PK)
  );

-- Create Indexes for Product key
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'SalesFact_ProductDim'
           AND object_id = Object_id('SalesFact'))
	DROP INDEX SalesFact.SalesFact_ProductDim;
go
CREATE INDEX SalesFact_ProductDim
ON SalesFact(product_SK);

-- Create Indexes for Customer key
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'SalesFact_CustomerDim'
           AND object_id = Object_id('SalesFact'))
	DROP INDEX SalesFact.SalesFact_CustomerDim;
go
CREATE INDEX SalesFact_CustomerDim
ON SalesFact(customer_SK);

-- Create Indexes for Territor key
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'SalesFact_TerritoryDim'
           AND object_id = Object_id('SalesFact'))
  DROP INDEX SalesFact.SalesFact_TerritoryDim;
go
CREATE INDEX SalesFact_TerritoryDim
ON SalesFact(territory_SK);

-- Create Indexes for Order Date key
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'SalesFact_DateDim'
           AND object_id = Object_id('SalesFact'))
  DROP INDEX SalesFact.SalesFact_DateDim;
go
CREATE INDEX SalesFact_DateDim
ON SalesFact(date_SK); 