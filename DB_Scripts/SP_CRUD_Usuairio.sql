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

IF OBJECT_ID('SP_CRUD_Usuario') IS NOT NULL
    DROP PROCEDURE SP_CRUD_Usuario;
GO

CREATE PROCEDURE SP_CRUD_Usuario
    @Operacion CHAR(1), 
    @IdUsuario INT = NULL,
    @Nombre VARCHAR(100) = NULL,
    @FechaNacimiento DATE = NULL,
    @Sexo CHAR(1) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- A: AGREGAR (Insertar)
    IF @Operacion = 'A'
    BEGIN
        INSERT INTO Usuario (Nombre, FechaNacimiento, Sexo)
        VALUES (@Nombre, @FechaNacimiento, @Sexo);
        RETURN 1;
    END

    -- M: MODIFICAR (Actualizar)
    IF @Operacion = 'M'
    BEGIN
        UPDATE Usuario
        SET 
            Nombre = @Nombre,
            FechaNacimiento = @FechaNacimiento,
            Sexo = @Sexo
        WHERE Id = @IdUsuario;
        RETURN 1;
    END

    -- E: ELIMINAR (Borrar)
    IF @Operacion = 'E'
    BEGIN
        DELETE FROM Usuario
        WHERE Id = @IdUsuario;
        RETURN 1;
    END

    -- C: CONSULTAR (Listar todos / Consultar por ID)
    IF @Operacion = 'C'
    BEGIN
        SELECT 
            Id AS IdUsuario, 
            Nombre, 
            FechaNacimiento, 
            Sexo
        FROM Usuario
        WHERE @IdUsuario IS NULL OR Id = @IdUsuario;
    END

END
GO
