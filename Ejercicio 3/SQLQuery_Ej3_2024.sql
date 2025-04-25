Use EJ_3_2024
GO

--Ej 3.1
Select NombreSucursal_SUC, IdSucursal_SUC
From Sucursales
GO

--Ej 3.2
Select DNI_CL, Nombre_CL, Apellido_CL, Direccion_CL, CuentasXCliente.IdSucursal_CuXCl, Sucursales.DireccionSucursal_SUC
From Clientes Inner Join CuentasXCliente on Clientes.DNI_CL = CuentasXCliente.DNICliente_CuXCl Inner Join Sucursales
On CuentasXCliente.IdSucursal_CuXCl = Sucursales.IdSucursal_SUC
Where Clientes.DNI_CL = ''
GO

--Ej 3.3
Select DNI_CL,Nombre_CL,Apellido_CL,Direccion_CL,CuentasXCliente.NumeroCuenta_CuXCl
From Clientes Inner Join CuentasXCliente on Clientes.DNI_CL = CuentasXCliente.DNICliente_CuXCl
Where Clientes.DNI_CL = ''
GO

--Ej 3.4
Select Monto_TR, Clientes.Nombre_CL
From Transacciones Inner Join Clientes
On Transacciones.DniCliente_TR = Clientes.DNI_CL
Where Monto_TR = (Select Max (Monto_Tr) from Transacciones) --Subconsulta
GO

--Ej 3.5
Select Nombre_CL,Apellido_CL,Direccion_CL,CuentasXCliente.NumeroCuenta_CuXCl,Cuentas.Saldo_CU,Sucursales.DireccionSucursal_SUC
From Clientes Inner Join CuentasXCliente 
On Clientes.DNI_CL = CuentasXCliente.DNICliente_CuXCl Inner Join Cuentas
On CuentasXCliente.NumeroCuenta_CuXCl = Cuentas.NumeroCuenta_CU Inner Join Sucursales
On Cuentas.IdSucursal_CU = Sucursales.IdSucursal_SUC
Where Clientes.DNI_CL = '13'
GO

--Funciones de agregado

--Trans MAX por cliente
Select Max (Monto_TR) as MontoMaximo, DniCliente_TR, Clientes.Nombre_CL
From Transacciones Inner Join Clientes On Transacciones.DniCliente_TR = Clientes.DNI_CL
Group by DniCliente_TR, Clientes.Nombre_CL
GO

--Ejemplo SUM
Select Sum (Monto_TR) as MontoMaximo
From Transacciones
GO


--Ejemplo AVG
Select AVG (Monto_TR) as MontoPromedio
From Transacciones
GO

--Ejemplo Count. Cuenta la cantidad de registros. NO USAR EL * !!
Select Count (Monto_T) as ContadorMontos
From Transacciones
GO