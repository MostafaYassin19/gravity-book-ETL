--creating the DWH tables Dim,Facts
create table Dim_Book(
PK_BookID int IDENTITY(1,1) primary key ,
BookID_BK int 
,Title varchar(400)
,isbn13 varchar(400)
,LanguageID_BK int 
,LanguageCode varchar(8)
,LanguageName varchar(50)
,NumOfPages int
,PublicationDate date
,PublisherID_BK int 
,PublisherName nvarchar(1000)
,StartDAte datetime
,EndDate datetime
,IsCurrent bit
)

go

CREATE TABLE [dbo].[Dim_Customer](
	[PK_CustomerID] [int] IDENTITY(1,1) primary key,
	[CustomerID_BK] [int] ,
	[Fname] [varchar](200) NULL,
	[Lname] [varchar](200) NULL,
	[Email] [varchar](350) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[IsCurrent] [bit] NULL
	)

	go

	CREATE TABLE [dbo].Dim_Shipping(
	PK_ShippingID [int] IDENTITY(1,1) primary key,
	[ShippingmethodID_BK] [int]  NULL,
	[MethodName] [varchar](100) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[IsCurrent] [bit] NULL
	)

	go
	create table Fact_Sales	(
	PK_SalesID int IDENTITY(1,1) primary key
      ,FK_ShippingID int not null
      ,FK_customerID int not null
      ,FK_bookID int not null
      ,FK_date int not null
	  ,ShippingCost decimal(6,2) NULL
      ,Price decimal(5,2)
	  )
		
		go


		CREATE TABLE [dbo].Dim_status(
	PK_statusID [int] IDENTITY(1,1) primary key,
	[StatusID_BK] [int]  NULL,
	[StatusValue] [varchar](20) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[IsCurrent] [bit] NULL
	)
	go
	create table Fact_Order_History (
	PK_OrderHistory [int] IDENTITY(1,1) primary key,
	OrderID_BK int ,
	Status1Date_FK int,
    Status2Date_FK int,
    Status3Date_FK int,
    Status4Date_FK int, 
	Status5Date_FK int,
    Status6Date_FK int 
	)

	go
	create table Author (
	PK_authorID int identity (1,1) primary key,
	authorID_BK int ,
	author varchar(400),
	FK_BookID int,
	BookID_BK int,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[IsCurrent] [bit] NULL
	)
	go
	create table [address](
	PK_addressID int identity (1,1) primary key,
	addressStatus varchar(30),
	addressID_BK int,
	streetNUM varchar(10),
	streetName varchar(200),
	city varchar(100),
	countryName varchar(200),
	FK_customerID int,
	CustomerID_BK int,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[IsCurrent] [bit] NULL
	)


