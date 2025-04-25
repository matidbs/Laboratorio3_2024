Use EJ_2_2024
GO

--Ejercicio 2 
--2.1 Realizar una consulta que informe razón social, ciudad y provincia de las empresas ubicadas en Buenos Aires.
Select RazonSocial_P,Ciudad_P,Provincia_P
From Proveedores
Where Provincia_P Like 'B%A%'
GO

/*2.2 Realizar una consulta que informe el código de artículo y el nombre,
ordenados según código de artículo en forma descendente.*/
Select CodigoArticulo_ART,Nombre_ART
From Articulos
Order By CodigoArticulo_ART Desc

--2.3 Realizar una consulta que informe las provincias en las que hay proveedores
Select distinct Provincia_P
From Proveedores
GO

/*2.4 Realizar una consulta que informe el nombre de los artículos y la cantidad
de dinero de estos en stock (cantidad X precio unitario).*/
Select Nombre_ART, PrecioUnitario_ART, Cantidad_ART, (PrecioUnitario_ART * Cantidad_ART) as DineroTotal
From Articulos

/*2.5  Realizar una consulta que informe nombre, cantidad y precio unitario de
los artículos de un determinado proveedor.*/
Select Articulos.Nombre_ART,Articulos.Cantidad_ART,Articulos.PrecioUnitario_ART
From PRxART Inner Join Articulos
On PRxART.CodigoArticulo_PRxART = Articulos.CodigoArticulo_ART
Where PRxART.Cuit_PRxART = '1234'

--Ejercico 2 Anexo

/*2.b Informe todas las facturas realizadas a un determinado cliente.*/
Select Ventas.DNI_C_V,Ventas.numeroVenta_V
From Ventas
Where DNI_C_V = '12345678'

--Si especificase que sea por nombre
Select DNI_C_V,numeroVenta_V,monto_V
From Ventas Inner Join Clientes
On Ventas.DNI_C_V = Clientes.DNI_C
Where Nombre_C = 'Lucas'

--2.c Informe todos los productos de un determinado proveedor.
Select Nombre_ART,CodigoArticulo_ART,Proveedores.RazonSocial_P
From Articulos Inner Join PRxART
On Articulos.CodigoArticulo_ART = PRxART.CodigoArticulo_PRxART Inner Join Proveedores
On PRxART.Cuit_PRxART = Proveedores.Cuit_P
Where Proveedores.Cuit_P = '1234'

--2.d Informe todos los clientes que compraron un artículo determinado.
Select CodigoArticulo_ART,Clientes.Nombre_C,Clientes.Apellido_C
From Articulos Inner Join DetalleVenta
On Articulos.CodigoArticulo_ART = DetalleVenta.codigoArticulo_ART_DV Inner Join Ventas
On DetalleVenta.numeroVenta_V_DV = Ventas.numeroVenta_V Inner Join Clientes
On Ventas.DNI_C_V = Clientes.DNI_C
Where CodigoArticulo_ART = '123'
