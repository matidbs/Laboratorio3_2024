Use EJ_3_2024
Go

--Ejercicio 3

--3.1 Consulta que informe las sucursales
Select NombreSucursal_SUC,IdSucursal_SUC
From Sucursales
Go

--3.2 Realizar una consulta que informe los datos de un cliente específico con su respectiva sucursal
Select Nombre_CL,Apellido_CL,DNI_CL,Direccion_CL,Telefono_CL,CuentasXCliente.IdSucursal_CuXCl,Sucursales.DireccionSucursal_SUC
From Clientes Inner Join CuentasXCliente
On Clientes.DNI_CL = CuentasXCliente.DNICliente_CuXCl Inner Join Sucursales
On CuentasXCliente.IdSucursal_CuXCl = Sucursales.IdSucursal_SUC
Where DNI_CL = '12'
Go

--3.3 Realizar una consulta que informe los datos de un cliente específico con sus respectivas cuentas
Select Nombre_CL,Apellido_CL,DNI_CL,Direccion_CL,Telefono_CL,CuentasXCliente.NumeroCuenta_CuXCl
From Clientes Inner Join CuentasXCliente
On Clientes.DNI_CL = CuentasXCliente.DNICliente_CuXCl
Where DNI_CL = '21'
Go

--3.4 Realizar una consulta que informe la mayor transacción y los datos del clienteSelect Nombre_CL,Apellido_CL,DNI_CL,Direccion_CL,Telefono_CL,Transacciones.Monto_TRFrom Clientes Inner Join TransaccionesOn Clientes.DNI_CL = Transacciones.DniCliente_TRWhere Monto_TR = (Select Monto_TR Max From Transacciones)--Cualquiera de las dos versiones sirveSelect Monto_TR, Clientes.Nombre_CL
From Transacciones Inner Join Clientes
On Transacciones.DniCliente_TR = Clientes.DNI_CL
Where Monto_TR = (Select Max (Monto_Tr) from Transacciones) --Subconsulta
GO--3.5 Realizar una consulta que informe los datos de un cliente específico con sus respectivas cuentas, sucursales y saldos.Select Nombre_CL,Apellido_CL,DNI_CL,Direccion_CL,Telefono_CL,CuentasXCliente.NumeroCuenta_CuXCl,Sucursales.NombreSucursal_SUC,Cuentas.Saldo_CUFrom Clientes Inner Join CuentasXClienteOn Clientes.DNI_CL = CuentasXCliente.DNICliente_CuXCl Inner Join CuentasOn CuentasXCliente.NumeroCuenta_CuXCl = Cuentas.NumeroCuenta_CU Inner Join SucursalesOn Cuentas.IdSucursal_CU = Sucursales.IdSucursal_SUCWhere DNI_CL = '21'--Ejercicio 3 Anexo /*3.6 Informe Nombre y apellido de todos los clientes cuyo nombre comience con
la primer letra distinta de ‘A’ y la segunda letra sea una ‘e’ seguida por
cualquier cadena.*/Select Nombre_CL,Apellido_CLFrom ClientesWhere Nombre_CL Like '[^a]e%'Go--3.7 Informe Nombre y apellido de todos los clientes cuyo apellido no comience con ‘S’ o ‘L’Select Nombre_CL,Apellido_CLFrom ClientesWhere Apellido_CL Like '[^sl]%'