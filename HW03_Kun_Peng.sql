	/*
1.1 Product
Attribute Name Attribute Type
productCode alphanumeric
productName alphanumeric

1.1.1 Constraints
1. Product codes must be unique.
2. Product names must be unique.
3. Product code is the primary key.
*/

create table product(
productCode varchar(8) not null,
productName varchar(30) not null,
primary key (productCode),
unique key (productName)
);

/*
1.2 compCatIdComponentCategory
Attribute Name Attribute Type
compCatId AUTO INCREMENT integer
compCatName alphanumeric
1.2.1 Constraints
1. componentCategory ids must be unique.
2. componentCategory names must be unique.
3. componentCategory id is the primary key.
4. componentCategory name may NOT be undefined.
*/

create table componentCategory(
compCatId integer not null auto_increment,
compCatName varchar(30),
primary key (compCatId),
unique key (compCatName)
);

/*
1.3 Component
Attribute Name Attribute Type
compId AUTO INCREMENT integer
compName alphanumeric
compCatId reference to componentCategory/compCatId
1.3.1 Constraints
1. Component ids must be unique.
2. compId is the primary key.
*/

create table Component(
compId integer not null auto_increment,
compName varchar(30) not null,
compCatId integer not null,
primary key (compId),
foreign key (compCatId) references componentCategory(compCatId)
);

/*
1.4 Unit
Attribute Name Attribute Type
unitId AUTO INCREMENT integer
unitName alphanumeric
1.4.1 Constraints
1. unitId is the primary key.
2. Unit names and ids must be unique.
*/

create table Unit(
unitId integer not null auto_increment,
unitName varchar(30) not null,
primary key (unitId),
unique key (unitName)
);

/*
1.5 RecipeItem
Attribute Name Attribute Type
recipeItemId AUTO INCREMENT integer
productCode reference to product/productCode
compCatId reference to componentCategory/compCatId
qty real number
unitId reference to unit/unitId
compId reference to component/compId
1.5.1 Constraints
1. recipeItemId is the primary key.
2. Each combination of productCode, compCatId, and compId must be
unique.
*/

create table RecipeItem(
recipeItemId integer not null auto_increment,
productCode varchar(8) not null,
compCatId integer not null,
qty float not null,
unitId integer not null,
compId integer not null,
primary key (recipeItemId),
unique key (productCode, compCatId, compId),
foreign key (productCode) references product(productCode),
foreign key (compCatId) references componentCategory(compCatId),
foreign key (unitId) references Unit(unitId),
foreign key (compId) references component(compId)
);

/*
1.6 Location
Attribute Name Attribute Type
locationId AUTO INCREMENT integer

Attribute Name Attribute Type
locationName alphanumeric
locationAddress alphanumeric
locationCity alphanumeric
locationState alphanumeric
locationZip alphanumeric
1.6.1 Constraints
1. locationId is the primary key.
*/

create table Location(
locationId integer not null auto_increment,
locationName varchar(30) not null,
locationAddress varchar(80) not null,
locationCity varchar(30) not null,
locationState varchar(30) not null,
locationZip varchar(30) not null,
primary key (locationId)
);

/*
1.7 Menu
Attribute Name Attribute Type
menuId integer
menuName alphanumeric
1.7.1 Constraints
1. menuId is the primary key.
2. MenuName must be unique.
*/

create table Menu(
menuId integer not null,
menuName varchar(30) not null,
primary key (menuId),
unique key (menuName)
);

/*
1.8 MenuItem
Attribute Name Attribute Type
menuItemId AUTO INCREMENT integer
menuId reference to menuId
productCode reference to product/productCode
price money
1.8.1 Constraints
1. menuItemId id is the primary key.
2. A productCode may only be included up to one time on a menu.
*/

create table MenuItem(
menuItemId integer not null auto_increment,
menuId integer not null,
productCode varchar(8) not null,
price decimal(10, 2) not null,
primary key (menuItemId),
foreign key (productCode) references product(productCode),
unique key(productCode, menuId)
);

/*
1.9 Event
Attribute Name Attribute Type
eventId AUTO INCREMENT integer
eventName alphanumeric
eventStart datetime
eventEnd datetime
locationId reference to location/locationId
menuId reference to menu/menuId
1.9.1 Constraints
1. eventId is the primary key.
*/

create table Event(
eventId integer not null auto_increment,
eventName varchar(80) not null,
eventStart datetime not null,
eventEnd datetime not null,
locationId integer not null,
menuId integer not null,
primary key (eventId),
foreign key (locationId) references location(locationId),
foreign key (menuId) references menu(menuId)
);

/*
1.10 Employee
Attribute Name Attribute Type
employeeId AUTO INCREMENT integer
FrstName alphanumeric
lastName alphanumeric
DOB date
phone alphanumeric
We are only going to store one phone number for each employee (change from
Assignment 2)
1.10.1 Constraints
1. employeeId is the primary key.
*/

create table Employee(
employeeId integer not null auto_increment,
firstName varchar(30) not null,
lastName varchar(30) not null,
DOB date not null,
phone varchar(30) not null,
primary key (employeeId),
unique key (employeeId, phone)
);

/*
1.11 EventAssignment
Attribute Name Attribute Type
eventAssignmentId AUTO INCREMENT integer
eventId reference to event/eventId
employeeId reference to employee/employeeId
1.11.1 Constraints
1. eventAssignmentId is the primary key.
*/

create table EventAssignment(
eventAssignmentId integer not null auto_increment,
eventId integer not null,
employeeId integer not null,
primary key (eventAssignmentId),
foreign key (eventId) references event(eventId),
foreign key (employeeId) references Employee(employeeId)
);

/*
1.12 Ticket
Attribute Name Attribute Type
ticketId AUTO INCREMENT integer
eventId reference to event/eventId
ticketTime datetime
soldBy reference to employee/employeeId
numProducts number of products on the ticket
1.12.1 Constraints
1. ticketId is the primary key.
*/

create table Ticket(
ticketId integer not null auto_increment,
eventId integer not null,
ticketTime datetime not null,
soldBy integer not null,
numProducts integer not null,
primary key (ticketId),
foreign key (eventId) references event(eventId),
foreign key (soldBy) references employee(employeeId)
);

/*
1.13 ProductSold
Attribute Name Attribute Type
productSoldId AUTO INCREMENT integer
productCode reference to product/productCode
ticketId reference to ticket/ticketId
1.13.1 Constraints
1. productSoldId is the primary key.
*/

create table ProductSold(
productSoldId integer not null auto_increment,
productCode varchar(8) not null,
ticketId integer not null,
primary key (productSoldId),
foreign key (productCode) references product(productCode),
foreign key (ticketId) references Ticket(ticketId)
);

/*
1.14 ItemSold
Attribute Name Attribute Type
itemSoldId AUTO INCREMENT integer
productSoldId alphanumeric
compId reference to component/compId
qty real number
unitId reference to unit/unitId
1.14.1 Constraints
1. itemSoldId is the primary key.
*/

create table ItemSold(
itemSoldId integer not null auto_increment,
productSoldId integer not null,
compId integer not null,
qty float not null,
unitId integer not null,
primary key (itemSoldId),
foreign key (compId) references component(compId),
foreign key (unitId) references unit(unitId)
);

/*
3.0.1 Query 1
How many products are there? Return an integer count of unique product
codes in a column named `numProducts'.
*/

select count(distinct productCode) as numProducts from product;

/*
3.0.2 Query 2
What is the recipe for a `turtle sundae'? Return the component category
name, the component name, the quantity, and the unit name. Order by
recipeItemId.
*/

select recipeItemId, compName, compCatName, qty, unitName
from
(select recipeItemId, compCatId, qty, unitId, compId
from recipeItem
where productCode =
(select productCode from product
where productName = 'turtle sundae')) as a
join component as b
on a.compId = b.compId
join componentcategory as c
on a.compCatId = c.compCatId
join unit as d
on a.unitId = d.unitId
order by recipeItemId;

/*
3.0.3 Query 3
Show the number of cones (of any size, including wae cones) sold at each
event that took place at Valhalla. List each event and the total number of
cones sold. Order by the event start date/time.
*/

select sum(numProducts) as numsofCones from
(select distinct ticketId, numProducts from ticket
where eventId in
(select distinct eventId from event
where locationId =
(select locationId from location
where locationName = 'Valhalla'
))) a 
join 
ProductSold as b
on a.ticketId = b.ticketId
where b.productCode in
(select distinct productCode
from recipeItem
where compCatId =
(select compCatId from componentcategory
where compCatName = 'cone'));

/*
Compute the cost of each ticket.
Add an attribute named `totalPrice" to the ticket table and populate it.
The attribute should be able to hold US currency values.
To check your results, return the ticketId, numProducts and totalPrice for
tickets 170 and 1089. Sort by ticketId.
*/

alter table ticket
add column totalPrice decimal(10, 2) after numProducts;

create view ticketPrice as
select a.ticketId, sum(m.price) as totalPrice
from (
select ticketId, menuId from event as e
join ticket as t
on e.eventId = t.eventId) as a
join
(
select t.ticketId, productCode from productsold as p
join Ticket as t
on p.ticketId = t.ticketId) as b
on a.ticketId = b.ticketId
join menuitem as m
on m.menuId = a.menuId
and m.productCode = b.productCode
group by ticketId
order by ticketId;

set sql_safe_updates = 0;
update ticket as t
inner join ticketPrice as tp on t.ticketId = tp.ticketId
set t.totalPrice = tp.totalPrice
where t.ticketId = tp.ticketId;
set sql_safe_updates = 1;

drop view if exists ticketPrice;

/*
3.0.5 Query 5a
We want to maximize sales and work the most valuable events. To do
that, we need to know which events generate the most money per hour.
List the top 10 events by sales per hour. List the eventId, eventName,
locationName and price per hour, rounded to the nearest penny. List in
order from highest price per hour to lowest.
To determine the number of minutes between 2 timestamps, you may use:
TIME TO SEC(TIMEDIFF(endTime,startTime))/60
*/

select a.eventId, round(sale/timespan, 2) as salePerHour
from (
select eventId, sum(totalPrice) as sale from ticket 
group by eventId
order by eventId) a
join
(
select eventId, round(time_to_sec(timediff(eventEnd, eventStart))/3600, 2) as timeSpan
from event
order by eventId) b
on a.eventId = b.eventId
order by salePerHour desc
limit 10;

/*
3.0.6 Query 5b
Now restrict the query to the colleges. Which are the top 2 colleges for sales
per hour? Show the eventId, locationName and price per hour, rounded
to the nearest penny. Sort by price per hour.
*/


select a.eventId, round(sale/timespan, 2) as salePerHour
from (
select eventId, sum(totalPrice) as sale from ticket 
group by eventId
order by eventId) a
join
(
select eventId, round(time_to_sec(timediff(eventEnd, eventStart))/3600, 2) as timeSpan
from event
order by eventId) b
on a.eventId = b.eventId
where a.eventId in
(select eventId from event as e
join (select locationid from
location where 
locationName like '%college%') l
on e.locationId = l.locationId)
order by salePerHour desc
limit 10;

/*
3.0.7 Query 6a
In order to stock inventory, it's important to know the most popular items.
Which 3 toppings are ordered most frequently on ice cream cones, dishes
and wae cones (including extra toppings)? You may use product codes
in your query.
List the component name and quantity. Sort by quantity, descending.
*/

create view pSelected as
select distinct productSoldId from productsold
where productCode in
(select distinct r1.productCode 
from recipeItem as r1 
join recipeItem as r2
on 
r1.productCode = r2.productCode
where r1.compId in
(
select compId from component
where compCatId = 
(select compCatId from componentCategory
where compCatName = 'topping'))
and 
r2.compId in
(
select compId from component
where compName like '%cone%' or
compName like '%dish%'))
order by productSoldId;

select compName, Quantity from
(
select compId, sum(qty) as Quantity from 
ItemSold where 
productSoldId in (
select productSoldId from pSelected
)
group by compId
order by Quantity desc
limit 3) a
join component as b
where a.compId = b.compId;

drop view if exists pSelected;

/*
3.0.8 Query 6b
Similarly, we want to stop stocking items that do not get sold. Which
components are not used?
List the component id, name and category. Sory by component id.
*/

select cpnt.compId, cpnt.compName, cc.compCatName
from component as cpnt join
(select c.compId from component as c
left join itemSold as i
on c.compId = i.compId
where i.compId is null) as idSlct
on cpnt.compId = idSlct.compId
join 
componentcategory as cc
on cpnt.compCatId = cc.compCatId
order by compId;

/*
3.0.9 Query 7a
The food truck's budget is pretty small. Consequently, there is no money
available to hire a web developer to create a product builder front-end.
Instead, we will write SQL code to add elements to the database.
A long standing Rice Undergraduate tradition is `Beer Debates." This year
there is a new twist: serving beer 
oats.
Write the SQL code to add a new event `Beer Debate", held at `Willy's
Pub". Willy's Pub's address is `RMC Basement". The Beer debate will
be held on November 9, 2017, from 7 - 11 PM. The event will have a new,
restricted menu, named `Beer event", with menuId 5. The only products
that will be sold are Beer (product code `be'), existing drinks, and beer

oats (product code `bd' for beer debate). Beer will cost $5 and a beer

oat $7. Regular drinks will cost $1.
Beer and beer 
oats fall into the category `alcoholic beverage".
A 
oat consists of 12 ounces of beer, 5 ounces of ice cream and is sold with
a tall napkin and a long spoon. It is served in a 20 ounce cup.
When adding the recipe items, you may only use product and component
names and categories, not ids for the newly added items. You may use
compId, compCatId, unitId, etc. for existing items.
*/

insert into location (locationId, locationName, locationAddress,
 locationCity, locationState, locationZip)
 values
 (0 ,'Willy\'s Pub', 'RMC Basement', 'Houston', 
 'Texas', '77005');

insert into Menu(MenuId, MenuName)
values
(5, 'Beer event');

insert into product (productCode, productName)
values
('be', 'beer'),
('bd', 'beer float');

insert into componentCategory (compCatName)
values
('alcoholic beverage');

set @compCatId4Topping = 
(select compCatId from componentcategory
where compCatName = 'topping');

set @compCatId4Achol = 
(select compCatId from componentCategory
where compCatName = 'alcoholic beverage');

insert into component(compName, compCatId)
values
('ice cream', @compCatId4Topping),
('beer', @compCatId4Achol);

set @compId4Beer =
(select compId from component
where compName = 'beer');

set @compId4Cup =
(select compId from component
where compName = '20 oz cup');

set @compId4TopNapkin =
(select compId from component
where compName = 'Tall Napkin');

set @compId4IceCream =
(select compId from component
where compName = 'Ice Cream');

insert into RecipeItem(recipeItemId, productCode, compCatId, qty,
unitId, compId)
values
/* beer */
/* 5 ounces beer */
(0, 'be', @compCatId4Achol, 5, 1, @compId4Beer),
/* 20 oz cup */
(0, 'be', 3, 1, 3, @compId4cup),
/* tall napkin */
(0, 'be', 5, 1, 3, @compId4TopNapkin),
/* beer float */
/* 5 ounces beer */
(0, 'bd', @compCatId4Achol, 5, 1, @compId4Beer),
/* 20 oz cup */
(0, 'bd', 3, 1, 3, @compId4cup),
/* tall napkin */
(0, 'bd', 5, 1, 3, @compId4TopNapkin),
/* 5 ounces of ice cream */
(0, 'bd', @compCatId4Topping, 5, 1, @compId4IceCream),
/* 1 long spoon*/
(0, 'bd', 13, 1, 3, 41);


insert into MenuItem(menuId, productCode, price)
values
(5, 'be', 5),
(5, 'bd', 7),
(5, 'dk', 1);

set @locationId4BD =
(select locationId from location
where locationName = 'Willy\'s pub');

insert into Event(eventName, eventStart, eventEnd,
locationId, menuId)
values
('Beer Debate', '2017-11-09 19:00:00', '2017-11-09 23:00:00',
@locationId4BD, 5);

/*
3.0.10 Query 7b
Write a query to show the menu items on the new menu. For each item, list
the menu name, productCode, productName and price. Sort by product
code.
*/

select menuItem.productCode, menu.menuName, product.productName, price
from menu join
menuitem
on menu.menuId = menuitem.menuId
join product
on menuitem.productCode = product.productCode
order by productCode;

/*
3.0.11 Query 7c
Run your query from #2 to show the recipe for a beer 
oat.
*/

select recipeItemId, compName, compCatName, qty, unitName
from
(select recipeItemId, compCatId, qty, unitId, compId
from recipeItem
where productCode =
(select productCode from product
where productName = 'beer float')) as a
join component as b
on a.compId = b.compId
join componentcategory as c
on a.compCatId = c.compCatId
join unit as d
on a.unitId = d.unitId
order by recipeItemId;

/*
3.0.12 Query 8a
In hindsight, `Beer event' is too general of a menu name. Change the
menu name to `Beer Debate Menu'. Access the existing record by the
menu name, not the id. Show your SQL statement that executes this
change.
*/

update menu
set 
menuName = 'Beer Debate Menu'
where menuName = 'Beer event';

/*
3.0.13 Query 8b
Rerun your query from 7b, but showing menu items for menus named
'Beer event' and `Beer Debate Menu'.
*/
select menu.menuName, menuItem.productCode, product.productName, price
from menu join
menuitem
on menu.menuId = menuitem.menuId
join product
on menuitem.productCode = product.productCode
where menu.menuName = 'Beer event'
or
menu.menuName = 'Beer Debate Menu';

/*
3.1 Short answer questions (2.5 points each)
*/

/*
3.1.1 Short answer 1
What alternatives did you consider for string lengths and data types in
your tables? How did you decide which to use?
*/

/*
3.1.2 Short answer 2
What different numeric types did you use? Why did you choose those?
*/
'I used float, integer, decimal in this homework.'
'I chose float to represent precise numbers, because it can present'
'the value with out any motification. Like quantity of items, whican can be long decimal.'
'I chose integer to calculate real world items, like numbers of '
'cups of coffee, which can only be integer.'
'Decimal: for money, because money can be showed in 2 digit decimals.'

/*
3.2 Survey (5 points)
It took me approximately N hours to complete this assignment, where N
is:
*/
'About 20 hours'
/*
My favorite 
avor of ice cream is:
*/
'Tibetan barley flavor, I bet you\' never heared about it, and you should try it!'

