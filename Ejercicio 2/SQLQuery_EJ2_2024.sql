USE EJ_2_2024
GO

--2.1
Select RazonSocial_P,Ciudad_P,Provincia_P 
From Proveedores 
Where Provincia_P = 'Buenos Aires'
GO

--2.2
Select CodigoArticulo_ART,Nombre_ART 
From Articulos 
Order By CodigoArticulo_ART DESC
GO

/*
Select CodigoArticulo_ART,Nombre_ART 
From Articulos 
Order By CodigoArticulo_ART DESC, Nombre_ART ASC
GO
*/

--2.3
Select distinct Provincia_P 
From Proveedores
GO

--2.4
Select Nombre_ART, Cantidad_ART * PrecioUnitario_ART 
AS DineroEnStock_ART --Es un alias 
From Articulos
GO

--2.5
Select Nombre_ART,Cantidad_ART,PrecioUnitario_ART,Cuit_PRxART
From Articulos Inner Join PRxART
On CodigoArticulo_ART = CodigoArticulo_PRxART
Where Cuit_PRxART = '1234'
GO

--2.5 v2
Select Nombre_ART,Cantidad_ART,PrecioUnitario_ART,Cuit_PRxART
From (Articulos Inner Join PRxART
On CodigoArticulo_ART = CodigoArticulo_PRxART) Inner Join Proveedores
On PRxART.Cuit_PRxART = Cuit_PRxART
Where RazonSocial_P = '' And Cantidad_ART < 20
GO