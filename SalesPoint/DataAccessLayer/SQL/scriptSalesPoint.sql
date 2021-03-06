USE [master]
GO
/****** Object:  Database [PointSales]    Script Date: 01/07/2020 04:36:37 p. m. ******/
CREATE DATABASE [PointSales]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PointSales', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\PointSales.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PointSales_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\PointSales_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PointSales] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PointSales].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PointSales] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PointSales] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PointSales] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PointSales] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PointSales] SET ARITHABORT OFF 
GO
ALTER DATABASE [PointSales] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [PointSales] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PointSales] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PointSales] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PointSales] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PointSales] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PointSales] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PointSales] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PointSales] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PointSales] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PointSales] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PointSales] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PointSales] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PointSales] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PointSales] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PointSales] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PointSales] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PointSales] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PointSales] SET  MULTI_USER 
GO
ALTER DATABASE [PointSales] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PointSales] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PointSales] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PointSales] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [PointSales] SET DELAYED_DURABILITY = DISABLED 
GO
USE [PointSales]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 01/07/2020 04:36:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Client](
	[ClientId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Email] [varchar](100) NULL,
	[Phone] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 01/07/2020 04:36:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Price] [decimal](18, 0) NULL,
	[Stock] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sale]    Script Date: 01/07/2020 04:36:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale](
	[SaleId] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Mount] [decimal](18, 0) NOT NULL,
	[DateSale] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[SaleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([ClientId])
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [ClientId]
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [ProductId]
GO
/****** Object:  StoredProcedure [dbo].[spGetSales]    Script Date: 01/07/2020 04:36:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[spGetSales]
as
Begin
select* from Sale where DateSale= CONVERT(date,GETDATE()) order by DateSale desc;
End
GO
/****** Object:  StoredProcedure [dbo].[spGetSalesDetails]    Script Date: 01/07/2020 04:36:38 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[spGetSalesDetails]
@SaleId int
as
Begin
select Product.ProductId,Product.Name,Sale.Quantity,Product.Price,Sale.Mount,Client.ClientId,Client.Name,Sale.DateSale from Product inner join Sale on Product.ProductId=Sale.ProductId
inner join Client on Client.ClientId=Sale.ClientId where Sale.SaleId=@SaleId
End
GO
USE [master]
GO
ALTER DATABASE [PointSales] SET  READ_WRITE 
GO
