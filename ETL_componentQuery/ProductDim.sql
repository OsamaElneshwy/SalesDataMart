-- DataFlow Window
-- ODBSource_Product_Table
SELECT 
	ProductID AS product_BK,
	Name AS product_name,
	Color,
	ReorderPoint AS reorder_point,
	StandardCost AS standard_cost,
	ProductSubcategoryID,
	ProductModelID
FROM Production.Product

-- LKU_Product_Model_Desc
SELECT
	pm.ProductModelID,
	pm.Name AS model_name,
	pd.Description AS Product_description
FROM [Production].[ProductModel] AS pm
	LEFT JOIN production.ProductModelProductDescriptionCulture AS pdi 
		ON pm.ProductModelID = pdi.ProductModelID
	LEFT JOIN [Production].[ProductDescription] AS pd
		ON pdi.ProductDescriptionID = pd.ProductDescriptionID
WHERE pdi.CultureID = 'en' OR pdi.CultureID IS null
UNION ALL
SELECT null,null,null

-- LKU_Product_Category_Subcategory
SELECT
	psc.ProductSubcategoryID,
	psc.Name AS product_subcategory,
	pc.name AS product_category
FROM [Production].[ProductSubcategory] AS psc
	LEFT JOIN [Production].[ProductCategory] AS pc
		ON psc.ProductCategoryID = pc.ProductCategoryID
UNION ALL
SELECT null,null,null