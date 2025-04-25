Use EJ_4_2024
Go

/* 4.1. Realizar una consulta que informe nombre del medicamento, nombre del
laboratorio y unidades en stock. */
Select	Medicamentos.Nombre_M, Laboratorios.Nombre_L,Medicamentos.Stock_M
From Medicamentos Inner Join Laboratorios
On Medicamentos.CodLaboratorio_M = Laboratorios.CodLaboratorio_L
Go

/*4.2. Realizar una consulta que informe nombre, unidades disponibles y precio unitario
de los artículos de un determinado laboratorio.*/
Select Medicamentos.Nombre_M,Medicamentos.Stock_M,Medicamentos.Precio_M
From Medicamentos Inner Join Laboratorios
On Medicamentos.CodLaboratorio_M = Laboratorios.CodLaboratorio_L
Where Laboratorios.Nombre_L = 'UNQUI'
Go

/*4.3. Realizar una consulta que informe nombre del medicamento, unidades en stock,
nombre y teléfono del laboratorio de todos aquellos productos que pasen su punto de
pedido.*/
Select Medicamentos.Nombre_M,Medicamentos.Stock_M,Laboratorios.Nombre_L,Laboratorios.Telefono_L
From Medicamentos Inner Join Laboratorios
On Medicamentos.CodLaboratorio_M = Laboratorios.CodLaboratorio_L
Where Medicamentos.CodLaboratorio_M <> 'NULL'
GO

/*4.4. Realizar una consulta que informe la mayor venta por tipo de medicamento
(jarabe, comprimido, pomada, etc.).*/
Select Medicamentos.Tipo_M, Max (DetalleVentas.Cantidad_DV) as MayorCantidad
From DetalleVentas Inner Join Medicamentos
On DetalleVentas.CodMedicamento_DV = Medicamentos.CodMedicamento_M
Group by Medicamentos.Tipo_M

Select CodMedicamento_DV,Max (DetalleVentas.Cantidad_DV) as MaximaCantidad
From DetalleVentas
Group By 