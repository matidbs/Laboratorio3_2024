
CREATE DATABASE EJcreate_240521
GO

Create Table Productos
(
--NombreTabla TipoValor NULL/NOT NULL
ProductoID char(4) NOT NULL,
NombreProducto varchar (25) NOT NULL,
PrecioProducto money NULL,
DescripcionProducto text NULL,
CONSTRAINT PK_Productos Primary Key (ProductoID)
--RESTRICCION Nombre TipoDeRestriccion (Los campos que forman la clave principal) (ProductoID,NombreProducto) <-- Si es necesario concatenar
--'Primary Key (ProductoID)' Nos permite crear la clave primaria, pero no controlamos el nombre. NO hacer asi!! 
--Cada clave primaria no se puede repetir en una base, es unica y esta restringida
)
GO

Create Table Productos
(
ProductoID char(4) NOT NULL,
ProveedorID_Prod char(4) NOT NULL,
NombreProducto varchar (25) NOT NULL,
PrecioProducto money NULL,
DescripcionProducto text NULL,
CONSTRAINT PK_Productos Primary Key (ProductoID,ProveedorID_Prod),
CONSTRAINT FK_Productos_Proveedores Foreign Key (ProveedorID_Prod) References Proveedores (CodProveedor_Pr)
)
GO

Create Table Proveedores
(
CodProveedor_Pr char(4) NOT NULL,
RazonSocial_PR varchar(25) NOT NULL,
Direccion_PR varchar(25) NOT NULL,
Ciudad_PR varchar(25) NOT NULL,
Provincia_PR varchar(25) NOT NULL,
Telefono_PR varchar(25) NOT NULL,
CUIT_PR varchar(25) NOT NULL,
Contacto_PR varchar(25) NOT NULL,
Web_PR varchar(25) NOT NULL,
Email_PR varchar(25) NOT NULL,
Constraint PK_Proveedores Primary Key (CodProveedor_PR)
)
GO
--Eliminar tabla
Drop Table Productos2
GO

Drop Table Productos
GO
