-- DataFlow Window
-- ODBSource_Territory_Table
SELECT
	TerritoryID AS territory_BK,
	Name AS territory_name,
	CountryRegionCode AS country_code
FROM Sales.SalesTerritory

-- LKU_Country
SELECT
	country_id,
	counttry_name AS territory_country,
	country_code,
	country_region AS territory_group
FROM lookup_country