-- ControlFlow Window
-- TruncateSalesFact
truncate table SalesFact

-- DataFlow Window
-- SalesOrderHeader
SELECT
	SalesOrderID,
    SalesOrderNumber,
    CONVERT(date,OrderDate) as date_BK,
    CustomerID as customer_BK,
    TerritoryID as territory_BK,
    TaxAmt,
    Freight
FROM Sales.SalesOrderHeader
WHERE OnlineOrderFlag = 1
ORDER BY SalesOrderID

-- SelasOrderDetails
SELECT
	SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	ProductID as product_BK,
	UnitPrice,
	UnitPriceDiscount,
	LineTotal
FROM sales.SalesOrderDetail
ORDER BY SalesOrderID

-- LKPCustomer
SELECT
	customer_PK,
	customer_BK
FROM CustomerDim
WHERE is_current = 1

-- LKPProduct
SELECT
	product_PK,
	product_BK,
	standard_cost
FROM ProductDim
WHERE is_current = 1

-- LKPTerritory
SELECT
	territory_PK,
	territory_BK
FROM TerritoryDim
WHERE is_current = 1

-- LKPDate
SELECT
	date_PK,
	full_date
FROM DateDim