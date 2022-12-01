USE AdventureWorks2019;

-- 1: Entities without emailAddress
	-- Way 1
SELECT COUNT(*) AS Entities_Without_Email FROM 
(
	SELECT BusinessEntityID AS Entities_Without_Email FROM Person.BusinessEntity
		EXCEPT
	SELECT BusinessEntityID FROM Person.EmailAddress
) temp;

	-- Way 2
SELECT COUNT(BusinessEntityID) AS Entities_Without_Email FROM Person.BusinessEntity 
WHERE BusinessEntityID NOT IN (SELECT BusinessEntityID FROM Person.EmailAddress);

-- 2: Product Cost and Margins
	-- Way 1
SELECT prd.Name, prd.ListPrice, prd.StandardCost, (prd.ListPrice-prd.StandardCost) as profit_margin FROM Production.Product prd
INNER JOIN Production.ProductCostHistory pch
ON prd.ProductID = pch.ProductID order by profit_margin DESC;

	-- Didn't Understand the significance of Join, Query works fine without it.
SELECT Name, ListPrice, StandardCost, (ListPrice-StandardCost) as Profit_Margin from Production.Product order by Profit_Margin DESC;

	-- Way 3
SELECT prd.Name, prd.ListPrice, prd.StandardCost as newCost, pch.StandardCost as oldCost, 
(prd.StandardCost-pch.StandardCost) as product_cost_difference,(prd.ListPrice-prd.StandardCost) as profit_margin 
FROM Production.Product prd
INNER JOIN Production.ProductCostHistory pch
ON prd.ProductID = pch.ProductID order by profit_margin DESC;

-- 3: Client List Information:
SELECT BusinessEntityID,  (FirstName + ' ' + LastName) as name FROM Person.Person
UNION
SELECT BusinessEntityID, Name FROM Sales.Store;
