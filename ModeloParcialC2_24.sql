CREATE DATABASE Practica2Lab3_2
ON
( NAME = Practica2Lab3_2,
 FILENAME = 'C:\BASES\Practica2Lab3_2.mdf' )
GO 

Use Practica2Lab3_2
Go

Create table Clientes
(
Dni_cli char(8) not null,
Nombre_cli varchar(20) not null,
Apellido_cli varchar(20) not null,
Direccion_cli varchar(20) not null,
CodPostal_cli varchar(20) not null,
Provincia_cli varchar(20) not null,
Telefono_cli varchar(20) not null,
Estado_cli bit not null default 0,
Constraint PK_Clientes Primary Key (Dni_cli)
)
Go

Alter table clientes
Add Ciudad_cli varchar(20) not null
Go

Create table Tipo_Cuentas
(
CodTCuenta_tcue char(4) not null,
DescTCuenta_tcue nchar(20) not null,
Constraint PK_Tipo_Cuentas Primary Key (CodTCuenta_tcue)
)
GO

Create table Cuentas
(
CodCuenta_cue char(4) not null,
CodTCuenta_cue char(4) not null,
SaldoCuenta_cue decimal (8,2) not null default 0,
DniCliente_cue char(8) not null,
Estado_cue bit not null default 0
Constraint PK_Cuentas Primary key (CodCuenta_cue),
Constraint FK_Cuentas_Clientes Foreign key (DniCliente_cue) References Clientes (Dni_cli),
Constraint FK_Cuentas_Tipo_Cuentas Foreign Key (CodTCuenta_cue) References Tipo_Cuentas (CodTCuenta_tcue)
)
Go

Create table Auditoria 
(
CodAuditoria_audit int identity (1,1),
DniCliente_audit char(8) not null,
Fecha_audit smalldatetime not null,
Estado_audit bit not null 
Constraint PK_Auditoria Primary key (CodAuditoria_audit),
Constraint FK_Auditoria_Clientes Foreign key (DniCliente_audit) References Clientes (Dni_cli)
)
Go

Insert into Clientes (Dni_cli,Nombre_cli,Apellido_cli,Direccion_cli,Ciudad_cli,CodPostal_cli,Provincia_cli,Telefono_cli)
Select '10909090','Alejo','Gomez','Buenos Aires 21','General Pacheco','1618','Buenos Aires','1199201010' Union
Select '87654321','Franco','De Palma','Roma 200','Garin','1615','Buenos Aires','1112121212'
Go

Insert into Tipo_Cuentas (CodTCuenta_tcue,DescTCuenta_tcue)
Select '0001','Tipo de cuenta 1' Union
Select '0002','Tipo de cuenta 2'

Insert into Cuentas (CodCuenta_cue,CodTCuenta_cue,SaldoCuenta_cue,DniCliente_cue)
Select '1000','0002',1200,'10909090' Union
Select '1001','0001',500,'87654321'

Insert into Auditoria (DniCliente_audit,Fecha_audit,Estado_audit)
Select '10909090',(Select GETDATE()),1 Union
Select '10909090',(Select GETDATE()),0 

/*Realice procedimiento almacenado que ejecute una consulta que devuelva
nombre y apellido en un campo llamado “NOMBRE_COMPLETO” de todos los
clientes registrados en una determinada ciudad, ingresando la variable CodPostal.*/

Create or Alter Procedure SP_DevolverNombreCompleto
@CodPostal varchar(20)
As
Select CONCAT(Nombre_cli, ' ', Apellido_cli) as Nombre_Completo
From Clientes
Where CodPostal_cli = @CodPostal
Go

Exec SP_DevolverNombreCompleto '1615'
GO

/*Realice un trigger que inserte un registro en la tabla “Auditoria” cuando se
modifique el estado de un cliente (Dni_cli, fecha de modificación y el nuevo estado
que se asume).*/

Create or Alter Trigger Tr_CambioEstadoCliente
On Clientes
After Update
As
Begin 
Declare @DNI char(8), @Estado bit

Select @DNI = Dni_cli, @Estado = Estado_cli
From deleted

If(Select Estado_cli From inserted Where Dni_cli = @DNI) != @Estado
Insert into Auditoria (DniCliente_audit,Fecha_audit,Estado_audit)
Select @DNI,(Select GETDATE()),(Select Estado_cli From Clientes Where Dni_cli = @DNI)
End

Update Clientes Set Estado_cli = 0 Where Dni_cli = '10909090'

Update Clientes Set Estado_cli = 1 Where Dni_cli = '10909090'

Update Clientes Set Estado_cli = 1 Where Dni_cli = '87654321'

Update Clientes Set Estado_cli = 0 Where Dni_cli = '87654321'

	