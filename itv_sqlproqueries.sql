use itv_sqlpro;

-- 1.It is used to get which product is purchased on which date and how many quantity was received?

SELECT purchases.PurchaseDate,purchases.NumberReceived,products.ProductName 
FROM purchases
JOIN products
ON(purchases.ProductId = products.p_id);

-- 2.This query is used to see which customer has bought which car

SELECT orders.First,products.ProductName
FROM orders
JOIN products
ON(orders.ProductID = products.p_id);

-- 3.Query to find which supplier has given which products

SELECT products.ProductName,supplier.Supplier_Name
FROM products
JOIN purchases
ON(products.p_id = purchases.ProductId)
JOIN supplier
ON(purchases.ProductId = supplier.s_id);

-- 4.
SELECT orders.OrderDate,products.ProductName
FROM orders
JOIN products
ON(orders.ProductID = products.p_id)
order by OrderDate;

-- 5.

SELECT products.ProductName,purchases.ProductId
FROM products
LEFT JOIN purchases
ON(products.p_id = purchases.ProductID)
order by products.ProductName
;

-- 6.

SELECT products.p_id,supplier.Supplier_Name,purchases.PurchaseDate,products.ProductName
FROM supplier
JOIN purchases
ON (supplier.s_id = purchases.SupplierId)
JOIN products
ON(purchases.ProductId = products.p_id)
order by PurchaseDate
; 

-- 7.

SELECT orders.First,products.ProductName
FROM orders
JOIN products
ON(orders.ProductID = products.p_id)
WHERE First like 'a%'
;

-- 8.

SELECT products.p_id,products.ProductName,orders.First,orders.Middle,orders.Last
FROM products
JOIN orders
ON(products.p_id = orders.ProductId)
Where First like 'a%' AND Middle like 'n%' AND Last like 'v%'
;

-- 9.

SELECT supplier.Supplier_Name,purchases.NumberReceived
FROM supplier
JOIN purchases
ON(supplier.s_id = purchases.SupplierId)
HAVING NumberReceived <= 10
order by NumberReceived
;

-- 10.

SELECT products.ProductName,orders.First,orders.OrderDate
FROM products
JOIN orders
ON(products.p_id = orders.ProductId)
where OrderDate  BETWEEN '2010-06-03' AND '2020-04-20'
order by OrderDate
limit 10
;


-- 11.

SELECT products.ProductName, avg(NumberShipped)
FROM products
JOIN orders
ON(products.p_id = orders.ProductId)
;

-- 12.

SELECT products.ProductName, purchases.NumberReceived as Received
FROM products
JOIN purchases
ON(products.p_id = purchases.ProductId)
Group by ProductName
Order By Received
;

-- 13.

SELECT concat(products.ProductName,' ',products.ProductLabel) as ProductDetails,
concat(orders.First,' ',orders.Middle,' ',orders.Last) as CustomerDetails
FROM Products
JOIN orders
ON(products.p_id = orders.ProductId)
order by CustomerDetails
;

-- 14.

SELECT concat(orders.First,' ',orders.Last) as CustomerDetails, products.ProductName, supplier.Supplier_Name
FROM orders
JOIN products
ON(orders.ProductId = products.p_id)
JOIN purchases
ON(products.p_id = purchases.ProductId)
JOIN supplier
ON(purchases.SupplierId = supplier.s_id)
limit 10
;

-- 15.

SELECT products.ProductName
FROM products
WHERE ProductName in (select ProductName from products where InventoryOnHand < 10);

-- 16.

SELECT products.ProductName as ProductDetails,products.MinimumRequired,orders.NumberShipped,orders.OrderDate
FROM products
JOIN orders
ON(products.p_id = orders.ProductId)
WHERE NumberShipped > (select avg(NumberShipped) from orders)
order by OrderDate
limit 10
;

-- 17.

SELECT products.ProductName,
case 
when InventoryOnHand <= 30 then "Minimal in Inventory"
when InventoryOnHand > 30 then "Good Stock in Inventory"
when InventoryOnHand > 70 then "Very Good Stock in Inventory"
else "No type set"
END as InventoryOnHand 
from products
;

-- 18.

SELECT YEAR(OrderDate) as Year, MONTH(OrderDate) as Month, sum(NumberShipped) AS Total_Shipped
FROM orders
group by year(OrderDate), month(OrderDate)
order by Year
limit 10
;

-- 19.

SELECT products.ProductName, sum(orders.NumberShipped) AS Shipped
FROM products
JOIN orders
ON(products.p_id = orders.ProductId)
group by ProductName
;


-- 20.

SELECT products.ProductName, orders.NumberShipped,orders.First,orders.Middle,orders.Last
FROM products
JOIN orders
ON (products.p_id = orders.ProductId)
HAVING NumberShipped <= 10
order by NumberShipped DESC 
limit 10
;