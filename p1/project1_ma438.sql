----Query1
select ProductName, to_char(avg(NVL(Discount, 0)), 99.99) as AverageDiscount
from Product
full outer join OrderItems on Product.ProductId = OrderItems.ProductId
group by ProductName
order by AverageDiscount desc;
----Query2
select PhoneNo, count(PhoneNo) as CountOfCustomers
from Customer
group by PhoneNo
having count(PhoneNo) > 1
order by count(PhoneNo) desc;
----Query3
select Product.ProductId, Product.ProductName, Supplier.FirstName, Supplier.LastName
from Product
inner join Supplier on Supplier.SupplierId = Product.SupplierId
inner join Inventory on Inventory.ProductId = Product.ProductId
where Inventory.TotalStock = 0
order by ProductId;
----Query4
select CustomerId,lastName, to_char(avg(Discount), 99.99) as AverageDiscount
from
(select Customer.CustomerId, Customer.lastName, OrderItems.Discount
from Customer
inner join Orders on Customer.CustomerId = Orders.CustomerId
inner join OrderItems on OrderItems.OrderId = Orders.OrderId)
group by CustomerId, lastName
order by CustomerId;
----Query5
select ProductName, sum(Quantity) as NumberOfItemsSold
from
(select Product.ProductName, OrderItems.Quantity
from Product
inner join OrderItems on OrderItems.ProductId = Product.ProductId)
group by ProductName
order by NumberOfItemsSold desc;
----Query6
select distinct FirstName, LastName, PhoneNo
from Customer
inner join Orders on Orders.CustomerId = Customer.CustomerId
where Orders.Status = 'delayed'
order by FirstName;
----Query7
select *
from
(select CustomerId, to_char(sum(UnitPrice), 99.99) as Revenue
from Orders
inner join OrderItems on Orders.OrderId = OrderItems.OrderId
group by CustomerId
order by Revenue desc)
where rownum <= 4;
----Query8
select *
from
(select Category, count(distinct CustomerId) as DistinctNumberOfCustomers
from
(select Category, CustomerId
from OrderItems
inner join Orders on Orders.OrderId = OrderItems.OrderId
inner join Product on Product.ProductId = OrderItems.ProductId)
group by Category
order by DistinctNumberOfCustomers desc)
where rownum <= 3;
----Query9
select FirstName, lastName, OrderItems.OrderId, to_char((UnitPrice * (1 - Discount / 100) * Quantity), 99.99) as TotalAmount
from Customer
inner join Orders on Customer.CustomerId = Orders.CustomerId
inner join OrderItems on OrderItems.OrderId = Orders.OrderId
where Orders.Status = 'delayed' and (UnitPrice * (1 - Discount / 100) * Quantity) >= 1000
order by TotalAmount desc;
----Query10
select *
from
(select Supplier.SupplierId, Supplier.LastName, count(distinct Product.ProductId) as NumberOfDifferentProducts
from Supplier
inner join Product on Product.SupplierId = Supplier.SupplierId
group by Supplier.SupplierId, Supplier.LastName)
where NumberOfDifferentProducts >= 3
order by NumberOfDifferentProducts desc;
