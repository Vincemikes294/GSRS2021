USE [GSRS]

-- Create Below Tables
CREATE TABLE [dbo].[User_Profile](
	[FName] [varchar](50) NOT NULL,
	[LName] [varchar](50) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Status] [varchar](50) NOT NULL,
 CONSTRAINT [PK_User_Profile] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[ContinuousSlopeOutput](
	[Unique_Id] [varchar](100) NOT NULL,
	[Max_Weight] [int] NOT NULL,
	[Max_Speed] [int] NOT NULL,
	[T_Desc] [int] NOT NULL,
	[T_Emerg] [int] NOT NULL,
	[T_Final] [int] NOT NULL,
	[Time] [int] NOT NULL
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[SeparateSlopeOutput](
	[Unique_Id] [varchar](100) NOT NULL,
	[Number_Grades] [int] NOT NULL,
	[Group_Number] [int] NOT NULL,
	[Max_Weight] [int] NOT NULL,
	[Max_Speed] [int] NOT NULL,
	[T_Desc] [int] NOT NULL,
	[T_Emerg] [int] NOT NULL,
	[T_Final] [int] NOT NULL,
	[Time] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ContinuousTempProfile](
	[Unique_Id] [varchar](100) NOT NULL,
	[T_Weight] [int] NOT NULL,
	[T_Speed] [int] NOT NULL,
	[T_Distance] [decimal](12, 3) NOT NULL,
	[T_Grade_Pct] [decimal](3, 3) NOT NULL,
	[T_Desc] [int] NOT NULL,
	[T_Emerg] [int] NOT NULL,
	[T_Final] [int] NOT NULL
) ON [PRIMARY]
GO


-- Create Below Table Types

CREATE TYPE [dbo].[CSlopeType] AS TABLE(
	[Unique_Id] [varchar](100) NOT NULL,
	[Max_Weight] [int] NULL,
	[Max_Speed] [int] NULL,
	[T_Desc] [int] NULL,
	[T_Emerg] [int] NULL,
	[T_Final] [int] NULL,
	[Time] [int] NULL
)
GO

CREATE TYPE [dbo].[SSlopeType] AS TABLE(
	[Unique_Id] [varchar](100) NOT NULL,
	[Number_Grades] [int] NOT NULL,
	[Group_Number] [int] NOT NULL,
	[Max_Weight] [int] NULL,
	[Max_Speed] [int] NULL,
	[T_Desc] [int] NULL,
	[T_Emerg] [int] NULL,
	[T_Final] [int] NULL,
	[Time] [int] NULL
)
GO

CREATE TYPE [dbo].[CTProfileType] AS TABLE(
	[Unique_Id] [varchar](100) NOT NULL,
	[T_Weight] [int] NOT NULL,
	[T_Speed] [int] NOT NULL,
	[T_Distance] [decimal](12, 3) NOT NULL,
	[T_Grade_Pct] [decimal](3, 3) NOT NULL,
	[T_Desc] [int] NOT NULL,
	[T_Emerg] [int] NOT NULL,
	[T_Final] [int] NOT NULL
)
GO

-- Create Below Stored Procedues Types

CREATE PROCEDURE [dbo].[CleanUpTableData]
	@LoggedOnUser VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	SET NOCOUNT ON;

	-- Insert statements for procedure here

	DECLARE @SQLString AS NVARCHAR(MAX)

	SET @SQLString = 'DELETE FROM dbo.ContinuousSlopeOutput WHERE Unique_Id LIKE ''' + @LoggedOnUser + '%'''
	EXECUTE sp_executesql @SQLString

	SET @SQLString = N'DELETE FROM dbo.SeparateSlopeOutput WHERE Unique_Id LIKE ''' + @LoggedOnUser + '%'''
	EXECUTE sp_executesql @SQLString

	
	SET @SQLString = N'DELETE FROM dbo.ContinuousTempProfile WHERE Unique_Id LIKE ''' + @LoggedOnUser + '%'''
	EXECUTE sp_executesql @SQLString

END
GO

CREATE PROCEDURE [dbo].[InsertCSlopeData]
	@RequestType VARCHAR(50),
	@SlopeType dbo.CSlopeType READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	SET NOCOUNT ON;

	-- Insert statements for procedure here

	DECLARE @SQLString AS NVARCHAR(MAX)

	IF @RequestType = 'ContinuousSlope'
		INSERT INTO dbo.ContinuousSlopeOutput SELECT * FROM @SlopeType
END
GO

CREATE PROCEDURE [dbo].[InsertSSlopeData]
	@RequestType VARCHAR(50),
	@SlopeType dbo.SSlopeType READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	SET NOCOUNT ON;

	-- Insert statements for procedure here

	DECLARE @SQLString AS NVARCHAR(MAX)


	IF @RequestType = 'SeparateSlope'
		INSERT INTO dbo.SeparateSlopeOutput SELECT * FROM @SlopeType	

END
GO

CREATE PROCEDURE [dbo].[InsertCTempProfileData]
	@CTProfileType dbo.CTProfileType READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	SET NOCOUNT ON;

	-- Insert statements for procedure here

	DECLARE @SQLString AS NVARCHAR(MAX)
	
		INSERT INTO dbo.ContinuousTempProfile SELECT * FROM @CTProfileType
END
GO
