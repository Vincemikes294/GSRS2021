USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [vampadu]    Script Date: 6/6/2021 2:29:46 PM ******/
CREATE LOGIN [admin] WITH PASSWORD=N'password', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

ALTER LOGIN [admin] ENABLE
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [admin]
GO

ALTER SERVER ROLE [securityadmin] ADD MEMBER [admin]
GO

ALTER SERVER ROLE [serveradmin] ADD MEMBER [admin]
GO

ALTER SERVER ROLE [setupadmin] ADD MEMBER [admin]
GO

ALTER SERVER ROLE [processadmin] ADD MEMBER [admin]
GO

ALTER SERVER ROLE [diskadmin] ADD MEMBER [admin]
GO

ALTER SERVER ROLE [dbcreator] ADD MEMBER [admin]
GO

ALTER SERVER ROLE [bulkadmin] ADD MEMBER [admin]
GO


