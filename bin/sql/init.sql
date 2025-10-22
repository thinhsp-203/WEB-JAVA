-- SQL Server 2022 schema + seed
CREATE DATABASE WebAppDB;
GO
USE WebAppDB;
GO
CREATE TABLE [User](
  id INT IDENTITY(1,1) PRIMARY KEY,
  email NVARCHAR(100) NOT NULL,
  username NVARCHAR(50) NOT NULL UNIQUE,
  fullname NVARCHAR(100),
  password NVARCHAR(100) NOT NULL,
  avatar NVARCHAR(255),
  roleid INT DEFAULT 3,
  phone NVARCHAR(20),
  createdDate DATE DEFAULT GETDATE()
);
GO
INSERT INTO [User](email, username, fullname, password, roleid, phone) VALUES
('admin@example.com','admin',N'Administrator','123456',1,'0909123456'),
('manager@example.com','manager',N'Manager User','123456',2,'0909876543'),
('user@example.com','user',N'Normal User','123456',3,'0912345678');
GO
CREATE LOGIN webuser WITH PASSWORD = 'WebUser@123';
GO
CREATE USER webuser FOR LOGIN webuser;
GO
ALTER ROLE db_owner ADD MEMBER webuser;
GO
