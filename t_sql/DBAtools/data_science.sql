USE [master]
GO
/****** Object:  Database [data_science]    Script Date: 12/1/2019 9:01:54 PM ******/
CREATE DATABASE [data_science]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'myDatabase', FILENAME = N'/var/opt/mssql/data/data_science.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'myDatabase_log', FILENAME = N'/var/opt/mssql/data/data_science.ldf' , SIZE = 13632KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [data_science] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [data_science].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [data_science] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [data_science] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [data_science] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [data_science] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [data_science] SET ARITHABORT OFF 
GO
ALTER DATABASE [data_science] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [data_science] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [data_science] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [data_science] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [data_science] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [data_science] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [data_science] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [data_science] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [data_science] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [data_science] SET  DISABLE_BROKER 
GO
ALTER DATABASE [data_science] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [data_science] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [data_science] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [data_science] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [data_science] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [data_science] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [data_science] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [data_science] SET RECOVERY FULL 
GO
ALTER DATABASE [data_science] SET  MULTI_USER 
GO
ALTER DATABASE [data_science] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [data_science] SET DB_CHAINING OFF 
GO
ALTER DATABASE [data_science] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [data_science] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [data_science] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'data_science', N'ON'
GO
ALTER DATABASE [data_science] SET QUERY_STORE = OFF
GO
USE [data_science]
GO
/****** Object:  User [georgiem]    Script Date: 12/1/2019 9:01:54 PM ******/
CREATE USER [georgiem] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Schema [titanic]    Script Date: 12/1/2019 9:01:55 PM ******/
CREATE SCHEMA [titanic]
GO
/****** Object:  Table [titanic].[results]    Script Date: 12/1/2019 9:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [titanic].[results](
	[PassengerId] [int] NOT NULL,
	[Survived] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PassengerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [titanic].[test]    Script Date: 12/1/2019 9:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [titanic].[test](
	[PassengerId] [int] NOT NULL,
	[Pclass] [int] NULL,
	[Name] [nvarchar](255) NULL,
	[Sex] [nvarchar](50) NULL,
	[Age] [int] NULL,
	[SibSp] [int] NULL,
	[Parch] [int] NULL,
	[Ticket] [nvarchar](50) NULL,
	[Fare] [nvarchar](50) NULL,
	[Cabin] [nvarchar](50) NULL,
	[Embarked] [nchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[PassengerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [titanic].[train]    Script Date: 12/1/2019 9:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [titanic].[train](
	[PassengerId] [int] NOT NULL,
	[Survived] [int] NULL,
	[Pclass] [int] NULL,
	[Name] [nvarchar](255) NULL,
	[Sex] [nvarchar](50) NULL,
	[Age] [int] NULL,
	[SibSp] [int] NULL,
	[Parch] [int] NULL,
	[Ticket] [nvarchar](50) NULL,
	[Fare] [nvarchar](50) NULL,
	[Cabin] [nvarchar](50) NULL,
	[Embarked] [nchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[PassengerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [data_science] SET  READ_WRITE 
GO
