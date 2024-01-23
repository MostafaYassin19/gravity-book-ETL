--Dimentions ETL join queries

SELECT book.book_id, book.title, book.isbn13
, book.language_id, book_language.language_code
, book_language.language_name, book.num_pages
, book.publication_date, book.publisher_id
, publisher.publisher_name
from book left join book_language
on book.language_id=book_language.language_id
left join publisher on book.publisher_id=publisher.publisher_id

go
select *
from customer

go
select method_id,method_name
from shipping_method
go

select* 
from order_status

go

select a.author_id,a.author_name,b.book_id
from book b left join book_author ba on b.book_id=ba.book_id
left join author a on ba.author_id =a.author_id

go

select aa.address_status,ca.address_id,a.street_number,a.street_name,a.city,cc.country_name, c.customer_id
from customer c left join customer_address ca on c.customer_id=ca.customer_id, address_status aa, address a, country cc
where aa.status_id=ca.status_id and ca.address_id=a.address_id and a.country_id=cc.country_id




--Fact ETL queries control metadata

create table control_FactSales_ETL
(id int primary key
,last_load_date datetime)

go

insert into control_FactSales_ETL
values (1, 1900-1-1)

go

select last_load_date from control_FactSales_ETL where id=1
go

select 
--updating last date due to etl system rundate

update control_FactSales_ETL 
set last_load_date=?
where id=1




--fact sales source query

use gravity_books
go
select sm.method_id,sm.cost,c.customer_id,b.book_id,co.order_date,ol.price
from
cust_order co left join order_line ol on ol.order_id=co.order_id left join
shipping_method sm on co.shipping_method_id=sm.method_id left join customer c on c.customer_id=co.customer_id 
left join book b on ol.book_id=b.book_id
where co.order_date >=   --user parameter  last_load_date
and   co.order_date <    --system variable starttime

go

--lookups

select DateSK,cast( [date] as date) as 'Date'
from Dimdate

go
select PK_customerId,customerID_BK
from Dim_customer
go
select PK_bookid,bookid_bk
from dim_book
go
select [PK_ShippingID],[ShippingmethodID_BK]
from [dbo].[Dim_Shipping]


--Fact_order_history source query


	   select co.order_id,a.status_date as'D1',b.status_date as'D2',c.status_date as'D3'
	   ,d.status_date as'D4',e.status_date as'D5',f.status_date as'D6'
	   from cust_order co left outer join order_history b on co.order_id=b.order_id and b.status_id=2
	   left outer join order_history c on co.order_id=c.order_id and c.status_id=3
	   left outer join order_history d on co.order_id=d.order_id and d.status_id=4
	   left outer join order_history e on co.order_id=e.order_id and e.status_id=5
	   left outer join order_history f on co.order_id=f.order_id and f.status_id=6 
	   left outer join order_history a on co.order_id=a.order_id and a.status_id=1
	   where co.order_id > ?


	   --control meta deta for fact sales history
	   create table last_order_id (id int primary key ,last_order_id int)

	   go
	   insert into last_order_id
	   values (1,1)
	   go
	   select last_order_id from last_order_id where id =1
	   go
	   select max(orderID_bk) from Fact_Order_history


	   
      update last_order_id 
      set last_order_id=?
      where id=1

