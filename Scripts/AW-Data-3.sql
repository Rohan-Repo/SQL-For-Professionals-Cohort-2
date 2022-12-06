USE AdventureWorks2019;

-- 1: Entities without emailAddress
	-- Way 1 : Temp
SELECT COUNT(*) AS Entities_Without_Email FROM 
(
	SELECT BusinessEntityID FROM Person.BusinessEntity
		EXCEPT
	SELECT BusinessEntityID FROM Person.EmailAddress
) temp;

	-- Way 2 : NOT IN Clause
SELECT COUNT(BusinessEntityID) AS Entities_Without_Email FROM Person.BusinessEntity 
WHERE BusinessEntityID NOT IN (SELECT BusinessEntityID FROM Person.EmailAddress);

	-- Way 3 : Temporary Table
SELECT BusinessEntityID INTO #test FROM Person.BusinessEntity
	EXCEPT 
SELECT BusinessEntityID FROM Person.EmailAddress;

SELECT * FROM #test;

SELECT COUNT(*) AS Entities_Without_Email FROM #test; 

-- 2: Product Cost and Margins
	-- Way 1
SELECT prd.Name, prd.ListPrice, prd.StandardCost, (prd.ListPrice-prd.StandardCost) as profit_margin FROM Production.Product prd
INNER JOIN Production.ProductCostHistory pch
ON prd.ProductID = pch.ProductID order by profit_margin DESC;

	-- Didn't Understand the significance of Join, Query works fine without it.
SELECT Name, ListPrice, StandardCost, (ListPrice-StandardCost) as Profit_Margin from Production.Product order by Profit_Margin DESC;

	-- Way 3
SELECT * FROM Production.ProductCostHistory;
-- Whereever EndDate is NULL in ProductCostHistory table, that's the Final StandardCost in Product table
-- So to check if we are using the final value we add the "IS NULL" check here
SELECT prd.Name, prd.ListPrice, prd.StandardCost,(prd.ListPrice-prd.StandardCost) as profit_margin 
FROM Production.Product prd
	INNER JOIN Production.ProductCostHistory pch
		ON prd.ProductID = pch.ProductID 
		AND pch.EndDate IS NULL
order by profit_margin DESC;

SELECT prd.Name, prd.ListPrice, prd.StandardCost,(prd.ListPrice-prd.StandardCost) as profit_margin 
	FROM Production.Product prd, Production.ProductCostHistory pch 
	WHERE prd.ProductID = pch.ProductID 
	AND pch.EndDate IS NULL
	order by profit_margin DESC;

-- 3: Client List Information:
	-- Way 1 : UNION
SELECT BusinessEntityID,  (FirstName + ' ' + LastName) as name FROM Person.Person
	UNION
SELECT BusinessEntityID, Name FROM Sales.Store;
	-- Way 2 : UNION ALL
SELECT BusinessEntityID,  (FirstName + ' ' + LastName) as name FROM Person.Person
	UNION ALL
SELECT BusinessEntityID, Name FROM Sales.Store;
