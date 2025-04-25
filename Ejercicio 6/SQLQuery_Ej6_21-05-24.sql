/*Creacion de base*/
CREATE DATABASE Ej_6_2024
ON
( NAME = Ej_6_2024_dat,
 FILENAME = 'C:\BASES\Ej_6_2024.mdf' )
GO 

Use Ej_6_2024
Go

Create Table Proveedores
(
CodProveedor_Pr char(4) NOT NULL,
RazonSocial_PR varchar(25) NOT NULL,
Direccion_PR varchar(25) NOT NULL,
Ciudad_PR varchar(25) NOT NULL,
Provincia_PR varchar(25) NOT NULL,
CUIT_PR varchar(25) NOT NULL,
Telefono_PR varchar(25) NOT NULL,
Contacto_PR varchar(25) NOT NULL,
Web_PR varchar(25) NOT NULL,
Email_PR varchar(25) NOT NULL,
Constraint PK_Proveedores Primary Key (CodProveedor_PR)
)
GO

Create Table Articulos
(
CodProveedor_AR char(4) NOT NULL,
CodArticulo_AR char(4) NOT NULL,
Descripcion_AR varchar(25) NOT NULL,
Stock_AR int NOT NULL,
PrecioUnitario_AR float NOT NULL,
Constraint PK_Articulos Primary Key (CodProveedor_AR,CodArticulo_AR),
Constraint FK_Articulos_Proveedores Foreign Key (CodProveedor_AR) References Proveedores (CodProveedor_PR)
)
GO

Create Table Clientes
(
DNI_CL char(8) NOT NULL,
Nombre_CL varchar(25) NOT NULL,
Apellido_CL varchar(25) NOT NULL,
Direccion_CL varchar(25) NOT NULL,
Telefono_CL varchar(25) NOT NULL,
Constraint PK_Clientes Primary Key (DNI_CL)
)
GO

Create Table Cuentas
(
CodCuenta_CU char(4) NOT NULL,
DNI_CU char(8) NOT NULL,
LimiteCuenta_CU float NOT NULL,
SaldoCuenta_CU float NOT NULL,
Constraint PK_Cuentas Primary Key (CodCuenta_CU),
Constraint FK_Cuentas_Clientes Foreign Key (DNI_CU) References Clientes (DNI_CL)
)
GO

Create Table Facturas
(
CodFactura_FA char(4) NOT NULL,
CodCuentaCliente_FA char(4) NOT NULL,
TotalFactura_FA float NOT NULL,
FechaFactura_FA date NOT NULL,
Constraint PK_Facturas Primary Key (CodFactura_FA),
Constraint FK_Facturas_Cuentas Foreign Key (CodCuentaCliente_FA) References Cuentas (CodCuenta_CU)
)
GO

Create Table DetalleFactura 
(
CodFactura_DF char(4) NOT NULL,
CodProveedor_DF char(4) NOT NULL,
CodArticulo_DF char(4) NOT NULL,
Cantidad_DF int NOT NULL,
PrecioUnitario_DF float NOT NULL,
Constraint PK_DetalleFactura Primary Key (CodFactura_DF,CodProveedor_DF,CodArticulo_DF),
Constraint FK_DetalleFactura_Articulos Foreign Key (CodProveedor_DF,CodArticulo_DF) References Articulos (CodProveedor_AR,CodArticulo_AR),
Constraint FK_DetalleFactura_Factura Foreign Key (CodFactura_DF) References Facturas (CodFactura_FA)
)
GO

/* Realice un procedimiento almacenado que devuelva los artículos mayores de
una determinada cantidad en stock. */

--Creacion
Create Procedure SP_TraerArticulosXStock
@CantStock int 
As
Select Articulos.CodArticulo_AR,Articulos.Descripcion_AR,Articulos.Descripcion_AR,Articulos.PrecioUnitario_AR
From Articulos 
Where Articulos.Stock_AR > @CantStock
Go


--Modificacion
Alter Procedure SP_TraerArticulosXStock
@CantStock int 
As
Select Articulos.CodArticulo_AR,Articulos.Descripcion_AR,Articulos.Stock_AR,Articulos.PrecioUnitario_AR
From Articulos 
Where Articulos.Stock_AR > @CantStock
Go

--Ejecucion
Exec SP_TraerArticulosXStock 102
Go


/* Informe la razón social del proveedor, el artículo y la inversión hasta el
momento en stock (stock * precio unitario) de un artículo determinado. Cree
procedimiento almacenado. */

Create Procedure SP_TraerProveedorXCodArticulo
@CodArticulo char(4)
As 
Select Proveedores.RazonSocial_PR, Articulos.Descripcion_AR, (Articulos.Stock_AR * Articulos.PrecioUnitario_AR) As Inversion
From Articulos Inner Join Proveedores
On Articulos.CodProveedor_AR = Proveedores.CodProveedor_Pr
Where Articulos.CodArticulo_AR = @CodArticulo
Go

Alter Procedure SP_TraerProveedorXCodArticulo
@CodArticulo char(4), @CodProveedor char(4)
As 
Select Proveedores.RazonSocial_PR, Articulos.Descripcion_AR, (Articulos.Stock_AR * Articulos.PrecioUnitario_AR) As Inversion
From Articulos Inner Join Proveedores
On Articulos.CodProveedor_AR = Proveedores.CodProveedor_Pr
Where Articulos.CodArticulo_AR = @CodArticulo And Articulos.CodProveedor_AR = @CodProveedor
Go

Create or Alter Procedure SP_TraerProveedorXCodArticulo
@CodArticulo char(4), @CodProveedor char(4)
As 
Select Proveedores.RazonSocial_PR, Articulos.Descripcion_AR, (Articulos.Stock_AR * Articulos.PrecioUnitario_AR) As Inversion
From Articulos Inner Join Proveedores
On Articulos.CodProveedor_AR = Proveedores.CodProveedor_Pr
Where Articulos.CodArticulo_AR = @CodArticulo And Articulos.CodProveedor_AR = @CodProveedor
Go

Exec SP_TraerProveedorXCodArticulo '30','01'
Go

/*Informe nombre y apellido en un solo campo llamado “nombre completo” de
los clientes que realizaron una compra de una cantidad mayor a 100 unidades
de un artículo. Cree procedimiento almacenado.*/

Create or Alter Procedure SP_TraerClientesMas100
As
Select Distinct Concat (Clientes.Nombre_CL,Clientes.Apellido_CL) as [Nombre completo]
From Clientes Inner Join Cuentas On
Clientes.DNI_CL = Cuentas.DNI_CU Inner Join Facturas On
Cuentas.CodCuenta_CU = Facturas.CodCuentaCliente_FA Inner Join DetalleFactura On
Facturas.CodFactura_FA = DetalleFactura.CodFactura_DF
Where DetalleFactura.Cantidad_DF > 3
Go


Exec  SP_TraerClientesMas100
Go

/*Crear un procedimiento almacenado con cualquier nombre y cualquier
selección de cualquier tabla y elimínelo desde una consulta utilizando la
sentencia correspondiente.*/
Create Procedure SP_PruebaEliminar
@Cualquier char (4)
As
Select Articulos.Descripcion_AR
From Articulos
Where Articulos.CodArticulo_AR = @Cualquier
Go

Drop Procedure SP_PruebaEliminar
Go

/*Crear una tabla llamada “TablaDePrueba” con tres campos nchar de 8 no
nulos: Dni, nombre y apellido. El campo Dni será clave */
Create Table TablaDePrueba
(
Dni nchar(8) NOT NULL,
Nombre nchar(8) NOT NULL,
Apellido nchar(8) NOT NULL,
Constraint PK_TablaDePrueba Primary Key (Dni)
)
Go

/*Insertar un registro en la tabla anterior con Dni = 12345, nombre = Ariel y
apellido = Herrera*/
Insert Into TablaDePrueba (Dni,Nombre,Apellido) 
Select '12345','Ariel','Herrera'
Go

Select Dni,Nombre,Apellido
From TablaDePrueba
Go

Create View VistaPrueba
As
Select Articulos.CodArticulo_AR,Articulos.Descripcion_AR
From Articulos Inner Join DetalleFactura
On Articulos.CodArticulo_AR = DetalleFactura.CodArticulo_DF
Go