-- ControlFlow
--LoadLastDate
SELECT last_load_date
FROM MetadataControl
where source_table = 'sales order header'

-- UpdateLastDate
update MetadataControl
set last_load_date = ?
where source_table = 'sales order header'

-- DataFlow
-- SalesOrderHeader
SELECT
	SalesOrderID,
    SalesOrderNumber,
    CONVERT(date,OrderDate) AS date_BK,
    CustomerID as customer_BK,
    TerritoryID as territory_BK,
    TaxAmt,
    Freight
FROM Sales.SalesOrderHeader
WHERE 
	OnlineOrderFlag = 1 and 
	modifieddate >= ? and
	modifieddate <= ?
ORDER BY SalesOrderID

-- SelasOrderDetails
SELECT
	sod.SalesOrderID AS SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	ProductID as product_BK,
	UnitPrice,
	UnitPriceDiscount,
	LineTotal
FROM sales.SalesOrderDetail AS sod
	INNER JOIN sales.SalesOrderHeader AS soh
		ON sod.SalesOrderID = soh.SalesOrderID
WHERE
	OnlineOrderFlag = 1 and
	soh.ModifiedDate >= ? and 
	soh.ModifiedDate < ?
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
