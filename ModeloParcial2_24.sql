CREATE DATABASE PracticaLab3_2
ON
( NAME = PracticaLab3_2,
 FILENAME = 'C:\BASES\PracticaLab3_2.mdf' )
GO 

Use PracticaLab3_2 
Go

Create Table Proveedores
(
CodProv_pr char(10) NOT NULL,
RazonSocProv_pr varchar(50) NOT NULL,
TelProv_pr varchar(20) NOT NULL,
MailProv_pr varchar(30) NULL,
Constraint PK_Proveedores Primary Key (CodProv_pr)
)
Go

Create table Articulos
(
CodArt_a char(10) NOT NULL,
DescArt_a varchar(10) not null,
StockArt_a int not null default 0,
PuntoPedidoArt_a int not null default 0,
ActivoArt_a bit not null default 1,
CodProv_a char(10) not null,
Constraint PK_Articulos Primary Key (CodArt_a),
Constraint FK_Articulos_Proveedores Foreign Key (CodProv_a) References Proveedores (CodProv_pr)
)
Go

Alter table Articulos
Add PrecioUnitArt_a decimal(8,2) not null default 0
Go

Create Table Facturas
(
NumFact_f int identity(1,1) not null,
FechaFact_f date not null,
TotalFact_f decimal (8,2) not null default 0,
Constraint PK_Facturas Primary Key (NumFact_f)
)
Go

Create table DetalleDeFacturas
(
NumFact_df int not null,
CodArt_df char(10) not null,
CantArt_df int not null,
PrecioUnitArt_df decimal(8,2) not null
Constraint PK_DetalleDeFacturas Primary key (NumFact_df,CodArt_df),
Constraint FK_DetalleDeFacturas_Articulos Foreign key (CodArt_df) References Articulos (CodArt_a)
)
Go

Create table EstadosArticulos
(
CodEstArt_ea int not null identity(1,1),
CodArt_ea char(10) not null,
EstadoArt_ea bit not null,
FechaCambio_ea date not null,
Constraint PK_EstadosArticulos Primary Key (CodEstArt_ea),
Constraint FK_EstadosArticulos_Articulos Foreign key (CodArt_ea) References Articulos (CodArt_a)
)
Go

Insert into Proveedores (CodProv_pr,RazonSocProv_pr,TelProv_pr)
Select '10','FedeProv','11221122' Union
Select '11','GustavoProv','22332233'
GO

Insert into Articulos (CodArt_a,DescArt_a,StockArt_a,PrecioUnitArt_a,PuntoPedidoArt_a,CodProv_a)
Select '90','Ojotas',150,1200,1,'10' Union
Select '91','Camisa',600,700,2,'11'

Insert into Facturas (FechaFact_f,TotalFact_f)
Select '04-04-2024',20000 Union
Select '12-04-2024',1500 

Insert into DetalleDeFacturas (NumFact_df,CodArt_df,CantArt_df,PrecioUnitArt_df)
Select 1,'90',10,1200 Union
Select 1,'91',2,700 Union
Select 2,'90',7,700

Insert into EstadosArticulos (CodArt_ea,EstadoArt_ea,FechaCambio_ea)
Select '90',0,'23-06-2024' Union
Select '90',1,'25-06-2024'

/*Realice una consulta que devuelva el código y la descripción de todos los Artículos
desactivados de un proveedor determinado (RazonSocProv_Pr) a su elección.*/

Select CodArt_a,DescArt_a
From Articulos Inner Join Proveedores 
On Articulos.CodProv_a = Proveedores.CodProv_pr
Where Articulos.ActivoArt_a = 0 And Proveedores.RazonSocProv_pr = 'FedeProv'
Go

Update Articulos Set ActivoArt_a = 0 Where CodArt_a = '90'

/*Realice un Procedimiento Almacenado llamado SP_Información_Proveedor que ejecute
una consulta que devuelva el código del proveedor, su razón social, su número de
teléfono y su dirección de correo electrónico ingresando la variable @CodArt.*/

Create Procedure SP_Informacion_Proveedor
@CodArt char(10)
as
Select CodProv_pr,RazonSocProv_pr,TelProv_pr,MailProv_pr
From Proveedores Inner Join Articulos
On Proveedores.CodProv_pr = Articulos.CodProv_a
Where CodArt_a = @CodArt
Go

Exec SP_Informacion_Proveedor '90'
Go

/*Realice un Trigger que ingrese un registro en la tabla EstadosArticulos indicando el
artículo, el estado que toma y la fecha y hora del cambio, cuando se modifique el valor
del campo ActivoArt_A de un determinado artículo.*/

Create or alter trigger Tr_CambioEstado
On Articulos After Update
As
Begin
Declare @EstadoA bit, @CodArt char(10)

Select @EstadoA = deleted.ActivoArt_a, @CodArt = deleted.CodArt_a
From deleted

If (Select ActivoArt_a From inserted Where CodArt_a = @CodArt) != @EstadoA
Insert into EstadosArticulos (CodArt_ea,EstadoArt_ea,FechaCambio_ea)
Select @CodArt,(Select ActivoArt_a From Inserted Where CodArt_a = @CodArt),(Select GETDATE())
End
Go

Update Articulos Set ActivoArt_a = 0 Where CodArt_a = '90'


------------------------------------------------

Create Table AuditoriaArticulos
(
CodAuditArt_aa int identity(1,1) not null,
CodArt_aa char(10) not null,
Cant_aa int not null,
FechaIngreso_aa date not null,
Constraint PK_AuditoriaArticulos Primary key (CodAuditArt_aa),
Constraint FK_AuditoriaArticulos_Articulos Foreign key (CodArt_aa) References Articulos (CodArt_a)
)
Go

/*Realice una consulta que devuelva todos los articulos
 y la suma en unidades vendida hasta el momento como 
 SumaCantV (CodArt_A,DescArt_A,SumaCant_A)*/

 Select CodArt_a, DescArt_a, SUM (DetalleDeFacturas.CantArt_df) As SumaCantV
 From Articulos Inner Join DetalleDeFacturas
 On Articulos.CodArt_a = DetalleDeFacturas.CodArt_df
 Group by CodArt_a,DescArt_a

 /*Realice un Trigger que ingrese un registro en la tabla
 AuditoriaArticulos indicando el articulo, la cantidad actualizada
 en stock, y la fecha y hora del movimiento, cuando se modifique
 el stock de cualquier articulo*/

 Create or Alter trigger TR_ModificacionStock
 On Articulos
 After Update
 As
 Begin

 If (Select StockArt_a From inserted) != (Select StockArt_a From deleted)
 Insert into AuditoriaArticulos (CodArt_aa,Cant_aa,FechaIngreso_aa)
 Select (Select CodArt_a From inserted), (Select StockArt_a From inserted), GETDATE()
 End

 Update Articulos Set StockArt_a = 250 Where CodArt_a = '90'