CREATE PROCEDURE SP_TRAERCLIENTE
@DNI NCHAR(10)
AS
SELECT Clientes.Nombre_CL,Clientes.Apellido_CL,Clientes.Direccion_CL,Clientes.Telefono_CL,Clientes.DNI_CL
From Clientes
Where DNI_CL = @DNI
GO

EXEC SP_TRAERCLIENTE '12'