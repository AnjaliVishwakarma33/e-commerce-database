create database project_no;
use project_no;
create table seller(
seller_id int primary key,
name varchar(100),
seller_city varchar(100)
);
insert into seller values(1,"amazon","jhansi"),(2,"flipkart","delhi"),(3,"myntra","noida"),(4,"meesho","banglore"),(5,"shopsee","agra");
create table has(
seller_id int,
cust_id int,
foreign key(seller_id) references seller(seller_id),
foreign key(cust_id) references customer(cust_id)
);
insert into has values(1,1),(2,2),(3,3),(4,4),(5,5);
create table customer(
cust_id int primary key,
cust_name varchar(100),
cust_city varchar(100)
);
insert into customer values(1,"anj","jhansi"),(2,"riya","delhi"),(3,"vish","noida"),(4,"kashu","banglore"),(5,"haiga","agra");
create table viewing(
cust_id int,
p_id int,
foreign key(cust_id) references customer(cust_id),
foreign key(p_id) references products(p_id)
);
select * from viewing;
insert into viewing(cust_id,p_id) values(1,1),(2,2),(3,3),(4,4),(5,5);
create table products(
p_id int primary key,
p_name varchar(100),
category varchar(100),
cost int
);
insert into products values(1,"laptop","C",30000),(2,"watch","M",10000),
(3,"ring","F",7000),(4,"mobile","M",20000),(5,"earphone","F",5000);
create table addto(
p_id int,
cart_no int,
foreign key(p_id) references products(p_id),
foreign key(cart_no) references cart(cart_no)
);

create table cart(
cart_no int primary key,
quantity_of_each int,
total_cost int
);
insert into cart values(1,2,90000),(2,4,60000),(3,0,40000),(4,1,20000),(5,3,30000);
create table sendto(
cart_no int,
order_id int,
wishlist int,
foreign key(cart_no) references cart(cart_no),
foreign key(order_id) references ordering(order_id)
);
insert into sendto values(1,1,5),(2,2,4),(3,3,5),(4,4,5),(5,5,6);
create table ordering(
order_id int primary key,
order_name varchar(100),
order_total int,
order_status varchar(100)
);
insert into ordering values(1,"laptop",10000,"delivered"),(2,"watch",20000,"Inprogress"),
(3,"ring",30000,"delivered"),(4,"mobile",40000,"Inprogress"),(5,"earphone",50000,"delivered");

select * from cart;
select * from customer;
select * from ordering;
select * from products;
select * from seller;

Using Call Procedure

create database callproject;
use callproject;
delimiter $$
create procedure `callproject`.run()
begin
create table seller(
seller_id int primary key,
name varchar(100),
seller_city varchar(100)
);
insert into seller values(1,"amazon","jhansi"),(2,"flipkart","delhi"),(3,"myntra","noida"),(4,"meesho","banglore"),(5,"shopsee","agra");
create table customer(
cust_id int primary key,
cust_name varchar(100),
cust_city varchar(100)
);
insert into customer values(1,"anj","jhansi"),(2,"riya","delhi"),(3,"vish","noida"),(4,"kashu","banglore"),(5,"haiga","agra");
create table has(
seller_id int,
cust_id int,
foreign key(seller_id) references seller(seller_id),
foreign key(cust_id) references customer(cust_id)
);
insert into has values(1,1),(2,2),(3,3),(4,4),(5,5);

create table products(
p_id int primary key,
p_name varchar(100),
category varchar(100),
cost int
);
insert into products values(1,"laptop","C",30000),(2,"watch","M",10000),
(3,"ring","F",7000),(4,"mobile","M",20000),(5,"earphone","F",5000);
create table viewing(
cust_id int,
p_id int,
foreign key(cust_id) references customer(cust_id),
foreign key(p_id) references products(p_id)
);

insert into viewing(cust_id,p_id) values(1,1),(2,2),(3,3),(4,4),(5,5);


create table cart(
cart_no int primary key,
quantity_of_each int,
total_cost int
);
insert into cart values(1,2,90000),(2,4,60000),(3,0,40000),(4,1,20000),(5,3,30000);
create table addto(
p_id int,
cart_no int,
foreign key(p_id) references products(p_id),
foreign key(cart_no) references cart(cart_no)
);


create table ordering(
order_id int primary key,
order_name varchar(100),
order_total int,
order_status varchar(100)
);
insert into ordering values(1,"laptop",10000,"delivered"),(2,"watch",20000,"Inprogress"),
(3,"ring",30000,"delivered"),(4,"mobile",40000,"Inprogress"),(5,"earphone",50000,"delivered");
create table sendto(
cart_no int,
order_id int,
wishlist boolean,
foreign key(cart_no) references cart(cart_no),
foreign key(order_id) references ordering(order_id)
);
select * from cart;
select * from customer;
select * from ordering;
select * from products;
select * from seller;
select * from customer order by cust_city;
alter table products
rename column p_id to prod_id,
rename column p_name to prod_name,
rename column category to prod_category,
rename column cost to prod_cost;
select customer.cust_name,customer.cust_id,viewing.p_id from customer
INNER JOIN viewing on customer.cust_id=viewing.cust_id
where 1< (select count(p_id) from viewing);
select customer.cust_name,customer.cust_id,viewing.p_id from customer
INNER JOIN viewing on customer.cust_id=viewing.cust_id
where customer.cust_name like "a%a"and 1< (select count(p_id) from viewing);
select s.order_id,c.quantity_of_each,c.total_cost from cart c
INNER JOIN (sendto s INNER JOIN ordering o on s.order_id=o.order_id) on s.cart_no=c.cart_no
where total_cost>10000 and order_status="delivered" and quantity_of_each>1;
end $$
call run();
