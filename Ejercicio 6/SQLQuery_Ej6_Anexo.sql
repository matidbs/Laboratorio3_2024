Use Ej_6_2024
Go

Create table Pedidos
(
CodPedido_P char(4) Not Null,
CodProveedor_P char(4) Not null,
Fecha_P Date Not null,
EstadoPedido_P Bit Not Null Default 0,
Constraint PK_Pedidos Primary Key (CodPedido_P),
Constraint FK_Pedidos_Proveedores Foreign Key (CodProveedor_P) References Proveedores (CodProveedor_PR)
)
Go

Alter table Pedidos
Add Total_p Float null
Go

Create table DetallePedidos
(
CodPedido_Dp char(4) Not null,
CodProveedor_Dp char(4) not null,
CodArticulo_Dp char(4) not null,
Cantidad_Dp int not null,
PrecioUnitario_Dp int not null,
Constraint PK_DetallePedidos Primary Key (CodPedido_Dp,CodProveedor_Dp,CodArticulo_Dp),
Constraint FK_DetallePedidos_Articulos Foreign Key (CodProveedor_Dp,CodArticulo_Dp) References Articulos (CodProveedor_Ar,CodArticulo_Ar)
)
Go

Alter Table DetallePedidos 
Add Constraint FK_DetallePedidos_Pedidos Foreign Key (CodPedido_Dp) References Pedidos (CodPedido_P)
Go

Insert into Pedidos (CodPedido_P,CodProveedor_P,Fecha_P)
Select '001','01','2024-06-04' Union
Select '002','01','2024-09-10' Union
Select '003','02','2024-06-08' 
Go

Insert into DetallePedidos (CodPedido_Dp,CodProveedor_Dp,CodArticulo_Dp,Cantidad_Dp,PrecioUnitario_Dp)
Select '001','01','30', 100, 10 Union
Select '001','01','32', 100, 11 Union
Select '002','01','30', 100, 5 Union
Select '003','03','34', 100, 3
Go

/*Realice una actualización del stock de un determinado artículo a una cantidad
cualquiera desde una consulta. */

Create or Alter Procedure SP_ModificarStock
@StockN int, @CodArticulo char(4),@CodProv char(4)
As
Update Articulos Set Articulos.Stock_AR = @StockN 
Where Articulos.CodArticulo_AR = @CodArticulo And Articulos.CodProveedor_AR = @CodProv
Go

Exec SP_ModificarStock 150,'30','01'
Go

/*Marque un determinado pedido como cumplido*/

Create or Alter Procedure Sp_ModificarEstadoPedido
@CodPedido char(4), @Estado bit
As
Update Pedidos Set EstadoPedido_P = @Estado
Where Pedidos.CodPedido_P = @CodPedido
Go

Exec Sp_ModificarEstadoPedido '001',1
Go

/*. Informe las tres primeras letras de la descripción de un artículo y su cantidad en stock*/

Select Left (Articulos.Descripcion_AR,3) as [3 primeras letras], Articulos.Descripcion_AR ,Articulos.Stock_AR
From Articulos
Where Descripcion_AR = 'Prod 1'
Go


/*Consulte la existencia de la tabla pedidos, si no existiera créela. */
If Not Exists (Select * From INFORMATION_SCHEMA.TABLES Where TABLE_NAME = 'Pedidos')
Begin 
	Create table Pedidos
(
CodPedido_P char(4) Not Null,
CodProveedor_P char(4) Not null,
Fecha_P Date Not null,
EstadoPedido_P Bit Not Null Default 0,
Constraint PK_Pedidos Primary Key (CodPedido_P),
Constraint FK_Pedidos_Proveedores Foreign Key (CodProveedor_P) References Proveedores (CodProveedor_PR)
)
End
Else 
Print 'Ya existe la tabla pedidos'
Go
/*. Cree un procedimiento almacenado que introduzca un registro en la tabla pedidos de
cualquier artículo con la fecha del momento de la registración. */

Create or Alter procedure Sp_AgregarPedido
@CodPedido char(4),@CodProveedor char(4)
As
Insert into Pedidos (CodPedido_P,CodProveedor_P,Fecha_P)
Select @CodPedido,@CodProveedor,(SELECT CONVERT(VARCHAR(10), GETDATE(), 102) AS [YYYY-MM-DD])
Go

Exec Sp_AgregarPedido '005','02'
Go

/*Realice una consulta que informe todos los proveedores con razón social en mayúscula y
los contactos en minúsculas. */

Select Upper (Proveedores.RazonSocial_PR) as [Razon Social], Lower (Proveedores.Contacto_PR) as Contacto
From Proveedores
Go

/*Crear un trigger en la tabla Detalle de ventas o Detalle de Facturas llamado SUMATOTAL
que por cada artículo agregado al detalle multiplique el precio unitario por la cantidad y
sume el resultado al total en la tabla Facturas o Ventas. */

Create or Alter Trigger TR_SumaTotalDF
On DetalleFactura
After Insert
As
Begin
Set Nocount on
Declare @CodFactura char(4), @TotalDP float
Select @CodFactura = CodFactura_DF, @TotalDP = (PrecioUnitario_DF * Cantidad_DF)
From inserted

Update Facturas Set TotalFactura_FA = TotalFactura_FA + @TotalDP Where CodFactura_FA = @CodFactura
End


/*Crear un trigger en la tabla Detalle de ventas o Detalle de Facturas llamado BAJASTOCK 
que por cada artículo agregado al detalle descuente la cantidad en la tabla correspondiente 
que lleve el stock*/

Create or Alter Trigger TR_BajaStockDF
On DetalleFactura
After Insert
As
Begin
Declare @CodPr char(4), @CodArt char(4), @Cant int

Select @CodPr = CodProveedor_DF, @CodArt = CodArticulo_DF, @Cant = Cantidad_DF
From inserted

IF (@Cant) <= (Select Stock_AR From Articulos Where CodProveedor_AR = @CodPr And CodArticulo_AR = @CodArt)

Update Articulos Set Stock_AR = Stock_AR - @Cant Where CodProveedor_AR = @CodPr And CodArticulo_AR = @CodArt

Else

	Rollback

End
