USE AdventureWorks2019;

-- Contact Details
	-- Way 1 : Where Clause
SELECT p.Title, p.FirstName, p.LastName, e.EmailAddress, ph.PhoneNumber 
FROM Person.Person p, Person.EmailAddress e , Person.PersonPhone ph WHERE
p.BusinessEntityID = e.BusinessEntityID AND
p.BusinessEntityID = ph.BusinessEntityID;
	-- Way 2 : Joins
SELECT p.Title, p.FirstName, p.LastName, e.EmailAddress, ph.PhoneNumber 
	FROM Person.Person p
INNER JOIN Person.EmailAddress e
	ON p.BusinessEntityID = e.BusinessEntityID
INNER JOIN Person.PersonPhone ph 
	ON p.BusinessEntityID = ph.BusinessEntityID

-- Switch Case Eg:
	-- Way 1
SELECT *,
PhoneType = 
	CASE PhoneNumberTypeID
		WHEN '1' THEN 'Cellphone'
		WHEN '2' THEN 'Landline'
		WHEN '3' THEN 'Fax'
	END
from Person.PersonPhone
ORDER BY BusinessEntityID;

	-- Way 2
SELECT *,
	CASE
		WHEN PhoneNumberTypeID = 1 THEN 'CELL'
		WHEN PhoneNumberTypeID = 2 THEN 'LANDLINE'
		WHEN PhoneNumberTypeID = 3 THEN 'FAX'
	END PhoneType
FROM Person.PersonPhone
ORDER BY PhoneNumber;

-- Joins

SELECT COUNT(*) AS BusinessEntityAddressCount FROM Person.BusinessEntityAddress;
SELECT COUNT(*) AS PersonCount FROM Person.Person;

-- Inner join
SELECT count(*) AS innerJoinCnt FROM 
Person.BusinessEntityAddress bea
	INNER JOIN 
Person.Person p 
	ON 
p.BusinessEntityID = bea.BusinessEntityID;

-- Right join
SELECT count(*) AS rightJoinCnt FROM 
Person.BusinessEntityAddress bea 
	RIGHT JOIN 
Person.Person p 
	ON 
p.BusinessEntityID = bea.BusinessEntityID;

-- Left Join
SELECT count(*) AS leftJoinCnt FROM 
Person.BusinessEntityAddress bea
	LEFT JOIN 
Person.Person p 
	ON 
p.BusinessEntityID = bea.BusinessEntityID;

-- Outer Join
SELECT count(*) AS outerJoinCnt FROM 
Person.BusinessEntityAddress bea
	FULL OUTER JOIN 
Person.Person p 
	ON 
p.BusinessEntityID = bea.BusinessEntityID;

-- Cross Join
SELECT count(*) AS crossJoinCnt FROM 
Person.BusinessEntityAddress bea
	CROSS JOIN
Person.Person p;