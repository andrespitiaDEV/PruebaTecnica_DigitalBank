
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'DB_Usuarios')
BEGIN
    CREATE DATABASE DB_Usuarios;
END
GO

USE DB_Usuarios;
GO

IF OBJECT_ID('Usuario') IS NOT NULL
    DROP TABLE Usuario;
GO

CREATE TABLE Usuario (	
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo CHAR(1) NOT NULL 
        CHECK (Sexo IN ('M', 'F')) 
);
GO
