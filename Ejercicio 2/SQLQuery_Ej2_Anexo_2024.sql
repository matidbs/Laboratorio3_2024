Use EJ_2_2024
GO

--2.b Ingrese todas las facturas realizadas a un cliente
Select numeroVenta_V, fechaDeVenta_V, monto_V, DNI_C_V
From Ventas Inner Join Clientes 
On Ventas.DNI_C_V = Clientes.DNI_C 
Where Nombre_C = ''
GO

--2.c Informe todos los productos de un determinado proveedor
Select CodigoArticulo_ART,Nombre_ART,PrecioUnitario_ART
From (Articulos Inner Join PRxART
On Articulos.CodigoArticulo_ART = PRxART.CodigoArticulo_PRxART) Inner Join Proveedores
On PRxART.Cuit_PRxART = Proveedores.Cuit_P 
Where Proveedores.Cuit_P = ''
GO

--2.d Informe todos los clientes que compraron un articulo determinado
Select Clientes.Nombre_C, Articulos.CodigoArticulo_ART, Articulos.Nombre_ART
From (((Clientes Inner Join Ventas
On Clientes.DNI_C = Ventas.DNI_C_V) Inner Join DetalleVenta
On Ventas.numeroVenta_V = DetalleVenta.numeroVenta_V_DV) Inner Join Articulos
On DetalleVenta.codigoArticulo_ART_DV = Articulos.CodigoArticulo_ART)
Where Articulos.Nombre_ART = ''
GO
